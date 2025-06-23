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

    Double latRestaurante = (Double) session.getAttribute("latRestaurante");
    Double lonRestaurante = (Double) session.getAttribute("lonRestaurante");
    Double latCliente = (Double) session.getAttribute("latCliente");
    Double lonCliente = (Double) session.getAttribute("lonCliente");

    if (latRestaurante == null) latRestaurante = -12.1220;
    if (lonRestaurante == null) lonRestaurante = -77.0300;
    if (latCliente == null) latCliente = -12.1070;
    if (lonCliente == null) lonCliente = -77.0050;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seguimiento del Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
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
        #map {
            height: 400px;
            border-radius: 10px;
            border: 3px solid #FFD700;
            margin-top: 20px;
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
                        } catch (Exception e) { }
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

    <h4 class="mt-5">🗺 Mapa de ubicación</h4>
    <div id="map"></div>

    <div class="text-center mt-4">
        <a href="seleccionar_restaurante.jsp" class="btn btn-primary">🛒 Hacer otro pedido</a>
    </div>

</div>

<!-- Leaflet Mapa -->
<script>
    const latRestaurante = <%= latRestaurante %>;
    const lonRestaurante = <%= lonRestaurante %>;
    const latCliente = <%= latCliente %>;
    const lonCliente = <%= lonCliente %>;

    const centroLat = (latRestaurante + latCliente) / 2;
    const centroLon = (lonRestaurante + lonCliente) / 2;

    const map = L.map('map').setView([centroLat, centroLon], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    L.marker([latRestaurante, lonRestaurante])
        .addTo(map)
        .bindPopup("📍 Restaurante")
        .openPopup();

    L.marker([latCliente, lonCliente])
        .addTo(map)
        .bindPopup("🏠 Entrega");
</script>

</body>
</html>
