package modelo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Pedido {

    private int id;
    private int usuarioId;
    private int restauranteID;
    private Date fechaPedido;          // Coincide con fecha_pedido
    private String estado;
    private double total;
    private String direccionEntrega;   // Coincide con direccion_entrega
    private String notas;
    private MetodoPago metodoPago;
    private List<DetallePedido> detalles = new ArrayList<>();

    public enum MetodoPago {
        EFECTIVO, TARJETA, TRANSFERENCIA, YAPE
    }

    public Pedido() {
        this.fechaPedido = new Date();
        this.estado = "PENDIENTE";
        this.total = 0.0;
    }

    // Getters y Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {  // ✅ Este método es esencial para asignar el ID desde el facade
        this.id = id;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public int getRestauranteID() {
        return restauranteID;
    }

    public void setRestauranteID(int restauranteID) {
        this.restauranteID = restauranteID;
    }

    public Date getFechaPedido() {
        return fechaPedido;
    }

    public void setFechaPedido(Date fechaPedido) {
        this.fechaPedido = fechaPedido;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getDireccionEntrega() {
        return direccionEntrega;
    }

    public void setDireccionEntrega(String direccionEntrega) {
        this.direccionEntrega = direccionEntrega;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }

    public MetodoPago getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(MetodoPago metodoPago) {
        this.metodoPago = metodoPago;
    }

    public List<DetallePedido> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<DetallePedido> detalles) {
        this.detalles = detalles;
    }
}

