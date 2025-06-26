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
import java.util.*;

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

            // ✅ Obtener restaurantes involucrados en el pedido
            Set<Integer> idsRestaurantes = new HashSet<>();
            for (DetallePedido detalle : pedido.getDetalles()) {
                idsRestaurantes.add(detalle.getRestauranteId());
            }

            List<Restaurante> restaurantesInvolucrados = new ArrayList<>();
            for (int id : idsRestaurantes) {
                Restaurante r = restauranteDAO.buscarPorId(id);
                if (r != null) {
                    restaurantesInvolucrados.add(r);
                    System.out.println("✔ Restaurante agregado: " + r.getNombre());
                }
            }

            // ✅ Guardar en sesión
            session.setAttribute("restaurantesInvolucrados", restaurantesInvolucrados);

            // Coordenadas del primer restaurante (para el mapa)
// Obtener primer restaurante de los involucrados (para el mapa)
Restaurante restauranteMapa = null;
if (!restaurantesInvolucrados.isEmpty()) {
    restauranteMapa = restaurantesInvolucrados.get(0);
}

if (restauranteMapa != null) {
    session.setAttribute("latRestaurante", restauranteMapa.getLatitud());
    session.setAttribute("lonRestaurante", restauranteMapa.getLongitud());
  
StringBuilder telefonos = new StringBuilder();
for (Restaurante r : restaurantesInvolucrados) {
    telefonos.append(r.getNombre()).append(": ").append(r.getTelefono()).append("<br>");
}
session.setAttribute("telefonosRestaurantes", telefonos.toString());

    
} else {
    session.setAttribute("latRestaurante", -12.1220);
    session.setAttribute("lonRestaurante", -77.0300);
    
}



            // Geolocalizar dirección del cliente con Nominatim
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
                HttpsURLConnection.setDefaultHostnameVerifier((hostname, sessionSSL) -> true);

                String direccionCodificada = URLEncoder.encode(direccion, "UTF-8");
                String urlStr = "https://nominatim.openstreetmap.org/search?q=" + direccionCodificada + "&format=json&limit=1";

                URL url = new URL(urlStr);
                HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
                con.setRequestMethod("GET");
                con.setRequestProperty("User-Agent", "MiRestauranteApp/1.0 (contreras10@openai.com)");

                int responseCode = con.getResponseCode();

                if (responseCode == 200) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                    StringBuilder json = new StringBuilder();
                    String inputLine;
                    while ((inputLine = in.readLine()) != null) {
                        json.append(inputLine);
                    }
                    in.close();

                    JSONArray array = new JSONArray(json.toString());
                    if (!array.isEmpty()) {
                        JSONObject obj = array.getJSONObject(0);
                        double lat = obj.getDouble("lat");
                        double lon = obj.getDouble("lon");
                        session.setAttribute("latCliente", lat);
                        session.setAttribute("lonCliente", lon);
                    } else {
                        session.setAttribute("latCliente", -12.1070);
                        session.setAttribute("lonCliente", -77.0050);
                    }
                } else {
                    session.setAttribute("latCliente", -12.1070);
                    session.setAttribute("lonCliente", -77.0050);
                }

            } catch (Exception e) {
                session.setAttribute("latCliente", -12.1070);
                session.setAttribute("lonCliente", -77.0050);
            }

            // Guardar resumen de platos para la boleta
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
            session.setAttribute("ultimoMetodoPago", metodoPagoStr);

            response.sendRedirect("pedido_confirmado.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}





