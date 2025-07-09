<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Administrar Restaurantes</title>
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
    <a href="${pageContext.request.contextPath}/AdminPlatos.jsp" class="list-group-item">Platos</a>
    <a href="${pageContext.request.contextPath}/AdminReembolsos.jsp" class="list-group-item">Reembolsos</a>
    <a href="${pageContext.request.contextPath}/AdminReportes.jsp" class="list-group-item">Reportes</a>
    <a href="${pageContext.request.contextPath}/AdminRestaurantes.jsp" class="list-group-item active">Restaurantes</a>
     <a href="${pageContext.request.contextPath}/logout" class="list-group-item text-danger">
    <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
  </a>
  </div>
</div>

<!-- Contenido -->
<div class="content">
  <h3 class="mb-4">Restaurantes</h3>

  <table class="table table-bordered align-middle">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Descripción</th>
        <th>Dirección</th>
        <th>Teléfono</th>
        <th>Imagen</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <!-- Ejemplo de restaurante -->
      <tr>
        <td>1</td>
        <td>La Casona</td>
        <td>Comida criolla tradicional</td>
        <td>Av. Los Incas 789</td>
        <td>999888777</td>
        <td><img src="https://via.placeholder.com/60" class="img-preview" /></td>
        <td>
          <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#modalEditar"
            onclick="llenarModalEditar('1','La Casona','Comida criolla tradicional','Av. Los Incas 789','999888777','https://via.placeholder.com/60')">
            <i class="bi bi-pencil-square"></i>
          </button>
          <button class="btn btn-sm btn-outline-danger me-1"><i class="bi bi-trash"></i></button>
          <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalAgregar">
            <i class="bi bi-plus-lg"></i>
          </button>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<!-- Modal Agregar -->
<div class="modal fade" id="modalAgregar" tabindex="-1">
  <div class="modal-dialog">
    <form method="post" action="#">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title">Añadir Restaurante</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-2">
            <label>Nombre</label>
            <input type="text" name="nombre" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Descripción</label>
            <textarea name="descripcion" class="form-control" required></textarea>
          </div>
          <div class="mb-2">
            <label>Dirección</label>
            <input type="text" name="direccion" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>Teléfono</label>
            <input type="text" name="telefono" class="form-control" required>
          </div>
          <div class="mb-2">
            <label>URL de Imagen</label>
            <input type="text" name="imagenUrl" class="form-control" required>
          </div>
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
    <form method="post" action="#">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Editar Restaurante</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" id="editId" name="id">
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
            <label>URL de Imagen</label>
            <input type="text" id="editImagenUrl" name="imagenUrl" class="form-control" required>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button class="btn btn-primary">Guardar Cambios</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  function llenarModalEditar(id, nombre, descripcion, direccion, telefono, imagenUrl) {
    document.getElementById("editId").value = id;
    document.getElementById("editNombre").value = nombre;
    document.getElementById("editDescripcion").value = descripcion;
    document.getElementById("editDireccion").value = direccion;
    document.getElementById("editTelefono").value = telefono;
    document.getElementById("editImagenUrl").value = imagenUrl;
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
