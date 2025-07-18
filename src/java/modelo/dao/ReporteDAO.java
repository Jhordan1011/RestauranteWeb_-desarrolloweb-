package modelo.dao;

import util.Conexion;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class ReporteDAO {

 public Map<String, Integer> obtenerPlatosMasPedidos() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT p.nombre AS plato, COUNT(*) AS total " +
                 "FROM detalles_pedido dp " +
                 "JOIN platos p ON dp.plato_id = p.id " +
                 "GROUP BY p.nombre ORDER BY total DESC LIMIT 5";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("plato"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}


    public Map<String, Integer> obtenerRestaurantesMasPedidos() {
        Map<String, Integer> resultado = new LinkedHashMap<>();
        String sql = "SELECT r.nombre, COUNT(*) AS total " +
                     "FROM detalles_pedido dp " +
                     "JOIN restaurantes r ON dp.restaurante_id = r.id " +
                     "GROUP BY r.nombre ORDER BY total DESC LIMIT 5";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                resultado.put(rs.getString("nombre"), rs.getInt("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultado;
    }
    
    
    //  método para obtener pedidos por día
public Map<String, Integer> obtenerPedidosPorDia() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT DATE(fecha_pedido) AS dia, COUNT(*) AS total FROM pedidos GROUP BY dia ORDER BY dia ASC";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("dia"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}

//metodo para obtener pedidos por mess
public Map<String, Integer> obtenerPedidosPorMes() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT DATE_FORMAT(fecha_pedido, '%Y-%m') AS mes, COUNT(*) AS total " +
                 "FROM pedidos " +
                 "GROUP BY mes " +
                 "ORDER BY mes";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("mes"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}

//metodo de pagos mass usadoss
public Map<String, Integer> obtenerMetodosPagoUsados() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT metodo_pago, COUNT(*) AS total FROM pedidos GROUP BY metodo_pago ORDER BY total DESC";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("metodo_pago"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}

//los usurarios que mass compran
public Map<String, Integer> obtenerUsuariosFrecuentes() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT u.nombre_completo, COUNT(*) AS total " +
                 "FROM pedidos p " +
                 "JOIN usuario u ON p.usuario_id = u.id " +
                 "GROUP BY u.nombre_completo " +
                 "ORDER BY total DESC LIMIT 5";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("nombre_completo"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}



public Map<String, Integer> obtenerPlatosMasPedidosPorRango(String inicio, String fin) {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT p.nombre AS plato, COUNT(*) AS total " +
                 "FROM detalles_pedido dp " +
                 "JOIN platos p ON dp.plato_id = p.id " +
                 "JOIN pedidos ped ON dp.pedido_id = ped.id " +
                 "WHERE ped.fecha_pedido BETWEEN ? AND ? " +
                 "GROUP BY p.nombre ORDER BY total DESC LIMIT 5";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, inicio);
        ps.setString(2, fin);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            resultado.put(rs.getString("plato"), rs.getInt("total"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return resultado;
}

public Map<String, Integer> obtenerRestaurantesMasPedidosPorRango(String inicio, String fin) {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT r.nombre, COUNT(*) AS total " +
                 "FROM detalles_pedido dp " +
                 "JOIN restaurantes r ON dp.restaurante_id = r.id " +
                 "JOIN pedidos ped ON dp.pedido_id = ped.id " +
                 "WHERE ped.fecha_pedido BETWEEN ? AND ? " +
                 "GROUP BY r.nombre ORDER BY total DESC LIMIT 5";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, inicio);
        ps.setString(2, fin);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            resultado.put(rs.getString("nombre"), rs.getInt("total"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return resultado;
}


//r
public Map<String, Integer> obtenerMotivosReembolso() {
    Map<String, Integer> resultado = new LinkedHashMap<>();
    String sql = "SELECT motivo, COUNT(*) AS total FROM reembolsos GROUP BY motivo ORDER BY total DESC";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            resultado.put(rs.getString("motivo"), rs.getInt("total"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return resultado;
}


}


