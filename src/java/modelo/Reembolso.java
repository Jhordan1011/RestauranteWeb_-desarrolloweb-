/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Timestamp;
public class Reembolso {
    
    private int id;
private int pedidoId;
private int usuarioId;
private String motivo;
private Timestamp fechaSolicitud;
private String estado; // Puede ser: "pendiente", "aprobado", "rechazado"
private double monto;
private String observacionesAdmin;

// Constructor vacío
public Reembolso() {
}

// Constructor completo
public Reembolso(int id, int pedidoId, int usuarioId, String motivo,
                 Timestamp fechaSolicitud, String estado,
                 double monto, String observacionesAdmin) {
    this.id = id;
    this.pedidoId = pedidoId;
    this.usuarioId = usuarioId;
    this.motivo = motivo;
    this.fechaSolicitud = fechaSolicitud;
    this.estado = estado;
    this.monto = monto;
    this.observacionesAdmin = observacionesAdmin;
}

// Getters y Setters

public int getId() {
    return id;
}

public void setId(int id) {
    this.id = id;
}

public int getPedidoId() {
    return pedidoId;
}

public void setPedidoId(int pedidoId) {
    this.pedidoId = pedidoId;
}

public int getUsuarioId() {
    return usuarioId;
}

public void setUsuarioId(int usuarioId) {
    this.usuarioId = usuarioId;
}

public String getMotivo() {
    return motivo;
}

public void setMotivo(String motivo) {
    this.motivo = motivo;
}

public Timestamp getFechaSolicitud() {
    return fechaSolicitud;
}

public void setFechaSolicitud(Timestamp fechaSolicitud) {
    this.fechaSolicitud = fechaSolicitud;
}

public String getEstado() {
    return estado;
}

public void setEstado(String estado) {
    this.estado = estado;
}

public double getMonto() {
    return monto;
}

public void setMonto(double monto) {
    this.monto = monto;
}

public String getObservacionesAdmin() {
    return observacionesAdmin;
}

public void setObservacionesAdmin(String observacionesAdmin) {
    this.observacionesAdmin = observacionesAdmin;
}

    
}
