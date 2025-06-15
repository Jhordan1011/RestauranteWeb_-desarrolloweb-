<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sabores Andinos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-warning-subtle p-3"> <!-- Color diferente para cada restaurante -->
    <div class="container">
        <div class="text-center mb-4">
            <img src="../../img/logo_sabores_andinos.jpg" alt="Sabores Andinos" style="max-width: 180px;" />
        </div>

        <h2 class="text-center mb-2">Restaurante: Sabores Andinos</h2>
        <p class="text-center mb-4 fst-italic">
            Auténtica cocina de los Andes peruanos
        </p>

        <c:choose>
            <c:when test="${not empty platos}">
                <ul class="list-group">
                    <c:forEach items="${platos}" var="plato">
                        <li class="list-group-item d-flex align-items-center justify-content-between mb-2">
                            <!-- Mismo formato para todos los platos -->
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">No hay platos disponibles.</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>