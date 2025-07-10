package fachada;

import modelo.Pedido;
import modelo.DetallePedido;
import util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PedidoFacade {

    public boolean guardarPedido(Pedido pedido) {
        Connection conn = null;
        try {
            conn = Conexion.getConnection(); 
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

            ResultSet rs = psPedido.getGeneratedKeys();
            int pedidoId = 0;
            if (rs.next()) {
                pedidoId = rs.getInt(1);
                pedido.setId(pedidoId);
            }

            String sqlDetalle = "INSERT INTO detalles_pedido (pedido_id, restaurante_id, plato_id, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);

            for (DetallePedido d : pedido.getDetalles()) {

                
                System.out.println("Restaurante ID: " + d.getRestauranteId()); //  esta línea
                

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
    
    public List<Pedido> listarPedidos() {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedidos";

        try (Connection conn = Conexion.getConnection(); // Cambio aquí
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pedido p = new Pedido();
                p.setId(rs.getInt("id"));
                p.setUsuarioId(rs.getInt("usuario_id"));
                p.setFechaPedido(rs.getDate("fecha_pedido"));
                p.setTotal(rs.getDouble("total"));
                p.setEstado(rs.getString("estado"));
                p.setDireccionEntrega(rs.getString("direccion_entrega"));
                p.setNotas(rs.getString("notas"));
                String metodoPagoStr = rs.getString("metodo_pago");
                if (metodoPagoStr != null) {
                    p.setMetodoPago(Pedido.MetodoPago.valueOf(metodoPagoStr.toUpperCase()));
                }

                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public boolean editarPedido(Pedido pedido) {
    Connection conn = null;
    try {
        conn = Conexion.getConnection();
        conn.setAutoCommit(false);

        String sql = "UPDATE pedidos SET estado = ?, direccion_entrega = ?, notas = ?, metodo_pago = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, pedido.getEstado().toLowerCase());
        ps.setString(2, pedido.getDireccionEntrega());
        ps.setString(3, pedido.getNotas() != null ? pedido.getNotas() : "");
        ps.setString(4, pedido.getMetodoPago().name());
        ps.setInt(5, pedido.getId());

        int rowsUpdated = ps.executeUpdate();
        conn.commit();
        
        return rowsUpdated > 0; 

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




