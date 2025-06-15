/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.ItemCarrito;
import java.io.IOException;
import java.util.*;

@WebServlet("/CarritoServlet")
public class CarritoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));

        HttpSession sesion = request.getSession();

        List<ItemCarrito> carrito = (List<ItemCarrito>) sesion.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        boolean existe = false;
        for (ItemCarrito item : carrito) {
            if (item.getNombrePlato().equals(nombre)) {
                // Incrementar cantidad si el producto ya está en el carrito
                item.setCantidad(item.getCantidad() + 1);
                existe = true;
                break;
            }
        }

        // Si no existe el producto, agregarlo con cantidad 1
        if (!existe) {
            carrito.add(new ItemCarrito(nombre, precio, 1));
        }

        // Guardar el carrito actualizado en la sesión
        sesion.setAttribute("carrito", carrito);

        // Redirigir al carrito para mostrar los productos agregados
        response.sendRedirect("carrito.jsp");
    }
}


