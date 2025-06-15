<%-- 
    Document   : registro
    Created on : 20 may. 2025, 10:38:20 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .register-card {
            max-width: 500px;
            margin: auto;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(255, 215, 0, 0.2);
            background-color: #111;
            padding: 2rem;
            border: 1px solid #FFD700;
        }

        .form-label {
            color: #FFD700;
            font-weight: 500;
        }

        .form-control {
            background-color: #222;
            color: #fff;
            border: 1px solid #FFD700;
            border-radius: 10px;
        }

        .form-control:focus {
            border-color: #e6c200;
            box-shadow: 0 0 0 0.2rem rgba(255, 215, 0, 0.25);
        }

        .btn-success {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border-radius: 10px;
            font-size: 1.1rem;
            border: none;
        }

        .btn-success:hover {
            background-color: #e6c200;
        }

        h3 {
            color: #FFD700;
        }

        a.text-primary {
            color: #FFD700 !important;
        }

        a.text-primary:hover {
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .register-card {
                max-width: 100%;
                border-radius: 0;
                box-shadow: none;
                border: none;
                padding: 1.5rem 1rem;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="register-card">
        <h3 class="mb-4 text-center fw-bold">Registro de Usuario</h3>
        <form action="${pageContext.request.contextPath}/UsuarioController" method="post" novalidate>
            <div class="mb-3">
                <label for="nombreCompleto" class="form-label">Nombre completo</label>
                <input type="text" class="form-control" id="nombreCompleto" name="nombreCompleto" required placeholder="Tu nombre completo">
            </div>
            <div class="mb-3">
                <label for="correo" class="form-label">Correo electrónico</label>
                <input type="email" class="form-control" id="correo" name="correo" required placeholder="tucorreo@ejemplo.com">
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" required placeholder="Número de teléfono">
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección</label>
                <input type="text" class="form-control" id="direccion" name="direccion" required placeholder="Tu dirección">
            </div>
            <div class="mb-4">
                <label for="contrasena" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" required placeholder="********">
            </div>
            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-success btn-lg">Registrarse</button>
            </div>
        </form>
        <p class="text-center">
            ¿Ya tienes una cuenta? <a href="login.jsp" class="text-primary text-decoration-none fw-semibold">Inicia sesión</a>
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>





