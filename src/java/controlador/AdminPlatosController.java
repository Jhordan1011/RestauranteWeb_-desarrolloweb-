package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import modelo.Platos;
import modelo.Restaurante;
import util.Conexion;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)

@WebServlet("/adminPlatos")
public class AdminPlatosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Platos> platos = obtenerTodosLosPlatos();
        request.setAttribute("platos", platos);
        request.getRequestDispatcher("/AdminPlatos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        switch (accion) {
            case "crear":
                crearPlato(request);
                break;
            case "editar":
                editarPlato(request);
                break;
            case "eliminar":
                eliminarPlato(request);
                break;
        }

        response.sendRedirect("adminPlatos");
    }

    
    private List<Platos> obtenerTodosLosPlatos() {
    List<Platos> lista = new ArrayList<>();
    String sql = "SELECT p.id, p.nombre, p.precio, p.imagen_url, p.restaurante_id, " +
                 "r.nombre AS nombre_restaurante " +
                 "FROM platos p " +
                 "JOIN restaurantes r ON p.restaurante_id = r.id";

    try (Connection conn = Conexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Platos p = new Platos();
            p.setId(rs.getInt("id"));
            p.setNombre(rs.getString("nombre"));
            p.setPrecio(rs.getDouble("precio"));
            p.setImagenUrl(rs.getString("imagen_url"));
            p.setRestauranteId(rs.getInt("restaurante_id"));

            Restaurante r = new Restaurante();
            r.setId(rs.getInt("restaurante_id"));
            r.setNombre(rs.getString("nombre_restaurante"));

            p.setRestaurante(r);

            lista.add(p);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return lista;
}


    //Crear platos
    private void crearPlato(HttpServletRequest request) {
        try {
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            Part imagenPart = request.getPart("imagen");
            String nombreImagen = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/") + "img";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            imagenPart.write(uploadPath + File.separator + nombreImagen);
            String imagenUrl = "img/" + nombreImagen;

            int restauranteId = Integer.parseInt(request.getParameter("restauranteId"));

            Connection conn = Conexion.getConnection();
            String sql = "INSERT INTO platos (nombre, precio, imagen_url, restaurante_id) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setDouble(2, precio);
            stmt.setString(3, imagenUrl);
            stmt.setInt(4, restauranteId);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Editar platos
    private void editarPlato(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String imagenUrl = request.getParameter("imagenUrl");
            int restauranteId = Integer.parseInt(request.getParameter("restauranteId"));

            Connection conn = Conexion.getConnection();
            String sql = "UPDATE platos SET nombre=?, precio=?, imagen_url=?, restaurante_id=? WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombre);
            stmt.setDouble(2, precio);
            stmt.setString(3, imagenUrl);
            stmt.setInt(4, restauranteId);
            stmt.setInt(5, id);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Eliminar platos    
    private void eliminarPlato(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Connection conn = Conexion.getConnection();
            String sql = "DELETE FROM platos WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
