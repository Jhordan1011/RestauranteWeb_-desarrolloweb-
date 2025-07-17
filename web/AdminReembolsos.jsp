<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Reembolso" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Administrar Reembolsos</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <style>
    body { min-height: 100vh; display: flex; }
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
    <a href="${pageContext.request.contextPath}/adminPedidos" class="list-group-item">Pedidos</a>
    <a href="${pageContext.request.contextPath}/adminPlatos" class="list-group-item">Platos</a>
    <a href="${pageContext.request.contextPath}/adminReembolsos" class="list-group-item active">Reembolsos</a>
    <a href="${pageContext.request.contextPath}/adminReportes" class="list-group-item">Reportes</a>
    <a href="${pageContext.request.contextPath}/adminRestaurantes" class="list-group-item">Restaurantes</a>
    <a href="${pageContext.request.contextPath}/logout" class="list-group-item text-danger">
      <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
    </a>
  </div>
</div>

<!-- Contenido -->
<div class="content">
  <h3 class="mb-4">Solicitudes de Reembolso</h3>
  
  <div class="mb-3">
  <input type="text" id="buscadorReembolsos" class="form-control" placeholder="Buscar reembolso por ID, usuario, estado, motivo..." onkeyup="filtrarReembolsos()">
</div>


  <table class="table table-bordered align-middle">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Pedido</th>
        <th>Usuario</th>
        <th>Motivo</th>
        <th>Fecha</th>
        <th>Estado</th>
        
        <th>Observaciones</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <%
        List<Reembolso> lista = (List<Reembolso>) request.getAttribute("reembolsos");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (lista != null) {
          for (Reembolso r : lista) {
      %>
      <tr>
        <td><%= r.getId() %></td>
        <td><%= r.getPedidoId() %></td>
        <td><%= r.getUsuarioId() %></td>
        <td><%= r.getMotivo() %></td>
        <td><%= sdf.format(r.getFechaSolicitud()) %></td>
        <td><%= r.getEstado() %></td>
     
        <td><%= r.getObservacionesAdmin() %></td>
        <td>
          <button class="btn btn-sm btn-success mb-1" data-bs-toggle="modal"
                  data-bs-target="#modalResponder"
                  onclick="prepararReembolso(<%= r.getId() %>, 'aprobado')">
            <i class="bi bi-check-lg"></i>
          </button>
          <button class="btn btn-sm btn-danger" data-bs-toggle="modal"
                  data-bs-target="#modalResponder"
                  onclick="prepararReembolso(<%= r.getId() %>, 'rechazado')">
            <i class="bi bi-x-lg"></i>
          </button>
        </td>
      </tr>
      <% } } %>
    </tbody>
  </table>
</div>

<!-- Modal Aprobar/Rechazar -->
<div class="modal fade" id="modalResponder" tabindex="-1">
  <div class="modal-dialog">
    <form method="post" action="adminReembolsos">
      <input type="hidden" name="accion" value="responder">
      <input type="hidden" id="reembolsoId" name="id">
      <input type="hidden" id="nuevoEstado" name="estado">
      <div class="modal-content">
        <div class="modal-header bg-warning">
          <h5 class="modal-title">Responder Reembolso</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="observaciones" class="form-label">Observaciones del Administrador:</label>
            <textarea name="observaciones" id="observaciones" rows="4" class="form-control"
                      placeholder="Escribe una observación para justificar tu decisión..." required></textarea>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button class="btn btn-warning">Enviar Respuesta</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  function filtrarReembolsos() {
    const input = document.getElementById("buscadorReembolsos");
    const filtro = input.value.toLowerCase();
    const filas = document.querySelectorAll("tbody tr");

    filas.forEach(fila => {
      const textoFila = fila.innerText.toLowerCase();
      fila.style.display = textoFila.includes(filtro) ? "" : "none";
    });
  }
</script>


<script>
  function prepararReembolso(id, estado) {
    document.getElementById("reembolsoId").value = id;
    document.getElementById("nuevoEstado").value = estado;
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
