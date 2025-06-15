/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package strategy;

public class ProcesadorPago {
    private MetodoPago metodo;

    public ProcesadorPago(MetodoPago metodo) {
        this.metodo = metodo;
    }

    public String procesar() {
        return metodo.procesarPago();
    }
}

