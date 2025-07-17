package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import modelo.Reembolso;
import modelo.dao.ReembolsoDAO;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/registrarReembolso")
public class RegistrarReembolsoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener parámetros del formulario
            int pedidoId = Integer.parseInt(request.getParameter("pedidoId"));
            String motivo = request.getParameter("motivo");
            String comentario = request.getParameter("comentario");

            // Obtener usuario desde sesión
            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if (usuario == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Crear objeto Reembolso
            Reembolso r = new Reembolso();
            r.setPedidoId(pedidoId);
            r.setUsuarioId(usuario.getId());
            r.setMotivo(motivo);
            r.setObservacionesAdmin(comentario); // Comentario inicial del usuario
            r.setEstado("pendiente");

            // Guardar en la base de datos
            ReembolsoDAO dao = new ReembolsoDAO();
            boolean exito = dao.registrarReembolso(r);

            // Redireccionar con mensaje
            if (exito) {
                session.setAttribute("mensajeReembolso", "✅ Solicitud de reembolso enviada correctamente.");
            } else {
                session.setAttribute("mensajeReembolso", "❌ Error al enviar la solicitud. Verifica el número de pedido.");
            }

            response.sendRedirect("Reembolsos.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("mensajeReembolso", "❌ Error inesperado al procesar el reembolso.");
            response.sendRedirect("Reembolsos.jsp");
        }
    }
}
