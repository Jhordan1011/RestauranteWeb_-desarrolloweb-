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
import java.util.ArrayList;

@WebServlet("/EliminarItemCarritoController")
public class EliminarItemCarritoController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 🔧 Asegura que los caracteres como tildes o ñ se lean correctamente
        request.setCharacterEncoding("UTF-8");

        String nombrePlato = request.getParameter("nombrePlato");

        HttpSession session = request.getSession();
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (carrito != null) {
            carrito.removeIf(item -> item.getNombrePlato().equals(nombrePlato));
            session.setAttribute("carrito", carrito); // Actualiza sesión
        }

        response.sendRedirect("carrito.jsp");
    }
}


