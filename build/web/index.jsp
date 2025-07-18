<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:37:21 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio - Restaurante Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #000000, #1a1a1a);
            color: #f8f9fa;
            min-height: 100vh;
        }

        .fondo-tarjeta {
            background-color: rgba(33, 37, 41, 0.85); /* Tarjeta oscura translúcida */
            border-radius: 25px;
            padding: 3rem 4rem;
            box-shadow: 0 0 35px rgba(255, 255, 255, 0.08);
            max-width: 900px;
            margin: auto;
        }

        .fondo-tarjeta h1 {
            font-size: 3rem;
            font-weight: 700;
            color: #ffc107;
        }

        .fondo-tarjeta p {
            font-size: 1.3rem;
            color: #ced4da;
        }

        .fondo-tarjeta img {
            max-height: 380px;
            object-fit: cover;
            border-radius: 15px;
            margin-top: 30px;
        }

        .btn-primary {
            background-color: #ffc107;
            border: none;
            color: #000;
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: #e0a800;
            color: #000;
        }

        .btn-success {
            background-color: #20c997;
            border: none;
            font-weight: 600;
        }

        .btn-success:hover {
            background-color: #17a589;
        }

        @media (max-width: 767px) {
            .fondo-tarjeta {
                padding: 2rem 1.5rem;
                max-width: 100%;
            }

            .fondo-tarjeta h1 {
                font-size: 2rem;
            }

            .fondo-tarjeta p {
                font-size: 1rem;
            }

            .fondo-tarjeta img {
                max-height: 250px;
            }
        }
    </style>
</head>
<body>

<div class="container py-5 d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="fondo-tarjeta text-center">
        <h1 class="mb-3">🍽️ Bienvenido a los Mejores Restaurantes</h1>
        <p class="mb-5">Explora sabores únicos en un solo lugar</p>

        <div class="mb-4">
            <a href="login.jsp" class="btn btn-primary btn-lg me-4 px-5">Iniciar Sesión</a>
            <a href="registro.jsp" class="btn btn-success btn-lg px-5">Registrarse</a>
        </div>

        <img src="img/login_inicio.png" class="img-fluid" alt="Restaurante imagen de fondo" />
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>