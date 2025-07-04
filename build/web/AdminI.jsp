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
    <!-- Seccion Pedidos -->
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
              <button class="btn btn-sm btn-outline-primary me-1"
                      data-bs-toggle="modal"
                      data-bs-target="#modalEditarPedido"
                      onclick="llenarModalEditar(
                        '<%= p.getId() %>',
                        '<%= p.getDireccionEntrega().replace("'", "\\'") %>',
                        '<%= p.getNotas().replace("'", "\\'") %>',
                        '<%= p.getMetodoPago() %>',
                        '<%= p.getEstado() %>'
                      )">
                <i class="bi bi-pencil-square"></i>
              </button>
              <button class="btn btn-sm btn-outline-danger"
                      data-bs-toggle="modal"
                      data-bs-target="#modalEliminarPedido"
                      onclick="llenarModalEliminar('<%= p.getId() %>')">
                <i class="bi bi-trash"></i>
              </button>
            </td>
          </tr>
          <% } 
             } else { %>
          <tr><td colspan="9">No hay pedidos registrados.</td></tr>
          <% } %>
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
          <form method="post" action="EditarPedidoServlet">
            <input type="hidden" id="pedidoId" name="id">
            <div class="mb-3">
              <label class="form-label">Estado</label>
              <select class="form-select" id="estadoPedido" name="estado">
                <option>Procesando</option>
                <option>Entregado</option>
                <option>Cancelado</option>
                <option>Pendiente</option>
              </select>
            </div>
            <div class="mb-3">
              <label class="form-label">Dirección</label>
              <input type="text" class="form-control" id="direccionPedido" name="direccion">
            </div>
            <div class="mb-3">
              <label class="form-label">Notas</label>
              <textarea class="form-control" rows="3" id="notasPedido" name="notas"></textarea>
            </div>
            <div class="mb-3">
              <label class="form-label">Método de Pago</label>
              <select class="form-select" id="metodoPagoPedido" name="metodoPago">
                <option>Tarjeta</option>
                <option>Yape</option>
                <option>Efectivo</option>
                <option>Transferencia</option>
              </select>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Eliminar Pedido -->
  <div class="modal fade" id="modalEliminarPedido" tabindex="-1" aria-labelledby="modalEliminarPedidoLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm modal-dialog-centered">
      <div class="modal-content">
        <form method="post" action="EliminarPedidoServlet">
          <input type="hidden" name="id" id="pedidoEliminarId">
          <div class="modal-header bg-danger text-white">
            <h5 class="modal-title" id="modalEliminarPedidoLabel">Eliminar Pedido</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body text-center">
            <p>¿Estás seguro de que deseas eliminar este pedido?</p>
          </div>
          <div class="modal-footer justify-content-center">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-danger">Eliminar</button>
          </div>
        </form>
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

    function llenarModalEditar(id, direccion, notas, metodoPago, estado) {
      document.getElementById("pedidoId").value = id;
      document.getElementById("direccionPedido").value = direccion;
      document.getElementById("notasPedido").value = notas;
      document.getElementById("metodoPagoPedido").value = metodoPago;
      document.getElementById("estadoPedido").value = estado;
    }

    function llenarModalEliminar(id) {
      document.getElementById("pedidoEliminarId").value = id;
    }
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
