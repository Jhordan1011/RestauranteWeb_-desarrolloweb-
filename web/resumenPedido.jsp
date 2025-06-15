<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Pedido" %>
<%@ page import="modelo.DetallePedido" %>
<%@ page import="util.DetallePedidoIterator" %>
<%
    Pedido pedido = (Pedido) session.getAttribute("pedido");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resumen de tu Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }

        .card {
            background-color: #111;
            border: 1px solid #FFD700;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(255, 215, 0, 0.2);
        }

        .card-header {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
        }

        .list-group-item {
            background-color: #222;
            color: #fff;
            border: none;
            border-bottom: 1px solid #333;
        }

        .badge {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            font-size: 0.9rem;
        }

        .btn-outline-secondary {
            color: #FFD700;
            border-color: #FFD700;
        }

        .btn-outline-secondary:hover {
            background-color: #FFD700;
            color: #000;
        }

        .btn-success {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border: none;
        }

        .btn-success:hover {
            background-color: #e6c200;
        }

        .text-success {
            color: #FFD700 !important;
        }

        .alert-info {
            background-color: #222;
            border-color: #FFD700;
            color: #FFD700;
        }

        .alert-warning {
            background-color: #111;
            border-color: #FFD700;
            color: #FFD700;
        }

        a.btn-primary {
            background-color: #FFD700;
            border: none;
            color: #000;
        }

        a.btn-primary:hover {
            background-color: #e6c200;
        }

    </style>
</head>
<body>
<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h3 class="mb-0">Resumen de tu Pedido</h3>
            <span class="badge rounded-pill">
                <%= pedido != null ? "Restaurante #" + pedido.getRestauranteID() : "" %>
            </span>
        </div>
        <div class="card-body">
            <% if (pedido != null && !pedido.getDetalles().isEmpty()) { %>
                <h5 class="mb-3 text-warning">Platos seleccionados:</h5>
                <ul class="list-group mb-4">
                    <%
                        DetallePedidoIterator iterador = new DetallePedidoIterator(pedido.getDetalles());
                        while (iterador.tieneSiguiente()) {
                            DetallePedido detalle = iterador.siguiente();
                    %>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <div>
                            <strong><%= detalle.getNombrePlato() %></strong>
                            <div class="text-muted small">
                                Cantidad: <%= detalle.getCantidad() %> x S/. <%= String.format("%.2f", detalle.getPrecioUnitario()) %>
                            </div>
                        </div>
                        <span class="badge rounded-pill">
                            S/. <%= String.format("%.2f", detalle.getSubtotal()) %>
                        </span>
                    </li>
                    <% } %>
                </ul>

                <div class="d-flex justify-content-between align-items-center border-top pt-3">
                    <h4>Total: <span class="text-success">S/. <%= String.format("%.2f", pedido.getTotal()) %></span></h4>
                    <div>
                        <a href="<%= request.getContextPath() %>/platos?restauranteId=<%= pedido.getRestauranteID() %>" 
                           class="btn btn-outline-secondary me-2">
                           <i class="bi bi-arrow-left"></i> Seguir pidiendo
                        </a>
                        <form action="<%= request.getContextPath() %>/ConfirmarPedidoServlet" method="post" style="display: inline;">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-circle"></i> Confirmar pedido
                            </button>
                        </form>
                    </div>
                </div>

                <% if (pedido.getNotas() != null && !pedido.getNotas().isEmpty()) { %>
                    <div class="alert alert-info mt-3">
                        <strong>Notas:</strong> <%= pedido.getNotas() %>
                    </div>
                <% } %>
            <% } else { %>
                <div class="alert alert-warning text-center py-4">
                    <i class="bi bi-cart-x" style="font-size: 2rem;"></i>
                    <h4 class="mt-2">No hay platos en tu pedido</h4>
                    <a href="<%= request.getContextPath() %>/platos" class="btn btn-primary mt-3">
                        <i class="bi bi-arrow-left"></i> Volver a los platos
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
