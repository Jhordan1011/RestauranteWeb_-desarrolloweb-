<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Pedido" %>
<%
  List<Pedido> pedidos = (List<Pedido>) request.getAttribute("pedidos");
%>

<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Panel de Administraci�n</title>
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
            <th>Direcci�n</th>
            <th>Notas</th>
            <th>M�todo Pago</th>
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
                '<%= p.getDireccionEntrega().replace("\"", "\\\"") %>',
                '<%= p.getNotas() != null ? p.getNotas().replace("\"", "\\\"") : "" %>',
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
                <h5 class="modal-title" id="modalEditarPedidoLabel">Editar Pedido #<span id="pedidoNumero"></span></h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
                <form method="post" action="EditarPedidoServlet" id="formEditarPedido">
                    <input type="hidden" id="pedidoId" name="id">
                    <div class="mb-3">
                        <label class="form-label">Estado</label>
                        <select class="form-select" id="estadoPedido" name="estado" required>
                            <option value="procesando">Procesando</option>
                            <option value="entregado">Entregado</option>
                            <option value="cancelado">Cancelado</option>
                            <option value="pendiente">Pendiente</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Direcci�n</label>
                        <input type="text" class="form-control" id="direccionPedido" name="direccion" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Notas</label>
                        <textarea class="form-control" rows="3" id="notasPedido" name="notas"></textarea>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">M�todo de Pago</label>
                        <select class="form-select" id="metodoPagoPedido" name="metodoPago" required>
                            <option value="TARJETA">Tarjeta</option>
                            <option value="YAPE">Yape</option>
                            <option value="EFECTIVO">Efectivo</option>
                            <option value="TRANSFERENCIA">Transferencia</option>
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
            <p>�Est�s seguro de que deseas eliminar este pedido?</p>
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
function llenarModalEditar(id, direccion, notas, metodoPago, estado) {
    // Mostrar el ID del pedido en el t�tulo
    document.getElementById("pedidoNumero").textContent = id;
    
    // Llenar campos del formulario
    document.getElementById("pedidoId").value = id;
    document.getElementById("direccionPedido").value = direccion;
    document.getElementById("notasPedido").value = notas || "";
    
    // Seleccionar el estado correcto
    const estadoSelect = document.getElementById("estadoPedido");
    for (let i = 0; i < estadoSelect.options.length; i++) {
        if (estadoSelect.options[i].value === estado.toLowerCase()) {
            estadoSelect.selectedIndex = i;
            break;
        }
    }
    
    // Seleccionar el m�todo de pago correcto
    const metodoPagoSelect = document.getElementById("metodoPagoPedido");
    for (let i = 0; i < metodoPagoSelect.options.length; i++) {
        if (metodoPagoSelect.options[i].value === metodoPago.toUpperCase()) {
            metodoPagoSelect.selectedIndex = i;
            break;
        }
    }
}

// Validaci�n del formulario antes de enviar
document.getElementById("formEditarPedido").addEventListener("submit", function(e) {
    const direccion = document.getElementById("direccionPedido").value.trim();
    if (!direccion) {
        e.preventDefault();
        alert("La direcci�n es requerida");
        return false;
    }
    return true;
});
</script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
