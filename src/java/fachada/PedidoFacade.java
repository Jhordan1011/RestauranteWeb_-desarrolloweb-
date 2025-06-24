/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fachada;

import modelo.Pedido;
import modelo.DetallePedido;
import util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class PedidoFacade {

    public boolean guardarPedido(Pedido pedido) {
        Connection conn = null;
        try {
            conn = Conexion.getInstancia().getConexion();
            conn.setAutoCommit(false);
            
            
            String sqlPedido = "INSERT INTO pedidos (fecha_pedido, usuario_id, estado, total, direccion_entrega, metodo_pago, notas) VALUES (NOW(), ?, ?, ?, ?, ?, ?)";
            PreparedStatement psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, pedido.getUsuarioId());
            psPedido.setString(2, pedido.getEstado().toLowerCase());
            psPedido.setDouble(3, pedido.getTotal());
            psPedido.setString(4, pedido.getDireccionEntrega());
            psPedido.setString(5, pedido.getMetodoPago().name());
            psPedido.setString(6, pedido.getNotas() != null ? pedido.getNotas() : "");

            psPedido.executeUpdate();

            // Obtener ID generado
            ResultSet rs = psPedido.getGeneratedKeys();
            int pedidoId = 0;
            if (rs.next()) {
                pedidoId = rs.getInt(1);
                pedido.setId(pedidoId);
            }

            String sqlDetalle = "INSERT INTO detalles_pedido (pedido_id, restaurante_id, plato_id, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);

            for (DetallePedido d : pedido.getDetalles()) {
                
                System.out.println("Restaurante ID: " + d.getRestauranteId()); // 🔍 Añade esta línea
                
                psDetalle.setInt(1, pedidoId);
                psDetalle.setInt(2, d.getRestauranteId());
                psDetalle.setInt(3, d.getPlatoId());
                psDetalle.setInt(4, d.getCantidad());
                psDetalle.setDouble(5, d.getPrecioUnitario());
                psDetalle.setDouble(6, d.getSubtotal());
                psDetalle.addBatch();
            }

            psDetalle.executeBatch();
            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        }
    }
}




