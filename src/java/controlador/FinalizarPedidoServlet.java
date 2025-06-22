package controlador;

import fachada.PedidoFacade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.DetallePedido;
import modelo.Pedido;
import modelo.Restaurante;
import modelo.dao.RestauranteDAO;

import java.io.IOException;

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

        // Captura datos del formulario
        String direccion = request.getParameter("direccion");
        String notas = request.getParameter("notas");
        String metodoPagoStr = request.getParameter("metodoPago");

        // Actualiza el objeto pedido
        pedido.setDireccionEntrega(direccion);
        pedido.setNotas(notas);
        pedido.setMetodoPago(Pedido.MetodoPago.valueOf(metodoPagoStr));

        // ✅ Aplica el patrón Facade
        PedidoFacade facade = new PedidoFacade();
        boolean exito = facade.guardarPedido(pedido);

        if (exito) {
            // 🟨 NUEVO: Obtener coordenadas del restaurante
            RestauranteDAO restauranteDAO = new RestauranteDAO();
            Restaurante restaurante = restauranteDAO.buscarPorId(pedido.getRestauranteId());
            if (restaurante != null) {
                session.setAttribute("latRestaurante", restaurante.getLatitud());
                session.setAttribute("lonRestaurante", restaurante.getLongitud());
            } else {
                session.setAttribute("latRestaurante", -12.1220); // valor por defecto
                session.setAttribute("lonRestaurante", -77.0300);
            }

            // 🟨 TEMPORAL: Coordenadas fijas del cliente (si no tienes geocodificación aún)
            session.setAttribute("latCliente", -12.1070);
            session.setAttribute("lonCliente", -77.0050);

            
            System.out.println("Restaurante obtenido: " + (restaurante != null ? restaurante.getNombre() : "NO ENCONTRADO"));
System.out.println("Lat: " + (restaurante != null ? restaurante.getLatitud() : "sin lat"));
System.out.println("Lon: " + (restaurante != null ? restaurante.getLongitud() : "sin lon"));

            
            
            // 🟨 Guardar datos para boleta y seguimiento
            StringBuilder descripcion = new StringBuilder();
            for (DetallePedido d : pedido.getDetalles()) {
                descripcion.append(d.getNombrePlato())
                           .append(" - S/")
                           .append(d.getPrecioUnitario())
                           .append(", ");
            }
            if (descripcion.length() > 0) {
                descripcion.setLength(descripcion.length() - 2); // quitar última coma
            }

            session.setAttribute("ultimoPedidoDescripcion", descripcion.toString());
            session.setAttribute("ultimoPedidoDireccion", direccion);
            session.setAttribute("ultimoPedidoTelefono", request.getParameter("telefono")); // si lo capturas
            session.setAttribute("ultimoMetodoPago", metodoPagoStr);

            // Redirigir a la boleta
            response.sendRedirect("pedido_confirmado.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}



