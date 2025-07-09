<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Administrar Platos</title>
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
    <a href="${pageContext.request.contextPath}/adminPedidos" class="list-group-item">Pedidos</a>
    <a href="${pageContext.request.contextPath}/AdminPlatos.jsp" class="list-group-item active">Platos</a>
    <a href="${pageContext.request.contextPath}/AdminReembolsos.jsp" class="list-group-item">Reembolsos</a>
    <a href="${pageContext.request.contextPath}/AdminReportes.jsp" class="list-group-item">Reportes</a>
    <a href="${pageContext.request.contextPath}/AdminRestaurantes.jsp" class="list-group-item">Restaurantes</a>
     <a href="${pageContext.request.contextPath}/logout" class="list-group-item text-danger">
    <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
  </a>
  </div>
</div>

<!-- Contenido principal -->
<div class="content">
  <h3 class="mb-4">Platos</h3>

  <table class="table table-bordered table-hover align-middle">
    <thead class="table-dark">
      <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Precio (S/)</th>
        <th>Imagen</th>
        <th>ID Restaurante</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>Arroz Chaufa</td>
        <td>18.00</td>
        <td><img src="img/chaufa.jpg" width="60" height="60"></td>
        <td>2</td>
        <td>
          <button class="btn btn-sm btn-outline-primary me-1"
                  data-bs-toggle="modal"
                  data-bs-target="#modalEditar"
                  onclick="llenarModalEditar('1', 'Arroz Chaufa', '18.00', 'img/chaufa.jpg', '2')">
            <i class="bi bi-pencil-square"></i>
          </button>

          <button class="btn btn-sm btn-outline-danger me-1">
            <i class="bi bi-trash"></i>
          </button>

          <button class="btn btn-sm btn-outline-success"
                  data-bs-toggle="modal"
                  data-bs-target="#modalAgregar"
                  title="Añadir nuevo plato">
            <i class="bi bi-plus-lg"></i>
          </button>
        </td>
      </tr>
    </tbody>
  </table>
</div>

<!-- Modal Agregar -->
<div class="modal fade" id="modalAgregar" tabindex="-1" aria-labelledby="modalAgregarLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form method="post" action="#">
      <div class="modal-content">
        <div class="modal-header bg-success text-white">
          <h5 class="modal-title">Añadir Nuevo Plato</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" step="0.01" name="precio" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">URL de Imagen</label>
            <input type="text" name="imagenUrl" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">ID Restaurante</label>
            <input type="number" name="restauranteId" class="form-control" required>
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
<div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="modalEditarLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form method="post" action="#">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title">Editar Plato</h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" id="editId" name="id">
          <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" id="editNombre" name="nombre" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Precio</label>
            <input type="number" step="0.01" id="editPrecio" name="precio" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">URL de Imagen</label>
            <input type="text" id="editImagenUrl" name="imagenUrl" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">ID Restaurante</label>
            <input type="number" id="editRestauranteId" name="restauranteId" class="form-control" required>
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
  function llenarModalEditar(id, nombre, precio, imagenUrl, restauranteId) {
    document.getElementById('editId').value = id;
    document.getElementById('editNombre').value = nombre;
    document.getElementById('editPrecio').value = precio;
    document.getElementById('editImagenUrl').value = imagenUrl;
    document.getElementById('editRestauranteId').value = restauranteId;
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
