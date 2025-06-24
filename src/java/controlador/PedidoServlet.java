package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.DetallePedido;
import modelo.Pedido;
import modelo.Usuario;

@WebServlet(name = "PedidoServlet", value = "/PedidoServlet")
public class PedidoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // 1. Obtener el usuario logueado
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Obtener o crear el pedido en la sesión
        Pedido pedido = (Pedido) session.getAttribute("pedido");
        if (pedido == null) {
            pedido = new Pedido();
            pedido.setUsuarioId(usuario.getId());
            session.setAttribute("pedido", pedido);
        }

        // 3. Leer parámetros del formulario
        int platoId = Integer.parseInt(request.getParameter("platoId"));
        String nombrePlato = request.getParameter("nombrePlato");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int restauranteId = Integer.parseInt(request.getParameter("restauranteId"));

        System.out.println("Restaurante recibido en PedidoServlet: " + restauranteId);

        // ✅ 4. Asignar restauranteId al pedido directamente (CORRECCIÓN)
        

        // 5. Crear el detalle del pedido
        DetallePedido detalle = new DetallePedido();
        detalle.setPlatoId(platoId);
        detalle.setNombrePlato(nombrePlato);
        detalle.setCantidad(1);
        detalle.setPrecioUnitario(precio);
        detalle.setSubtotal(precio * detalle.getCantidad());
        detalle.setRestauranteId(restauranteId);

        // 6. Agregar detalle al pedido
        pedido.getDetalles().add(detalle);

        // 7. Calcular total
        double total = 0.0;
        for (DetallePedido d : pedido.getDetalles()) {
            total += d.getSubtotal();
        }
        pedido.setTotal(total);

        // 8. Redirigir al JSP del pedido
        response.sendRedirect("ver_pedido.jsp");
    }
}
