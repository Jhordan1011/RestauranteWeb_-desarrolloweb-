<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Panel de Administración</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <style>
    body {
      min-height: 100vh;
      display: flex;
    }
    .sidebar {
      width: 250px;
      background-color: #212529;
      padding: 1rem;
    }
    .sidebar .list-group-item {
      background-color: transparent;
      color: #fff;
      border: none;
    }
    .sidebar .list-group-item:hover,
    .sidebar .list-group-item.active {
      background-color: #343a40;
      color: #ffc107;
    }
    .content {
      flex-grow: 1;
      padding: 2rem;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h5 class="text-white mb-4"><i class="bi bi-person-gear me-2"></i>Administrador</h5>
    <div class="list-group">
      <a href="${pageContext.request.contextPath}/adminPedidos.jsp" class="list-group-item">Pedidos</a>
      <a href="${pageContext.request.contextPath}/AdminPlatos.jsp" class="list-group-item">Platos</a>
      <a href="${pageContext.request.contextPath}/AdminReembolsos.jsp" class="list-group-item">Reembolsos</a>
      <a href="${pageContext.request.contextPath}/AdminReportes.jsp" class="list-group-item">Reportes</a>
      <a href="${pageContext.request.contextPath}/AdminRestaurantes.jsp" class="list-group-item">Restaurantes</a>
      <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
  </a>
    </div>
  </div>

  <!-- Contenido principal -->
  <div class="content">
    <h2>Bienvenido al panel del administrador</h2>
    <p>Selecciona una sección del menú lateral para comenzar.</p>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
