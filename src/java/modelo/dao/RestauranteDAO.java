/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.dao;

import modelo.Restaurante;
import util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RestauranteDAO {

    public Restaurante buscarPorId(int id) {
    Restaurante restaurante = null;

    try (Connection conn = Conexion.getConnection()) {
        String sql = "SELECT * FROM restaurantes WHERE id = ?";
        System.out.println(">>> Conectado a base: " + conn.getCatalog());
        System.out.println(">>> Ejecutando SQL: " + sql + " con id = " + id);

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            System.out.println(">>> Restaurante encontrado en la base ✅");

            restaurante = new Restaurante();
            restaurante.setId(rs.getInt("id"));
            restaurante.setNombre(rs.getString("nombre"));
            restaurante.setDescripcion(rs.getString("descripcion"));
            restaurante.setDireccion(rs.getString("direccion"));
            restaurante.setImagenUrl(rs.getString("imagen_url"));
            restaurante.setTelefono(rs.getString("telefono"));
            restaurante.setLatitud(rs.getDouble("latitud"));
            restaurante.setLongitud(rs.getDouble("longitud"));
        } else {
            System.out.println(">>> ❌ ResultSet no devolvió nada");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return restaurante;
}

}

