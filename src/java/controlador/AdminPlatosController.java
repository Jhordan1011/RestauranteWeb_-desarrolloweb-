package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import modelo.Platos;
import util.Conexion;

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

    
    //Listar los platos
    private List<Platos> obtenerTodosLosPlatos() {
        List<Platos> lista = new ArrayList<>();
        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM platos");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Platos p = new Platos();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setImagenUrl(rs.getString("imagen_url"));
                p.setRestauranteId(rs.getInt("restaurante_id"));
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
            String imagenUrl = request.getParameter("imagenUrl");
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
