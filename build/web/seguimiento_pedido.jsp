<%-- 
    Document   : seguimiento_pedido
    Created on : 17 jun. 2025, 4:48:46 p. m.
    Author     : User
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String descripcion = (String) session.getAttribute("ultimoPedidoDescripcion");
    String direccion = (String) session.getAttribute("ultimoPedidoDireccion");
    String telefono = (String) session.getAttribute("ultimoPedidoTelefono");
    String metodoPago = (String) session.getAttribute("ultimoMetodoPago");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seguimiento del Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to bottom, #1a1a1a, #333);
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }
        h2, h4 {
            color: #FFD700;
        }
        .seguimiento-box {
            background-color: #222;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 0 15px #000;
        }
        .estado-pedido {
            background-color: #333;
            border-left: 6px solid #FFD700;
            padding: 15px;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }
        .mapa-box {
            text-align: center;
            margin-top: 20px;
        }
        .mapa-box img {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            border: 3px solid #FFD700;
        }
        table {
            background-color: #2a2a2a;
            color: #fff;
        }
        th {
            background-color: #444;
            color: #FFD700;
        }
        .btn {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border: none;
        }
        .btn:hover {
            background-color: #e6c200;
        }
    </style>
</head>
<body>

<div class="container seguimiento-box">

    <h2 class="text-center mb-4">📦 Seguimiento de tu Pedido</h2>

    <div class="estado-pedido">
        <strong>Estado actual:</strong> En camino 🛵
    </div>

    <h4>📍 Dirección de entrega:</h4>
    <p><%= direccion != null ? direccion : "No disponible" %></p>

    <h4>📞 Teléfono de contacto:</h4>
    <p><%= telefono != null ? telefono : "No disponible" %></p>

    <h4>💳 Método de pago:</h4>
    <p><%= metodoPago != null ? metodoPago : "No especificado" %></p>

    <h4>🍽 Platos pedidos:</h4>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Plato</th>
                <th>Precio (S/.)</th>
            </tr>
        </thead>
        <tbody>
        <%
            double total = 0;
            if (descripcion != null) {
                String[] platos = descripcion.split(",");
                for (String p : platos) {
                    String[] partes = p.trim().split(" - ");
                    if (partes.length == 2) {
                        String nombre = partes[0].trim();
                        String precioStr = partes[1].replace("S/", "").trim();
                        try {
                            double precio = Double.parseDouble(precioStr);
                            total += precio;
        %>
            <tr>
                <td><%= nombre %></td>
                <td><%= precio %></td>
            </tr>
        <%
                        } catch (Exception e) {
                            // si no puede convertir el precio, lo ignora
                        }
                    }
                }
            } else {
        %>
            <tr>
                <td colspan="2">No hay platos registrados.</td>
            </tr>
        <%
            }
        %>
            <tr>
                <th class="text-end">Total</th>
                <th><%= total %></th>
            </tr>
        </tbody>
    </table>

    <div class="mapa-box mt-4">
        <h4>🗺 Mapa simulado de entrega</h4>
        <img src="img/mapa_ruta_simulada.png" alt="Mapa del recorrido">
        <p class="mt-2 text-muted">Recorrido desde el restaurante hasta tu dirección</p>
    </div>

    <div class="text-center mt-4">
        <a href="seleccionar_restaurante.jsp" class="btn btn-primary">🛒 Hacer otro pedido</a>
    </div>

</div>

</body>
</html>


