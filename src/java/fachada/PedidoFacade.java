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

            String sqlPedido = "INSERT INTO pedidos (fecha_pedido, restaurante_id, usuario_id, estado, total, direccion_entrega, metodo_pago, notas) VALUES (NOW(), ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, pedido.getRestauranteID());
            psPedido.setInt(2, pedido.getUsuarioId());
            psPedido.setString(3, pedido.getEstado().toLowerCase());
            psPedido.setDouble(4, pedido.getTotal());
            psPedido.setString(5, pedido.getDireccionEntrega());
            psPedido.setString(6, pedido.getMetodoPago().name());
            psPedido.setString(7, pedido.getNotas() != null ? pedido.getNotas() : "");

            psPedido.executeUpdate();

            ResultSet rs = psPedido.getGeneratedKeys();
            int pedidoId = 0;
            if (rs.next()) {
                pedidoId = rs.getInt(1);
                pedido.setId(pedidoId); // ✅ Asigna el ID generado al objeto pedido
            }

            String sqlDetalle = "INSERT INTO detalles_pedido (pedido_id, plato_id, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);

            for (DetallePedido d : pedido.getDetalles()) {
                psDetalle.setInt(1, pedidoId);
                psDetalle.setInt(2, d.getPlatoId());
                psDetalle.setInt(3, d.getCantidad());
                psDetalle.setDouble(4, d.getPrecioUnitario());
                psDetalle.setDouble(5, d.getSubtotal());
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



