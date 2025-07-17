<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%
    HttpSession sesion = request.getSession();
    String mensaje = (String) sesion.getAttribute("mensajeReembolso");
    if (mensaje != null) {
        sesion.removeAttribute("mensajeReembolso");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Solicitud de Reembolso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom, #1a1a1a, #333);
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }
        .reembolso-box {
            background-color: #222;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px #000;
            max-width: 700px;
            margin: auto;
        }
        h2 {
            color: #FFD700;
        }
        label {
            font-weight: bold;
            margin-bottom: 6px;
        }
        .form-control,
        .form-select,
        textarea {
            background-color: #333;
            color: #fff;
            border: 1px solid #555;
        }
        .form-control::placeholder,
        textarea::placeholder {
            color: #aaa;
        }
        .btn-warning {
            font-weight: bold;
            color: #000;
        }
        .alert-info {
            background-color: #444;
            border-color: #FFD700;
            color: #fff;
        }
        .btn-secondary {
            background-color: #555;
            border: none;
        }
        .btn-secondary:hover {
            background-color: #666;
        }
    </style>
</head>
<body>

    <div class="reembolso-box">
        <h2 class="mb-4">📋 Solicitud de Reembolso</h2>

        <% if (mensaje != null) { %>
            <div class="alert alert-info"><%= mensaje %></div>
        <% } %>

        <form method="post" action="registrarReembolso">
            <div class="mb-3">
                <label for="pedidoId" class="form-label">Número de Pedido:</label>
                <input type="number" class="form-control" id="pedidoId" name="pedidoId" placeholder="Ej: 123" required>
            </div>

            <div class="mb-3">
                <label for="motivo" class="form-label">Motivo del Reembolso:</label>
                <select class="form-select" id="motivo" name="motivo" required>
                    <option value="">-- Seleccionar motivo --</option>
                    <option value="Pedido incorrecto">Pedido incorrecto</option>
                    <option value="Plato incompleto">Plato incompleto</option>
                    <option value="Entrega tardía">Entrega tardía</option>
                    <option value="Problemas con el pago">Problemas con el pago</option>
                    <option value="Otro">Otro</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="comentario" class="form-label">Comentarios adicionales:</label>
                <textarea class="form-control" id="comentario" name="comentario" rows="4"
                          placeholder="Describe el problema con tu pedido..." required></textarea>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-warning">Enviar Solicitud</button>
            </div>
        </form>

        <div class="mt-4">
            <a href="seguimiento_pedido.jsp" class="btn btn-secondary">⬅ Volver al Seguimiento</a>
        </div>
    </div>

</body>
</html>
