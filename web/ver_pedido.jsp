<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Pedido" %>
<%@ page import="modelo.DetallePedido" %>
<%@ page import="java.util.List" %>
<%
    Pedido pedido = (Pedido) session.getAttribute("pedido");
    List<DetallePedido> detalles = (pedido != null) ? pedido.getDetalles() : null;
    
     int ultimoRestauranteId = 0;
    if (detalles != null && !detalles.isEmpty()) {
        ultimoRestauranteId = detalles.get(detalles.size() - 1).getRestauranteId();
    }
    

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tu Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }

        .container {
            background-color: #111;
            border: 1px solid #FFD700;
            border-radius: 10px;
            padding: 30px;
            margin-top: 50px;
        }

        h2, h4, label {
            color: #FFD700;
        }

        table {
            background-color: #111;
            color: #fff;
            border: 1px solid #FFD700;
        }

        th, td {
            border: 1px solid #FFD700 !important;
        }

        th {
            background-color: #222;
            color: #FFD700;
        }

        .form-control, .form-select {
            background-color: #222;
            color: #fff;
            border: 1px solid #FFD700;
        }

        .form-control:focus, .form-select:focus {
            background-color: #222;
            color: #fff;
            border-color: #e6c200;
            box-shadow: none;
        }

        .btn-success {
            background-color: #FFD700;
            color: #000;
            border: none;
        }

        .btn-success:hover {
            background-color: #e6c200;
        }

        .btn-secondary, .btn-primary {
            border: none;
        }

        .btn-secondary {
            background-color: #444;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #666;
        }

        .btn-primary {
            background-color: #FFD700;
            color: #000;
        }

        .btn-primary:hover {
            background-color: #e6c200;
        }

        .alert-warning {
            background-color: #333;
            color: #FFD700;
            border: 1px solid #FFD700;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Resumen del Pedido</h2>
    <%
        if (detalles != null && !detalles.isEmpty()) {
    %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Plato</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
        <% for (DetallePedido d : detalles) { %>
            <tr>
                <td><%= d.getNombrePlato() %></td>
                <td><%= d.getCantidad() %></td>
                <td>S/. <%= String.format("%.2f", d.getPrecioUnitario()) %></td>
                <td>S/. <%= String.format("%.2f", d.getSubtotal()) %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <h4>Total: S/. <%= String.format("%.2f", pedido.getTotal()) %></h4>
    
    <!-- Formulario con selector de método de pago -->
    <form action="FinalizarPedidoServlet" method="post">
        <div class="mb-3">
            <label for="direccion" class="form-label">Dirección de Entrega:</label>
            <input type="text" name="direccion" id="direccion" class="form-control" required>
        </div>
        
        <div class="mb-3">
            <label for="notas" class="form-label">Notas adicionales:</label>
            <textarea name="notas" id="notas" class="form-control" rows="2"></textarea>
        </div>
        
        <div class="mb-3">
            <label for="metodoPago" class="form-label">Método de Pago:</label>
            <select name="metodoPago" id="metodoPago" class="form-select" required>
                
                
                <option value="">Seleccione un método</option>
                <option value="EFECTIVO">Efectivo</option>
                <option value="TARJETA">Tarjeta</option>
                <option value="TRANSFERENCIA">Transferencia</option>
                <option value="YAPE">Yape</option>
            </select>
        </div>
        
        <input type="submit" value="Confirmar Pedido" class="btn btn-success">
    </form>
    
    <div class="mt-3">
        <a href="<%= request.getContextPath() %>/restaurantes" class="btn btn-secondary">Elegir Nuevo Restaurante</a>
        <% if (detalles != null && !detalles.isEmpty()) { %>
            <a href="<%= request.getContextPath() %>/platos?restauranteId=<%= ultimoRestauranteId %>" class="btn btn-primary ms-2">Agregar Más Platos</a>
        <% } %>
    </div>

    <% } else { %>
        <div class="alert alert-warning">Aún no has agregado ningún plato.</div>
    <% } %>
</div>
</body>
</html>

