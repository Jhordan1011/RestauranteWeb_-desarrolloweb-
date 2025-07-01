<%-- 
    Document   : seguimiento_pedido
    Created on : 17 jun. 2025, 4:48:46 p. m.
    Author     : User
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%
    String descripcion = (String) session.getAttribute("ultimoPedidoDescripcion");
    String direccion = (String) session.getAttribute("ultimoPedidoDireccion");
    String telefonos = (String) session.getAttribute("telefonosRestaurantes");
    String metodoPago = (String) session.getAttribute("ultimoMetodoPago");

    List<modelo.Restaurante> restaurantesInvolucrados = (List<modelo.Restaurante>) session.getAttribute("restaurantesInvolucrados");

    Double latCliente = (Double) session.getAttribute("latCliente");
    Double lonCliente = (Double) session.getAttribute("lonCliente");

    if (latCliente == null) latCliente = -12.1070;
    if (lonCliente == null) lonCliente = -77.0050;

    JSONArray restaurantesArray = new JSONArray();
    if (restaurantesInvolucrados != null) {
        for (modelo.Restaurante r : restaurantesInvolucrados) {
            JSONObject obj = new JSONObject();
            obj.put("nombre", r.getNombre());
            obj.put("latitud", r.getLatitud());
            obj.put("longitud", r.getLongitud());
            restaurantesArray.put(obj);
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seguimiento del Pedido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.min.js"></script>
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
        <strong>Estado actual:</strong> <span id="estadoTexto">🧑‍🍳 Preparando pedido...</span>
    </div>

    <% if (restaurantesInvolucrados != null && !restaurantesInvolucrados.isEmpty()) { %>
        <h4>🏠 Restaurante(s) involucrado(s):</h4>
        <ul>
        <% for (modelo.Restaurante r : restaurantesInvolucrados) { %>
            <li>
                <strong><%= r.getNombre() %></strong> – <%= r.getDireccion() %>
            </li>
        <% } %>
        </ul>
    <% } %>

    <h4>📍 Dirección de entrega:</h4>
    <p><%= direccion != null ? direccion : "No disponible" %></p>

    <h4>📞 Teléfonos de contacto:</h4>
    <p><%= telefonos != null ? telefonos : "No disponible" %></p>

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

    <div class="text-center mt-4 d-flex justify-content-center gap-3">
    <a href="<%= request.getContextPath() %>/restaurantes" class="btn btn-primary">🔙 Volver al Menú</a>
    <a href="logout" class="btn btn-danger">🚪 Cerrar sesión</a>

</div>



</div>

<script>
    const latCliente = <%= latCliente %>;
    const lonCliente = <%= lonCliente %>;
    const restaurantes = JSON.parse('<%= restaurantesArray.toString().replaceAll("\"", "\\\"") %>');

    let totalLat = latCliente;
    let totalLon = lonCliente;
    let count = 1;

    restaurantes.forEach(r => {
        totalLat += r.latitud;
        totalLon += r.longitud;
        count++;
    });

    const centroLat = totalLat / count;
    const centroLon = totalLon / count;

    const map = L.map('map').setView([centroLat, centroLon], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Marcador cliente
    L.marker([latCliente, lonCliente])
        .addTo(map)
        .bindPopup("🏠 Dirección de entrega");

    // Marcadores y rutas desde restaurantes
    restaurantes.forEach(r => {
        const marker = L.marker([r.latitud, r.longitud])
            .addTo(map)
            .bindPopup("📍 Restaurante: " + r.nombre);

        // Dibujar ruta
        L.Routing.control({
            waypoints: [
                L.latLng(r.latitud, r.longitud),
                L.latLng(latCliente, lonCliente)
            ],
            routeWhileDragging: false,
            draggableWaypoints: false,
            addWaypoints: false,
            show: false,
            createMarker: () => null
        }).addTo(map);
    });

    // Estado animado
    const estadoTexto = document.getElementById("estadoTexto");
    setTimeout(() => estadoTexto.innerText = "🛵 En camino...", 5000);
    setTimeout(() => estadoTexto.innerText = "✅ Entregado", 15000);
</script>

</body>
</html>




