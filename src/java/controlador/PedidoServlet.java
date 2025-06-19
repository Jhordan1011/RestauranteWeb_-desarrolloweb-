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
import modelo.Usuario; // Importa la clase Usuario

@WebServlet(name = "PedidoServlet", value = "/PedidoServlet")
public class PedidoServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 1. Obtener el usuario logueado (ESENCIAL)
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Obtener o crear el pedido en la sesión
        Pedido pedido = (Pedido) session.getAttribute("pedido");
        if (pedido == null) {
            pedido = new Pedido();
            // 3. Asignar el ID del usuario al pedido (SOLUCIÓN AL ERROR)
            pedido.setUsuarioId(usuario.getId());
            session.setAttribute("pedido", pedido);
        }

        // 4. Leer parámetros del formulario
        int platoId = Integer.parseInt(request.getParameter("platoId"));
        String nombrePlato = request.getParameter("nombrePlato");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int restauranteId = Integer.parseInt(request.getParameter("restauranteId"));

        // 5. Asignar restaurante al pedido
        //pedido.setRestauranteID(restauranteId);

        // 6. Crear nuevo detalle de pedido
        DetallePedido detalle = new DetallePedido();
        detalle.setPlatoId(platoId);
        detalle.setNombrePlato(nombrePlato);
        detalle.setCantidad(1);
        detalle.setPrecioUnitario(precio);
        detalle.setSubtotal(precio * detalle.getCantidad());
        detalle.setRestauranteId(restauranteId); //

        // 7. Agregar al pedido
        pedido.getDetalles().add(detalle);

        // 8. Actualizar total
        double total = 0.0;
        for (DetallePedido d : pedido.getDetalles()) {
            total += d.getSubtotal();
        }
        pedido.setTotal(total);

        // 9. Redirigir al JSP que muestra el pedido acumulado
        response.sendRedirect("ver_pedido.jsp");
    }    
}