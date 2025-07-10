/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import fachada.PedidoFacade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.Pedido;

/**
 *
 * @author Equipo
 */
@WebServlet("/adminPedidos")
public class VerPedidosServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PedidoFacade facade = new PedidoFacade();
        List<Pedido> pedidos = facade.listarPedidos();  // Método explicado antes

        request.setAttribute("pedidos", pedidos);
        request.getRequestDispatcher("AdminPedidos.jsp").forward(request, response);  
    }

}

