<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Restaurante" %>
<%
    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
    String nombre = (usuario != null) ? usuario.getNombreCompleto() : "Invitado";
    List<Restaurante> restaurantes = (List<Restaurante>) request.getAttribute("restaurantes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Selecciona un Restaurante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000; /*Fondo negro*/
            color: #fff; /* Texto blanco */
        }

        h2 {
            color: #FFD700; /* Dorado */
            font-weight: bold;
        }

        .card {
            background-color: #111;
            border: 1px solid #FFD700;
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: scale(1.03);
            box-shadow: 0 6px 20px rgba(255, 215, 0, 0.4); /* Sombra dorada */
        }

        .card-title {
            color: #FFD700;
        }

        .card-text {
            color: #ddd;
        }

        .btn-primary {
            background-color: #FFD700;
            border: none;
            color: black;
            font-weight: bold;
        }

        .btn-primary:hover {
            background-color: #e6c200;
        }

       .card-img-top {
        height: 220px;
        object-fit: contain;
        background-color: #000; /* Fondo negro debajo de logos */
        padding: 10px;
}


        .alert-warning {
            background-color: #333;
            border-color: #FFD700;
            color: #FFD700;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">¡Hola <%= nombre %>! Elige un restaurante:</h2>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <%
            if (restaurantes != null && !restaurantes.isEmpty()) {
                for (Restaurante restaurante : restaurantes) {
        %>
        <div class="col">
            <div class="card h-100">
                <img src="${pageContext.request.contextPath}<%= restaurante.getImagenUrl() %>" 
                     class="card-img-top" alt="<%= restaurante.getNombre() %>">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= restaurante.getNombre() %></h5>
                    <p class="card-text"><%= restaurante.getDescripcion() %></p>
                    <p class="card-text fw-bold"><%= restaurante.getDireccion() %></p>
                    <div class="mt-auto d-flex justify-content-center">
                        <a href="${pageContext.request.contextPath}/platos?restauranteId=<%= restaurante.getId() %>" 
                           class="btn btn-primary">Ver Restaurante</a>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <div class="col-12">
            <div class="alert alert-warning text-center">No hay restaurantes disponibles</div>
        </div>
        <%
            }
        %>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



