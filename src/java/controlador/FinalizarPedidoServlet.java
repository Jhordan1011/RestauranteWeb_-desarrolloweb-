package controlador;

import fachada.PedidoFacade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.DetallePedido;
import modelo.Pedido;
import modelo.Restaurante;
import modelo.dao.RestauranteDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.net.ssl.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.cert.X509Certificate;

@WebServlet(name = "FinalizarPedidoServlet", value = "/FinalizarPedidoServlet")
public class FinalizarPedidoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Pedido pedido = (Pedido) session.getAttribute("pedido");

        if (pedido == null || pedido.getDetalles().isEmpty()) {
            response.sendRedirect("ver_pedido.jsp");
            return;
        }

        String direccion = request.getParameter("direccion");
        String notas = request.getParameter("notas");
        String metodoPagoStr = request.getParameter("metodoPago");

        pedido.setDireccionEntrega(direccion);
        pedido.setNotas(notas);
        pedido.setMetodoPago(Pedido.MetodoPago.valueOf(metodoPagoStr));

        PedidoFacade facade = new PedidoFacade();
        boolean exito = facade.guardarPedido(pedido);

        if (exito) {
            RestauranteDAO restauranteDAO = new RestauranteDAO();
            Restaurante restaurante = restauranteDAO.buscarPorId(pedido.getRestauranteId());
            if (restaurante != null) {
                session.setAttribute("latRestaurante", restaurante.getLatitud());
                session.setAttribute("lonRestaurante", restaurante.getLongitud());
            } else {
                session.setAttribute("latRestaurante", -12.1220);
                session.setAttribute("lonRestaurante", -77.0300);
            }

            // ✅ Ignorar SSL en entorno de desarrollo
            try {
                TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        public void checkClientTrusted(X509Certificate[] certs, String authType) {}
                        public void checkServerTrusted(X509Certificate[] certs, String authType) {}
                        public X509Certificate[] getAcceptedIssuers() { return null; }
                    }
                };

                SSLContext sc = SSLContext.getInstance("SSL");
                sc.init(null, trustAllCerts, new java.security.SecureRandom());
                HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

                // Ignora verificación de nombre de host
                HttpsURLConnection.setDefaultHostnameVerifier((hostname, sessionSSL) -> true);

                String direccionCodificada = URLEncoder.encode(direccion, "UTF-8");
                String urlStr = "https://nominatim.openstreetmap.org/search?q=" + direccionCodificada + "&format=json&limit=1";

                URL url = new URL(urlStr);
                HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
                con.setRequestMethod("GET");
                con.setRequestProperty("User-Agent", "MiRestauranteApp/1.0 (contreras10@openai.com)");

                int responseCode = con.getResponseCode();
                System.out.println("✅ Código HTTP respuesta: " + responseCode);

                if (responseCode == 200) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                    StringBuilder json = new StringBuilder();
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        json.append(inputLine);
                    }
                    in.close();

                    System.out.println("🔍 JSON recibido de Nominatim:");
                    System.out.println(json.toString());

                    JSONArray array = new JSONArray(json.toString());
                    if (!array.isEmpty()) {
                        JSONObject obj = array.getJSONObject(0);
                        double lat = obj.getDouble("lat");
                        double lon = obj.getDouble("lon");
                        session.setAttribute("latCliente", lat);
                        session.setAttribute("lonCliente", lon);
                        System.out.println("✅ Coordenadas cliente: " + lat + ", " + lon);
                    } else {
                        session.setAttribute("latCliente", -12.1070);
                        session.setAttribute("lonCliente", -77.0050);
                    }
                } else {
                    System.out.println("❌ Nominatim no devolvió respuesta válida.");
                    session.setAttribute("latCliente", -12.1070);
                    session.setAttribute("lonCliente", -77.0050);
                }

            } catch (Exception e) {
                System.out.println("⚠️ Error al obtener coordenadas del cliente:");
                e.printStackTrace();
                session.setAttribute("latCliente", -12.1070);
                session.setAttribute("lonCliente", -77.0050);
            }

            StringBuilder descripcion = new StringBuilder();
            for (DetallePedido d : pedido.getDetalles()) {
                descripcion.append(d.getNombrePlato())
                        .append(" - S/")
                        .append(d.getPrecioUnitario())
                        .append(", ");
            }
            if (descripcion.length() > 0) {
                descripcion.setLength(descripcion.length() - 2);
            }

            session.setAttribute("ultimoPedidoDescripcion", descripcion.toString());
            session.setAttribute("ultimoPedidoDireccion", direccion);
            session.setAttribute("ultimoPedidoTelefono", request.getParameter("telefono"));
            session.setAttribute("ultimoMetodoPago", metodoPagoStr);

            response.sendRedirect("pedido_confirmado.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}


