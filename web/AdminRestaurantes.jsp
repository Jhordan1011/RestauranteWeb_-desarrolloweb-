
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Restaurante" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Administrar Restaurantes</title>
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
    .img-preview {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 0.5rem;
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

    <a href="${pageContext.request.contextPath}/adminRestaurantes" class="list-group-item active">Restaurantes</a>
    <a href="${pageContext.request.contextPath}/logout" class="list-group-item text-danger">
      <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
    </a>
  </div>
</div>

<!-- Contenido -->
<div class="content">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h3>Restaurantes</h3>
    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregar">
      <i class="bi bi-plus-lg"></i> Añadir Restaurante
    </button>
  </div>

     <!-- Campo de búsqueda -->
  <div class="mb-3">
    <input type="text" id="busquedaRestaurantes" class="form-control" placeholder="Buscar restaurante por nombre o dirección...">
  </div>
    
  <table class="table table-bordered align-middle">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Descripción</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Latitud</th>
        <th>Longitud</th>
        <th>Acciones</th>
        
      </tr>
    </thead>
    <tbody>
      <%
        List<Restaurante> restaurantes = (List<Restaurante>) request.getAttribute("restaurantes");
        if (restaurantes != null) {
          for (Restaurante r : restaurantes) {
      %>
      <tr>
        <td><%= r.getId() %></td>
        <td><%= r.getNombre() %></td>
        <td><%= r.getDescripcion() %></td>
        <td><%= r.getDireccion() %></td>
        <td><%= r.getTelefono() %></td>
        <td><%= r.getLatitud() %></td>
        <td><%= r.getLongitud() %></td>
     
        <td>
          <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#modalEditar"
          onclick="llenarModalEditar('<%= r.getId() %>', '<%= r.getNombre() %>', '<%= r.getDescripcion() %>', '<%= r.getDireccion() %>', '<%= r.getTelefono() %>', '<%= r.getImagenUrl() %>', '<%= r.getLatitud() %>', '<%= r.getLongitud() %>')">
          <i class="bi bi-pencil-square"></i>
        </button>

          <form method="post" action="adminRestaurantes" style="display:inline">
            <input type="hidden" name="accion" value="eliminar">
            <input type="hidden" name="id" value="<%= r.getId() %>">
            <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
          </form>
        </td>
      </tr>
      <% } } %>
    </tbody>
  </table>
</div>

<!-- Modal Agregar -->
<div class="modal fade" id="modalAgregar" tabindex="-1">
  <div class="modal-dialog">
    <form method="post" action="adminRestaurantes" enctype="multipart/form-data">
      <input type="hidden" name="accion" value="crear">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title">Añadir Restaurante</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-2"><label>Nombre</label><input type="text" name="nombre" class="form-control" required></div>
          <div class="mb-2"><label>Descripción</label><textarea name="descripcion" class="form-control" required></textarea></div>
          <div class="mb-2"><label>Dirección</label><input type="text" name="direccion" class="form-control" required></div>
          <div class="mb-2"><label>Teléfono</label><input type="text" name="telefono" class="form-control" required></div>
          <div class="mb-2"><label>Imagen</label><input type="file" name="imagen" class="form-control" accept="image/*" required></div>
          <div class="mb-2"><label>Latitud</label><input type="text" name="latitud" class="form-control" required></div>
          <div class="mb-2"><label>Longitud</label><input type="text" name="longitud" class="form-control" required></div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button class="btn btn-success">Guardar</button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- Modal Editar -->
<div class="modal fade" id="modalEditar" tabindex="-1">
  <div class="modal-dialog">
    <form method="post" action="adminRestaurantes" enctype="multipart/form-data">
      <input type="hidden" name="accion" value="editar">
      <input type="hidden" id="editId" name="id">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Editar Restaurante</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-2">
            <label>Nombre</label>
            <input type="text" id="editNombre" name="nombre" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Descripción</label>
            <textarea id="editDescripcion" name="descripcion" class="form-control" required></textarea>
          </div>
          <div class="mb-2">
            <label>Dirección</label>
            <input type="text" id="editDireccion" name="direccion" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Teléfono</label>
            <input type="text" id="editTelefono" name="telefono" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Latitud</label>
            <input type="text" id="editLatitud" name="latitud" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Longitud</label>
            <input type="text" id="editLongitud" name="longitud" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Nueva Imagen (opcional)</label>
            <input type="file" name="imagen" class="form-control" accept="image/*">
          </div>
          <input type="hidden" id="editImagenUrl" name="imagenUrl">
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button class="btn btn-primary">Guardar Cambios</button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- Script de búsqueda -->
<script>
  document.getElementById('busquedaRestaurantes').addEventListener('keyup', function () {
    let filtro = this.value.toLowerCase();
    let filas = document.querySelectorAll('table tbody tr');

    filas.forEach(fila => {
      let nombre = fila.cells[1].textContent.toLowerCase();
      let direccion = fila.cells[3].textContent.toLowerCase();

      if (nombre.includes(filtro) || direccion.includes(filtro)) {
        fila.style.display = '';
      } else {
        fila.style.display = 'none';
      }
    });
  });
</script>

<script>
  function llenarModalEditar(id, nombre, descripcion, direccion, telefono, imagenUrl, latitud, longitud) {
    document.getElementById("editId").value = id;
    document.getElementById("editNombre").value = nombre;
    document.getElementById("editDescripcion").value = descripcion;
    document.getElementById("editDireccion").value = direccion;
    document.getElementById("editTelefono").value = telefono;
    document.getElementById("editImagenUrl").value = imagenUrl;
    document.getElementById("editLatitud").value = latitud;
    document.getElementById("editLongitud").value = longitud;
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>




