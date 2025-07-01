/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package strategy;

public class PagoEfectivo implements MetodoPago {
    @Override
    public String procesarPago() {
        return "Pago realizado en Efectivo.";
    }
}
