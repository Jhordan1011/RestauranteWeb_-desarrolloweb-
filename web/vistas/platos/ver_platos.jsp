<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Platos" %>
<%
    List<Platos> platos = (List<Platos>) request.getAttribute("platos");
    // Obtener la cantidad de platos en el pedido desde la sesión
    Integer cantidadPlatos = (Integer) session.getAttribute("cantidadPlatos");
    if (cantidadPlatos == null) cantidadPlatos = 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Platos del Restaurante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }
        .transform-hover:hover {
            transform: scale(1.02);
            transition: transform 0.3s ease;
        }
        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #FFD700;
            color: #000;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }
        .cart-container {
            position: relative;
        }
        .top-right-container {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body class="bg-dark text-light">
<div class="container py-5">
    
    <!-- Contenedor superior derecho con carrito y logout -->
    <div class="d-flex justify-content-end mb-4">
        <div class="top-right-container">
            <div class="cart-container">
                <a href="${pageContext.request.contextPath}/ver_pedido.jsp" class="btn btn-warning">
                    <i class="bi bi-cart"></i>
                </a>
                <% if (cantidadPlatos > 0) { %>
                    <span class="cart-badge"><%= cantidadPlatos %></span>
                <% } %>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="bi bi-person-circle"></i> Cerrar Sesión
            </a>
        </div>
    </div>

    <h2 class="text-center mb-5 text-warning fw-semibold">Platos disponibles</h2>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <% if (platos != null && !platos.isEmpty()) {
            for (Platos plato : platos) { %>
        <div class="col">
            <div class="card h-100 bg-secondary bg-opacity-10 border-0 shadow-lg rounded-4 transition transform-hover">
                <img src="<%= request.getContextPath() + plato.getImagenUrl() %>" class="card-img-top p-3 bg-dark" alt="<%= plato.getNombre() %>" style="height: 220px; object-fit: contain;">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title text-light"><%= plato.getNombre() %></h5>
                    <p class="card-text fw-bold text-light">S/. <%= String.format("%.2f", plato.getPrecio()) %></p>
                    
                    <form action="${pageContext.request.contextPath}/PedidoServlet" method="post" class="mt-auto text-center">
                        <input type="hidden" name="platoId" value="<%= plato.getId() %>">
                        <input type="hidden" name="nombrePlato" value="<%= plato.getNombre() %>">
                        <input type="hidden" name="precio" value="<%= plato.getPrecio() %>">
                        <input type="hidden" name="restauranteId" value="<%= plato.getRestauranteId() %>">
                        <button type="submit" class="btn btn-warning text-dark fw-bold px-4 rounded-pill mt-3">
                            Pedir este plato
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% }
        } else { %>
        <div class="col-12">
            <div class="alert alert-warning text-center border-warning bg-dark text-warning">
                No hay platos disponibles.
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>