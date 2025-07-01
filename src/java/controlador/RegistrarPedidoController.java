/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.ItemCarrito;
import modelo.Usuario;
import util.Conexion;
import strategy.*; // <- Asegúrate de importar el paquete del patrón Strategy

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

@WebServlet("/RegistrarPedidoController")
public class RegistrarPedidoController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String metodoPagoSeleccionado = request.getParameter("metodo_pago");
        System.out.println("Método de pago recibido: " + metodoPagoSeleccionado);

        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("No hay sesión activa");
            response.sendRedirect("login.jsp");
            return;
        }

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (usuario == null || carrito == null || carrito.isEmpty()) {
            System.out.println("Usuario o carrito inválido");
            response.sendRedirect("carrito.jsp");
            return;
        }

        if (metodoPagoSeleccionado == null || metodoPagoSeleccionado.trim().isEmpty()) {
            System.out.println("Método de pago no seleccionado");
            response.sendRedirect("carrito.jsp?error=metodo_pago");
            return;
        }

        String direccion = usuario.getDireccion();
        String telefono = usuario.getTelefono();

        if (direccion == null || direccion.trim().isEmpty() ||
            telefono == null || telefono.trim().isEmpty()) {
            response.sendRedirect("carrito.jsp?error=datos_usuario");
            return;
        }

        // Construir descripción del pedido
        StringBuilder descripcion = new StringBuilder();
        for (ItemCarrito item : carrito) {
            descripcion.append(item.getCantidad())
                       .append(" x ").append(item.getNombrePlato())
                       .append(" (S/. ").append(item.getPrecio()).append("), ");
        }

        // 🔷 Uso del patrón Strategy
        MetodoPago metodo;
        switch (metodoPagoSeleccionado) {
            case "Tarjeta de Crédito":
            case "Tarjeta de Débito":
                metodo = new PagoTarjeta(); break;
            case "Yape":
                metodo = new PagoYape(); break;
            case "Efectivo":
            default:
                metodo = new PagoEfectivo(); break;
        }
        ProcesadorPago procesador = new ProcesadorPago(metodo);
        String resultadoPago = procesador.procesar();

        try (
            Connection con = Conexion.getConnection(); // 🔷 Uso del patrón Singleton
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO pedidos (id_usuario, direccion, telefono, descripcion, metodo_pago) VALUES (?, ?, ?, ?, ?)")
        ) {
            ps.setInt(1, usuario.getId());
            ps.setString(2, direccion);
            ps.setString(3, telefono);
            ps.setString(4, descripcion.toString());
            ps.setString(5, metodoPagoSeleccionado);

            ps.executeUpdate();

            // Guardar información para mostrar en MisPedidos.jsp
            session.setAttribute("ultimoPedidoDescripcion", descripcion.toString());
            session.setAttribute("ultimoPedidoDireccion", direccion);
            session.setAttribute("ultimoPedidoTelefono", telefono);
            session.setAttribute("ultimoMetodoPago", metodoPagoSeleccionado);
            session.setAttribute("resultadoPago", resultadoPago); // opcional

            // Limpiar carrito
            session.removeAttribute("carrito");

            System.out.println("Pedido registrado correctamente.");
            response.sendRedirect(request.getContextPath() + "/MisPedidos.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("carrito.jsp?error=pedido");
        }
    }
}





