<%-- 
    Document   : MisPedidos
    Created on : 22 may. 2025, 2:03:55 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Obtener datos del último pedido desde sesión
    String descripcion = (String) session.getAttribute("ultimoPedidoDescripcion");
    String direccion = (String) session.getAttribute("ultimoPedidoDireccion");
    String telefono = (String) session.getAttribute("ultimoPedidoTelefono");
    String metodoPago = (String) session.getAttribute("ultimoMetodoPago");

    if (descripcion == null || direccion == null || telefono == null || metodoPago == null) {
        // Si no hay datos del pedido en sesión, redirigir al carrito o página principal
        response.sendRedirect("carrito.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Pedidos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">Detalles de tu Pedido</h2>

    <div class="card">
        <div class="card-header bg-primary text-white">
            Información del Pedido
        </div>
        <div class="card-body">
            <p><strong>Platos pedidos:</strong></p>
            <p><%= descripcion %></p>

            <p><strong>Dirección de entrega:</strong> <%= direccion %></p>
            <p><strong>Teléfono de contacto:</strong> <%= telefono %></p>
            <p><strong>Método de pago:</strong> <%= metodoPago %></p>
        </div>
    </div>

    <div class="mt-4 text-center">
        <a href="seleccionar_restaurante.jsp" class="btn btn-success">Hacer otro pedido</a>
        <!-- Cambié logout.jsp por /logout que apunta a LogoutServlet -->
        <a href="logout" class="btn btn-secondary">Cerrar sesión</a>
    </div>
</div>
</body>
</html>


