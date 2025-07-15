<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<%
    String platosJson = (String) request.getAttribute("platosMasPedidos");
    String restaurantesJson = (String) request.getAttribute("restaurantesMasPedidos");
    String pedidosDiaJson = (String) request.getAttribute("pedidosPorDia");
    String pedidosMesJson = (String) request.getAttribute("pedidosPorMes");
    String metodosPagoJson = (String) request.getAttribute("metodosPagoUsados");
    String usuariosJson = (String) request.getAttribute("usuariosFrecuentes");

    JSONArray platos = new JSONArray();
    JSONArray restaurantes = new JSONArray();
    JSONArray pedidosDia = new JSONArray();
    JSONArray pedidosMes = new JSONArray();
    JSONArray metodosPago = new JSONArray();
    JSONArray usuarios = new JSONArray();

    if (platosJson != null) platos = new JSONArray(platosJson);
    if (restaurantesJson != null) restaurantes = new JSONArray(restaurantesJson);
    if (pedidosDiaJson != null) pedidosDia = new JSONArray(pedidosDiaJson);
    if (pedidosMesJson != null) pedidosMes = new JSONArray(pedidosMesJson);
    if (metodosPagoJson != null) metodosPago = new JSONArray(metodosPagoJson);
    if (usuariosJson != null) usuarios = new JSONArray(usuariosJson);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reportes</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light p-5">

<h2 class="text-warning mb-4">📊 Reportes del Administrador</h2>


<form method="get" action="adminReportes" class="mb-4 row g-3">
    <div class="col-md-4">
        <label class="form-label text-white">Fecha Inicio:</label>
        <input type="date" name="fechaInicio" class="form-control" required>
    </div>
    <div class="col-md-4">
        <label class="form-label text-white">Fecha Fin:</label>
        <input type="date" name="fechaFin" class="form-control" required>
    </div>
    <div class="col-md-4 d-flex align-items-end">
        <button type="submit" class="btn btn-warning w-100">Filtrar</button>
    </div>
</form>


<div class="mt-5">
    <a href="${pageContext.request.contextPath}/AdminI.jsp" class="btn btn-secondary">⬅ Volver</a>

</div>
    
<div class="mb-4">
    <a href="exportarReportes" class="btn btn-warning">📥 Exportar Reporte en PDF</a>
</div>

<div class="row">
    <div class="col-md-6">
        <h5>🍽 Platos más pedidos</h5>
        <canvas id="platosChart"></canvas>
    </div>
    <div class="col-md-6">
        <h5>🏠 Restaurantes más pedidos</h5>
        <canvas id="restaurantesChart"></canvas>
    </div>

    <div class="col-md-12 mt-5">
        <h5>📈 Pedidos por Día</h5>
        <canvas id="pedidosPorDiaChart"></canvas>
    </div>

    <div class="col-md-12 mt-5">
        <h5>📅 Pedidos por Mes</h5>
        <canvas id="pedidosPorMesChart"></canvas>
    </div>

    <div class="col-md-6 mt-5">
        <h5>💳 Métodos de Pago más Usados</h5>
        <canvas id="metodosPagoChart"></canvas>
    </div>

    <div class="col-md-6 mt-5">
        <h5>🧑‍💼 Usuarios que más compran</h5>
        <canvas id="usuariosFrecuentesChart"></canvas>
    </div>
</div>

<script>
    const platos = <%= platos.toString() %>;
    const restaurantes = <%= restaurantes.toString() %>;
    const pedidosPorDia = <%= pedidosDia.toString() %>;
    const pedidosPorMes = <%= pedidosMes.toString() %>;
    const metodosPago = <%= metodosPago.toString() %>;
    const usuariosFrecuentes = <%= usuarios.toString() %>;

    const platosLabels = platos.map(p => p.plato);
    const platosData = platos.map(p => p.total);

    const restaurantesLabels = restaurantes.map(r => r.restaurante);
    const restaurantesData = restaurantes.map(r => r.total);

    const pedidosDiaLabels = pedidosPorDia.map(p => p.dia);
    const pedidosDiaData = pedidosPorDia.map(p => p.total);

    const pedidosMesLabels = pedidosPorMes.map(p => p.mes);
    const pedidosMesData = pedidosPorMes.map(p => p.total);

    const metodosLabels = metodosPago.map(m => m.metodo);
    const metodosData = metodosPago.map(m => m.total);

    const usuariosLabels = usuariosFrecuentes.map(u => u.usuario);
    const usuariosData = usuariosFrecuentes.map(u => u.total);

    new Chart(document.getElementById('platosChart'), {
        type: 'bar',
        data: {
            labels: platosLabels,
            datasets: [{
                label: 'Cantidad Pedida',
                data: platosData,
                backgroundColor: '#FFD700'
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    new Chart(document.getElementById('restaurantesChart'), {
        type: 'bar',
        data: {
            labels: restaurantesLabels,
            datasets: [{
                label: 'Total Pedidos',
                data: restaurantesData,
                backgroundColor: '#17a2b8'
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    new Chart(document.getElementById('pedidosPorDiaChart'), {
        type: 'line',
        data: {
            labels: pedidosDiaLabels,
            datasets: [{
                label: 'Pedidos por Día',
                data: pedidosDiaData,
                borderColor: '#4caf50',
                backgroundColor: 'rgba(76, 175, 80, 0.2)',
                tension: 0.4
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    new Chart(document.getElementById('pedidosPorMesChart'), {
        type: 'line',
        data: {
            labels: pedidosMesLabels,
            datasets: [{
                label: 'Pedidos por Mes',
                data: pedidosMesData,
                borderColor: '#ff9800',
                backgroundColor: 'rgba(255, 152, 0, 0.2)',
                tension: 0.4
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });

    new Chart(document.getElementById('metodosPagoChart'), {
        type: 'doughnut',
        data: {
            labels: metodosLabels,
            datasets: [{
                label: 'Métodos de Pago',
                data: metodosData,
                backgroundColor: ['#4CAF50', '#FFC107', '#2196F3', '#FF5722', '#9C27B0']
            }]
        },
        options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
    });

    new Chart(document.getElementById('usuariosFrecuentesChart'), {
        type: 'bar',
        data: {
            labels: usuariosLabels,
            datasets: [{
                label: 'Cantidad de Pedidos',
                data: usuariosData,
                backgroundColor: '#673ab7'
            }]
        },
        options: { responsive: true, plugins: { legend: { display: false } } }
    });
</script>



</body>
</html>

