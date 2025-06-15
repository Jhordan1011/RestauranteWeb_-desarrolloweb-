<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Delicias del Norte</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-danger-subtle p-3">
    <div class="container">
        <div class="text-center mb-4">
            <img src="../../img/logo_delicias_del_norte.jpg" alt="Logo Delicias del Norte" style="max-width: 180px;" />
        </div>

        <h2 class="text-center mb-2">Restaurante: Delicias del Norte</h2>
        <p class="text-center mb-4 fst-italic">
            Tradición y sabor del norte peruano en cada bocado
        </p>

        <ul class="list-group">
            <c:forEach items="${platos}" var="plato">
                <li class="list-group-item d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <img src="${pageContext.request.contextPath}/img/${plato.imagenUrl}" alt="${plato.nombre}" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                        <div>
                            <strong>${plato.nombre}</strong><br />
                            Precio: S/ ${plato.precio}
                        </div>
                    </div>
                    <form action="../../CarritoServlet" method="post">
                        <input type="hidden" name="id" value="${plato.id}" />
                        <input type="hidden" name="nombre" value="${plato.nombre}" />
                        <input type="hidden" name="precio" value="${plato.precio}" />
                        <input type="hidden" name="restauranteId" value="1" />
                        <button type="submit" class="btn btn-primary btn-sm">Agregar al carrito</button>
                    </form>
                </li>
            </c:forEach>
        </ul>
    </div>
</body>
</html>