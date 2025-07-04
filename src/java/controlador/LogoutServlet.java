package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtener sesión actual (si existe)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Invalida la sesión (cierra sesión)
            session.invalidate();
        }

        // Redirige al login
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}


