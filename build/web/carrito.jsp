<%-- 
    Document   : carrito
    Created on : 20 may. 2025, 10:40:31 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, modelo.ItemCarrito" %>
<%
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Carrito de Compras</h2>
    <%
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");
        double total = 0;
        if (carrito != null && !carrito.isEmpty()) {
    %>

    <!-- Tabla de platos seleccionados -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Plato</th>
                <th>Precio</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <% for (ItemCarrito item : carrito) {
                double subtotal = item.getPrecio() * item.getCantidad();
                total += subtotal;
        %>
            <tr>
                <td><%= item.getNombrePlato() %></td>
                <td>S/. <%= item.getPrecio() %></td>
                <td><%= item.getCantidad() %></td>
                <td>S/. <%= subtotal %></td>
                <td>
                    <form action="EliminarItemCarritoController" method="post" onsubmit="return confirm('¿Estás seguro de eliminar este plato del carrito?');">
                        <input type="hidden" name="nombrePlato" value="<%= item.getNombrePlato() %>">
                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                    </form>
                </td>
            </tr>
        <% } %>
            <tr>
                <td colspan="4" class="text-end"><strong>Total</strong></td>
                <td><strong>S/. <%= total %></strong></td>
            </tr>
        </tbody>
    </table>

    <!-- Botón para continuar con el pedido -->
    <div class="text-center mb-4">
        <a href="seleccionar_restaurante.jsp" class="btn btn-primary btn-lg">Continuar con Pedido</a>
    </div>

    <!-- Formulario para método de pago y confirmar pedido -->
    <div class="mb-5">
        <form action="${pageContext.request.contextPath}/RegistrarPedidoController" method="post">
            <div class="mb-3">
                <label for="metodo_pago" class="form-label">Selecciona Método de Pago:</label>
                <select name="metodo_pago" id="metodo_pago" class="form-select" required>
                    <option value="">-- Seleccione método de pago --</option>
                    <option value="Tarjeta de Crédito">Tarjeta de Crédito</option>
                    <option value="Tarjeta de Débito">Tarjeta de Débito</option>
                    <option value="Yape">Yape</option>
                    <option value="Plin">Plin</option>
                    <option value="Efectivo">Efectivo</option>
                </select>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-success btn-lg">Confirmar y Registrar Pedido</button>
            </div>
        </form>
    </div>

    <% } else { %>
        <div class="alert alert-warning text-center">
            Tu carrito está vacío.
        </div>
    <% } %>
</div>
</body>
</html>








