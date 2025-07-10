package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import modelo.Restaurante;
import util.Conexion;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,   // 1MB
    maxFileSize = 1024 * 1024 * 5,     // 5MB
    maxRequestSize = 1024 * 1024 * 10  // 10MB
)
@WebServlet("/adminRestaurantes")
public class AdminRestaurantesController extends HttpServlet {

    private final String uploadPath = "F:\\Proyecto-Desarrollo Web\\RestauranteWeb_-desarrolloweb-\\web\\img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Restaurante> restaurantes = obtenerTodosRestaurantes();
        request.setAttribute("restaurantes", restaurantes);
        request.getRequestDispatcher("/AdminRestaurantes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");

        switch (accion) {
            case "crear":
                crearRestaurante(request);
                break;
            case "editar":
                editarRestaurante(request);
                break;
            case "eliminar":
                eliminarRestaurante(request);
                break;
        }
        response.sendRedirect("adminRestaurantes");
    }

    private List<Restaurante> obtenerTodosRestaurantes() {
        List<Restaurante> lista = new ArrayList<>();
        String sql = "SELECT * FROM restaurantes";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Restaurante r = new Restaurante();
                r.setId(rs.getInt("id"));
                r.setNombre(rs.getString("nombre"));
                r.setDescripcion(rs.getString("descripcion"));
                r.setDireccion(rs.getString("direccion"));
                r.setTelefono(rs.getString("telefono"));
                r.setImagenUrl(rs.getString("imagen_url"));
                r.setLatitud(rs.getDouble("latitud"));
                r.setLongitud(rs.getDouble("longitud"));
                
                lista.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

   private void crearRestaurante(HttpServletRequest request) {
    try {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        

        Part imagenPart = request.getPart("imagen");
        String imagenUrl = guardarImagen(imagenPart); 
        double latitud = Double.parseDouble(request.getParameter("latitud"));
        double longitud = Double.parseDouble(request.getParameter("longitud"));

        
        String sql = "INSERT INTO restaurantes (nombre, descripcion, direccion, telefono, imagen_url, latitud, longitud) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            stmt.setString(2, descripcion);
            stmt.setString(3, direccion);
            stmt.setString(4, telefono);
            stmt.setString(5, imagenUrl);
            stmt.setDouble(6, latitud); 
            stmt.setDouble(7, longitud);
            stmt.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    private void editarRestaurante(HttpServletRequest request) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String imagenUrlActual = request.getParameter("imagenUrl");

            Part imagenPart = request.getPart("imagen");
            String imagenUrlNueva = imagenUrlActual;

            if (imagenPart != null && imagenPart.getSize() > 0) {
                imagenUrlNueva = guardarImagen(imagenPart);
            }

            String sql = "UPDATE restaurantes SET nombre=?, descripcion=?, direccion=?, telefono=?, imagen_url=? WHERE id=?";
            try (Connection conn = Conexion.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nombre);
                stmt.setString(2, descripcion);
                stmt.setString(3, direccion);
                stmt.setString(4, telefono);
                stmt.setString(5, imagenUrlNueva);
                stmt.setInt(6, id);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void eliminarRestaurante(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String sql = "DELETE FROM restaurantes WHERE id=?";
            try (Connection conn = Conexion.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String guardarImagen(Part imagenPart) throws IOException {
    String uploadPath = "C:\\Users\\ASUS\\Videos\\ClonadoWeb\\RestauranteWeb_-desarrolloweb-\\web\\img";
 
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String nombreOriginal = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();
    String extension = nombreOriginal.substring(nombreOriginal.lastIndexOf("."));
    String nuevoNombre = System.currentTimeMillis() + extension;

    File archivo = new File(uploadPath, nuevoNombre);
    try (InputStream input = imagenPart.getInputStream()) {
        Files.copy(input, archivo.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
    }

    return "/img/" + nuevoNombre; // ruta para guardar en la BD
}

}
