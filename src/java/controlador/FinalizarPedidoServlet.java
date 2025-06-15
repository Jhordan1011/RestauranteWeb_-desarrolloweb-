package controlador;

import fachada.PedidoFacade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.DetallePedido;
import modelo.Pedido;

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
            //session.removeAttribute("pedido");
            response.sendRedirect("pedido_confirmado.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}

