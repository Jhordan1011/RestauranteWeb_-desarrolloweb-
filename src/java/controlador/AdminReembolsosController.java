package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import modelo.Reembolso;
import modelo.dao.ReembolsoDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminReembolsos")
public class AdminReembolsosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReembolsoDAO dao = new ReembolsoDAO();
        List<Reembolso> lista = dao.listarReembolsos();

        request.setAttribute("reembolsos", lista);
        request.getRequestDispatcher("AdminReembolsos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("responder".equals(accion)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String estado = request.getParameter("estado");
                String observaciones = request.getParameter("observaciones");

                ReembolsoDAO dao = new ReembolsoDAO();
                dao.actualizarEstado(id, estado, observaciones);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Volver a cargar la lista actualizada
        response.sendRedirect("adminReembolsos");
    }
}
