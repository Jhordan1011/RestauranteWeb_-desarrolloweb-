package modelo.dao;

import modelo.Reembolso;
import util.Conexion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReembolsoDAO {

    /**
     * Registra un nuevo reembolso desde el formulario del usuario.
     */
    public boolean registrarReembolso(Reembolso r) {
        String sql = "INSERT INTO reembolsos (pedido_id, usuario_id, motivo, estado, observaciones_admin) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getPedidoId());
            ps.setInt(2, r.getUsuarioId());
            ps.setString(3, r.getMotivo());
            ps.setString(4, r.getEstado()); // Por defecto: "pendiente"
            ps.setString(5, r.getObservacionesAdmin());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Lista todos los reembolsos. Útil para la vista del administrador.
     */
    public List<Reembolso> listarReembolsos() {
        List<Reembolso> lista = new ArrayList<>();
        String sql = "SELECT * FROM reembolsos";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reembolso r = new Reembolso();
                r.setId(rs.getInt("id"));
                r.setPedidoId(rs.getInt("pedido_id"));
                r.setUsuarioId(rs.getInt("usuario_id"));
                r.setMotivo(rs.getString("motivo"));
                r.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                r.setEstado(rs.getString("estado"));
               

                r.setObservacionesAdmin(rs.getString("observaciones_admin"));

                lista.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    /**
     * Actualiza el estado del reembolso (pendiente → aprobado/rechazado) y agrega observaciones.
     */
    public boolean actualizarEstado(int idReembolso, String nuevoEstado, String observaciones) {
        String sql = "UPDATE reembolsos SET estado = ?, observaciones_admin = ? WHERE id = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevoEstado);
            ps.setString(2, observaciones);
            ps.setInt(3, idReembolso);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Obtiene un reembolso por su ID.
     */
    public Reembolso obtenerPorId(int id) {
        String sql = "SELECT * FROM reembolsos WHERE id = ?";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Reembolso r = new Reembolso();
                r.setId(rs.getInt("id"));
                r.setPedidoId(rs.getInt("pedido_id"));
                r.setUsuarioId(rs.getInt("usuario_id"));
                r.setMotivo(rs.getString("motivo"));
                r.setFechaSolicitud(rs.getTimestamp("fecha_solicitud"));
                r.setEstado(rs.getString("estado"));
                r.setMonto(rs.getBigDecimal("monto").doubleValue());

                r.setObservacionesAdmin(rs.getString("observaciones_admin"));
                return r;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
