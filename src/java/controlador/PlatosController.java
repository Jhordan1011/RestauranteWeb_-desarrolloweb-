/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import modelo.Platos;

import util.Conexion;
import java.sql.*;

@WebServlet("/platos")
public class PlatosController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int restauranteId = Integer.parseInt(request.getParameter("restauranteId"));
        List<Platos> platos = obtenerPlatosPorRestaurante(restauranteId);
        
        request.setAttribute("platos", platos);
        request.getRequestDispatcher("/vistas/platos/ver_platos.jsp").forward(request, response);
    }

    private List<Platos> obtenerPlatosPorRestaurante(int restauranteId) {
        List<Platos> lista = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            // Usamos getInstancia().getConexion() en lugar de getConnection()
            conn = Conexion.getInstancia().getConexion();
            String sql = "SELECT * FROM platos WHERE restaurante_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, restauranteId);
            rs = stmt.executeQuery();

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
        } finally {
            // Cerramos solo ResultSet y Statement
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            // No cerramos la conexión porque es singleton
        }
        return lista;
    }
    
    
    
    
}