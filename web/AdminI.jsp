<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Pedido" %>
<%
  List<Pedido> pedidos = (List<Pedido>) request.getAttribute("pedidos");
%>

<html lang="es">
<head>
  <meta charset="UTF-8" />
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
    .sidebar .list-group-item:hover, .sidebar .list-group-item.active {
      background-color: #343a40;
      color: #ffc107;
    }
    .content {
      flex-grow: 1;
      padding: 2rem;
    }
    .section {
      display: none;
    }
    .section.active {
      display: block;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h5 class="text-white mb-4"><i class="bi bi-person-gear me-2"></i>Administrador</h5>
    <div class="list-group">
      <button class="list-group-item" onclick="mostrarSeccion('pedidos')">Pedidos</button>
      <button class="list-group-item" onclick="mostrarSeccion('platos')">Platos</button>
      <button class="list-group-item" onclick="mostrarSeccion('reembolsos')">Reembolsos</button>
      <button class="list-group-item" onclick="mostrarSeccion('reportes')">Reportes</button>
      <button class="list-group-item" onclick="mostrarSeccion('restaurantes')">Restaurantes</button>
    </div>
  </div>

  <!-- Contenido principal -->
  <div class="content">
    
    <!-- Sección Pedidos -->
    <div id="pedidos" class="section active">
      <h3 class="mb-4">Pedidos</h3>
      <table class="table table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Usuario ID</th>
            <th>Fecha</th>
            <th>Total</th>
            <th>Estado</th>
            <th>Dirección</th>
            <th>Notas</th>
            <th>Método Pago</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>

          <tr>
            <td>101</td>
            <td>23</td>
            <td>2025-06-19</td>
            <td>S/. 53.00</td>
            <td><span class="badge bg-success">Entregado</span></td>
            <td>Av. Los Olivos 123</td>
            <td>Entregar en portería</td>
            <td>Tarjeta</td>
            <td>
              <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#modalEditarPedido">
                <i class="bi bi-pencil-square"></i>
              </button>
              <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarPedido">
                <i class="bi bi-trash"></i>
              </button>
            </td>
          </tr>

          <% if (pedidos != null && !pedidos.isEmpty()) {
     for (Pedido p : pedidos) { %>
<tr>
  <td><%= p.getId() %></td>
  <td><%= p.getUsuarioId() %></td>
  <td><%= p.getFechaPedido()%></td>
  <td>S/. <%= p.getTotal() %></td>
  <td>
    <span class="badge bg-<%= p.getEstado().equalsIgnoreCase("entregado") ? "success" : "warning" %>">
      <%= p.getEstado() %>
    </span>
  </td>
  <td><%= p.getDireccionEntrega() %></td>
  <td><%= p.getNotas() %></td>
  <td><%= p.getMetodoPago() %></td>
  <td>
    <button class="btn btn-sm btn-outline-primary me-1">
      <i class="bi bi-pencil-square"></i>
    </button>
    <button class="btn btn-sm btn-outline-danger">
      <i class="bi bi-trash"></i>
    </button>
  </td>
</tr>
<%  }
   } else { %>
<tr><td colspan="9">No hay pedidos registrados.</td></tr>
<% } %>


        </tbody>
      </table>
    </div>

    <!-- Sección Platos -->
    <div id="platos" class="section">
      <h3 class="mb-4">Platos</h3>
      <table class="table table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Precio</th>
            <th>Restaurante</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>201</td>
            <td>Lomo Saltado</td>
            <td>S/. 28.00</td>
            <td>La Cocina Peruana</td>
            <td>
              <button class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil-square"></i></button>
              <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Sección Reembolsos -->
    <div id="reembolsos" class="section">
      <h3 class="mb-4">Reembolsos</h3>
      <p class="text-muted">No hay solicitudes de reembolso por el momento.</p>
    </div>

    <!-- Sección Reportes -->
    <div id="reportes" class="section">
      <h3 class="mb-4">Reportes</h3>
      <p class="text-muted">Genera informes en PDF de ventas, pedidos y más.</p>
    </div>

    <!-- Sección Restaurantes -->
    <div id="restaurantes" class="section">
      <h3 class="mb-4">Restaurantes</h3>
      <table class="table table-hover align-middle">
        <thead class="table-dark">
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Dirección</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>La Cocina Peruana</td>
            <td>Av. Perú 123</td>
            <td>
              <button class="btn btn-sm btn-outline-primary me-1"><i class="bi bi-pencil-square"></i></button>
              <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>

  <!-- Modal Editar Pedido -->
<div class="modal fade" id="modalEditarPedido" tabindex="-1" aria-labelledby="modalEditarPedidoLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="modalEditarPedidoLabel">Editar Pedido</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label class="form-label">Estado</label>
            <select class="form-select">
              <option>Procesando</option>
              <option selected>Entregado</option>
              <option>Cancelado</option>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Dirección</label>
            <input type="text" class="form-control" value="Av. Los Olivos 123">
          </div>
          <div class="mb-3">
            <label class="form-label">Notas</label>
            <textarea class="form-control" rows="3">Entregar en portería</textarea>
          </div>
          <div class="mb-3">
            <label class="form-label">Método de Pago</label>
            <select class="form-select">
              <option selected>Tarjeta</option>
              <option>Yape</option>
              <option>Efectivo</option>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button type="button" class="btn btn-primary">Guardar Cambios</button>
      </div>
    </div>
  </div>
</div>

  <!-- Modal Eliminar Pedido -->
  <div class="modal fade" id="modalEliminarPedido" tabindex="-1" aria-labelledby="modalEliminarPedidoLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header bg-danger text-white">
          <h5 class="modal-title" id="modalEliminarPedidoLabel">Eliminar Pedido</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body text-center">
          <p>¿Estás seguro de que deseas eliminar este pedido?</p>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="button" class="btn btn-danger">Eliminar</button>
        </div>
      </div>
    </div>
  </div> 

  <!-- Scripts -->
  <script>
    function mostrarSeccion(id) {
      document.querySelectorAll('.section').forEach(sec => sec.classList.remove('active'));
      document.getElementById(id).classList.add('active');
      document.querySelectorAll('.list-group-item').forEach(btn => btn.classList.remove('active'));
      event.target.classList.add('active');
    }
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
