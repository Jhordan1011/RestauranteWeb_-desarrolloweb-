/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.ItemCarrito;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/agregarCarrito")
public class AgregarCarrito extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombrePlato = request.getParameter("nombre");
        double precio = Double.parseDouble(request.getParameter("precio"));

        HttpSession sesion = request.getSession();
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) sesion.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        boolean existe = false;
        for (ItemCarrito item : carrito) {
            if (item.getNombrePlato().equals(nombrePlato)) {
                item.setCantidad(item.getCantidad() + 1);
                existe = true;
                break;
            }
        }

        if (!existe) {
            carrito.add(new ItemCarrito(nombrePlato, precio, 1));
        }

        sesion.setAttribute("carrito", carrito);
        response.sendRedirect("carrito.jsp");
    }
}