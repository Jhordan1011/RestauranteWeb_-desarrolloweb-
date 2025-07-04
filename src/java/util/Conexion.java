/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/restaurante_simple?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String CLAVE = "contreras10";

    // ✅ Método que devuelve SIEMPRE una conexión nueva
    public static Connection getConnection() {
<<<<<<< HEAD
=======
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    private Connection conexion;

    private final String url = "jdbc:mysql://localhost:3306/restaurante_simple?useSSL=false&serverTimezone=UTC";

    private final String usuario = "root";

    private final String clave = "ajugardota2";



    private Conexion() {
>>>>>>> egusquiza
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USUARIO, CLAVE);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null; // Importante: retorna null si falla
        }
    }
}