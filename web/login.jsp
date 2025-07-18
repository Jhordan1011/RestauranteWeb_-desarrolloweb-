<%-- 
    Document   : login
    Created on : 20 may. 2025, 10:37:35 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .login-card {
            max-width: 900px;
            margin: auto;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 12px 35px rgba(255, 215, 0, 0.2);
            background-color: #111;
            border: 1px solid #FFD700;
        }

        .login-image {
            background-image: url('img/login_inicio.png');
            background-size: cover;
            background-position: center;
            min-height: 400px;
        }

        .login-form {
            padding: 3rem;
        }

        .form-label {
            font-weight: 500;
            color: #FFD700;
        }

        .form-control {
            border-radius: 10px;
            background-color: #222;
            color: #fff;
            border: 1px solid #FFD700;
        }

        .form-control:focus {
            border-color: #e6c200;
            box-shadow: 0 0 0 0.2rem rgba(255, 215, 0, 0.25);
        }

        .btn-success {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
        }

        .btn-success:hover {
            background-color: #e6c200;
        }

        a.text-success {
            color: #FFD700 !important;
        }

        a.text-success:hover {
            text-decoration: underline;
        }

        h3 {
            color: #FFD700;
        }

        @media (max-width: 767px) {
            .login-card {
                max-width: 100%;
                border-radius: 0;
                box-shadow: none;
                border: none;
            }

            .login-image {
                min-height: 220px;
            }

            .login-form {
                padding: 2rem 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class="container my-5">
    <div class="login-card row g-0">
        <!-- Imagen decorativa -->
        <div class="col-md-6 d-none d-md-block login-image"></div>

        <!-- Formulario de login -->
        <div class="col-md-6 login-form">
            <h3 class="mb-4 text-center">🔐 Iniciar Sesión</h3>
            <form action="${pageContext.request.contextPath}/LoginController" method="post" novalidate>
                <div class="mb-3">
                    <label for="correo" class="form-label">Correo electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" required placeholder="tucorreo@ejemplo.com">
                </div>
                <div class="mb-4">
                    <label for="contrasena" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="contrasena" name="contrasena" required placeholder="********">
                </div>
                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-success btn-lg">Ingresar</button>
                </div>
            </form>
            <p class="text-center mt-4">
                ¿No tienes una cuenta? <a href="registro.jsp" class="text-success text-decoration-none fw-semibold">Regístrate aquí</a>
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>