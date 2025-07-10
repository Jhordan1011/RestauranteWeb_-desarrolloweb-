package modelo;

public class DetallePedido {

    private int id;
    private Pedido pedido;      // Referencia al objeto Pedido
    private int platoId;
    private int cantidad;
    private double precioUnitario;
    private double subtotal;
    private String nombrePlato;// Puedes mantenerlo para mostrar en la interfaz, aunque no esté en BD
    private int restauranteId;

    public DetallePedido() {
    }

    public DetallePedido(int id, Pedido pedido, int platoId, int cantidad, double precioUnitario, double subtotal, String nombrePlato, int restauranteId) {
        this.id = id;
        this.pedido = pedido;
        this.platoId = platoId;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.subtotal = subtotal;
        this.nombrePlato = nombrePlato;
        this.restauranteId = restauranteId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    public int getPlatoId() {
        return platoId;
    }

    public void setPlatoId(int platoId) {
        this.platoId = platoId;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public String getNombrePlato() {
        return nombrePlato;
    }

    public void setNombrePlato(String nombrePlato) {
        this.nombrePlato = nombrePlato;
    }

    public int getRestauranteId() {
        return restauranteId;
    }

    public void setRestauranteId(int restauranteId) {
        this.restauranteId = restauranteId;
    }

  
    
    
}