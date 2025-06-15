<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:42:31 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Fuego Parrilla</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-danger-subtle p-3">
    <div class="container">
        <!-- Logo -->
        <div class="text-center mb-4">
            <img src="../../img/logo_fuego_parrilla.jpg" alt="Logo Fuego Parrilla" style="max-width: 180px;" />
       </div>

        <h2 class="text-center mb-2">Restaurante: Fuego Parrilla</h2>
        <p class="text-center mb-4 fst-italic">
            El arte de la parrilla con fuego y pasión
        </p>

        <ul class="list-group">
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/bife_de_chorizo.jpg" alt="Bife de Chorizo" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Bife de Chorizo</strong><br />
                        Precio: S/ 50.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Bife de Chorizo" />
                    <input type="hidden" name="precio" value="50.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Bife de Chorizo al carrito">Agregar al carrito</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/entraña.jpg" alt="Entraña" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Entraña</strong><br />
                        Precio: S/ 48.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Entraña" />
                    <input type="hidden" name="precio" value="48.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Entraña al carrito">Agregar al carrito</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/churrasco.jpg" alt="Churrasco" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Churrasco</strong><br />
                        Precio: S/ 45.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Churrasco" />
                    <input type="hidden" name="precio" value="45.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Churrasco al carrito">Agregar al carrito</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/pollo_a_la_parrilla.jpg" alt="Pollo a la Parrilla" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Pollo a la Parrilla</strong><br />
                        Precio: S/ 38.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Pollo a la Parrilla" />
                    <input type="hidden" name="precio" value="38.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Pollo a la Parrilla al carrito">Agregar al carrito</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/chorizo_a_la_parrilla.jpg" alt="Chorizo a la Parrilla" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Chorizo a la Parrilla</strong><br />
                        Precio: S/ 35.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Chorizo a la Parrilla" />
                    <input type="hidden" name="precio" value="35.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Chorizo a la Parrilla al carrito">Agregar al carrito</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/verduras_asadas.jpg" alt="Verduras Asadas" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Verduras Asadas</strong><br />
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post">
                    <input type="hidden" name="nombre" value="Verduras Asadas" />
                    <input type="hidden" name="precio" value="25.00" />
                    <button type="submit" class="btn btn-primary btn-sm" title="Agregar Verduras Asadas al carrito">Agregar al carrito</button>
                </form>
            </li>
        </ul>
    </div>
</body>
</html>




