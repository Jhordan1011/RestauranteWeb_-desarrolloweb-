/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import modelo.Restaurante;
import util.Conexion;
import java.sql.*;

@WebServlet("/restaurantes")
public class RestauranteController extends HttpServlet{
 Connection con = Conexion.getConnection();
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        List<Restaurante> restaurantes = new ArrayList<>();
        con = Conexion.getConnection();



        try{
        if(con == null)
        {
            System.out.println("Error: conexión nula");
            response.sendRedirect("error.jsp?error=conexion");
            return;
        }
    
        String sql = "SELECT id, nombre, descripcion, direccion, imagen_url, telefono FROM restaurantes";
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()){
        
            Restaurante restaurante = new Restaurante();
            restaurante.setId(rs.getInt("id"));
            restaurante.setNombre(rs.getString("nombre"));
            restaurante.setDescripcion(rs.getString("descripcion"));
            restaurante.setDireccion(rs.getString("direccion"));
            restaurante.setImagenUrl(rs.getString("imagen_url"));
            restaurante.setTelefono(rs.getString("telefono")); 
            
            restaurantes.add(restaurante);
            
        }
        
        request.setAttribute("restaurantes", restaurantes);
        request.getRequestDispatcher("seleccionar_restaurante.jsp").forward(request, response);
        
    }catch(Exception e)
        {
            e.printStackTrace();
            response.sendRedirect("error.jsp?error=excepcion");
        }
            
    }  
    
}
