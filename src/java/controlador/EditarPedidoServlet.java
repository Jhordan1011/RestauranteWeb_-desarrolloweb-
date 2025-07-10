package controlador;

import fachada.PedidoFacade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import modelo.Pedido;

@WebServlet("/EditarPedidoServlet")
public class EditarPedidoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String estado = request.getParameter("estado");
        String direccion = request.getParameter("direccion");
        String notas = request.getParameter("notas");
        String metodoPagoStr = request.getParameter("metodoPago");

        Pedido pedido = new Pedido();
        pedido.setId(id);
        pedido.setEstado(estado);
        pedido.setDireccionEntrega(direccion);
        pedido.setNotas(notas);
        pedido.setMetodoPago(Pedido.MetodoPago.valueOf(metodoPagoStr.toUpperCase()));

        PedidoFacade facade = new PedidoFacade();
        boolean success = facade.editarPedido(pedido);

        if (success) {
            response.sendRedirect("adminPedidos"); 
        } else {
            request.setAttribute("error", "Error al editar el pedido.");
            request.getRequestDispatcher("AdminI.jsp").forward(request, response);
        }
    }
}

