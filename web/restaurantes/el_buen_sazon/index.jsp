<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>El Buen Sazón</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-danger-subtle p-3">
    <div class="container">
        <div class="text-center mb-4">
            <img src="../../img/logo_el_buen_sazon.jpg" alt="Logo El Buen Sazón" style="max-width: 180px;" />
         </div>

        <h2 class="text-center mb-2">Restaurante: El Buen Sazón</h2>
        <p class="text-center mb-4 fst-italic">
            Recetas caseras que conquistan paladares
        </p>

        <c:choose>
            <c:when test="${not empty platos}">
                <ul class="list-group">
                    <c:forEach items="${platos}" var="plato">
                        <li class="list-group-item d-flex align-items-center justify-content-between mb-2">
                            <div class="d-flex align-items-center">
                                <img src="../../img/${plato.imagenUrl}" alt="${plato.nombre}" 
                                     class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                                <div>
                                    <strong>${plato.nombre}</strong><br />
                                    <span class="text-success">Precio: S/ ${plato.precio}</span>
                                </div>
                            </div>
                            <form action="../../CarritoServlet" method="post">
                                <input type="hidden" name="id" value="${plato.id}" />
                                <input type="hidden" name="nombre" value="${plato.nombre}" />
                                <input type="hidden" name="precio" value="${plato.precio}" />
                                <input type="hidden" name="restauranteId" value="${plato.restauranteId}" />
                                <button type="submit" class="btn btn-primary btn-sm">Agregar al carrito</button>
                            </form>
                        </li>
                    </c:forEach>    
                </ul>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">No hay platos disponibles en este momento.</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>