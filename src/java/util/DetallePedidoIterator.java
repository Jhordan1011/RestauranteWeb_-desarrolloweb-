/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import modelo.DetallePedido;
import java.util.List;

public class DetallePedidoIterator {
    private final List<DetallePedido> lista;
    private int posicion = 0;

    public DetallePedidoIterator(List<DetallePedido> lista) {
        this.lista = lista;
    }

    public boolean tieneSiguiente() {
        return posicion < lista.size();
    }

    public DetallePedido siguiente() {
        return lista.get(posicion++);
    }
}

