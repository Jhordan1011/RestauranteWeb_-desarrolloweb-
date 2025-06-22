/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static Conexion instancia;
    private Connection conexion;

    private final String url = "jdbc:mysql://localhost:3306/restaurante_simple?useSSL=false&serverTimezone=UTC";
    private final String usuario = "root";
    private final String clave = "contreras10";

    private Conexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, clave);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public static Conexion getInstancia() {
        if (instancia == null) {
            instancia = new Conexion();
        }
        return instancia;
    }

    // ✅ MÉTODO CORREGIDO: devuelve la conexión del Singleton
    public static Connection getConnection() {
        return getInstancia().getConexion();
    }

    public Connection getConexion() {
        return conexion;
    }
}
