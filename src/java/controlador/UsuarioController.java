package controlador;

import modelo.Usuario;
import util.Conexion;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreCompleto = request.getParameter("nombreCompleto");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String contrasena = request.getParameter("contrasena");
        

        // Validación básica de campos vacíos
        if (nombreCompleto == null || correo == null || telefono == null || direccion == null || contrasena == null ||
            nombreCompleto.trim().isEmpty() || correo.trim().isEmpty() || telefono.trim().isEmpty() ||
            direccion.trim().isEmpty() || contrasena.trim().isEmpty()) {
            System.out.println("Error: campos vacíos");
            response.sendRedirect("registro.jsp?error=campos_vacios");
            return;
        }

        try {
            Connection con = Conexion.getInstancia().getConexion();
            if (con == null) {
                System.out.println("Error: conexión nula");
                response.sendRedirect("registro.jsp?error=conexion");
                return;
            }

            String sql = "INSERT INTO usuario (nombre_completo, correo, telefono, direccion, contrasena) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = (PreparedStatement) con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, nombreCompleto);
            ps.setString(2, correo);
            ps.setString(3, telefono);
            ps.setString(4, direccion);
            ps.setString(5, contrasena);
            ps.setString(6, "USUARIO");

            int filas = ps.executeUpdate();
            if (filas == 0) {
                System.out.println("Error: no se insertó ningún usuario");
                response.sendRedirect("registro.jsp?error=no_insertado");
                return;
            }

            ResultSet rs = ps.getGeneratedKeys();
            int idGenerado = 0;
            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }

            Usuario usuarioConId = new Usuario(idGenerado, nombreCompleto, correo, telefono, direccion, contrasena, "USUARIO");
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioConId);

            System.out.println("Usuario registrado con ID: " + idGenerado);
            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registro.jsp?error=excepcion");
        }
    }
}





