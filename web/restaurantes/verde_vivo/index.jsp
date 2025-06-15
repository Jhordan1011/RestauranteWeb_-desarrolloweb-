<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:42:45 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Verde Vivo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-success-subtle p-3">
    <div class="container mt-5">
        <!-- Logo -->
        <div class="text-center mb-4">
            <img src="../../img/logo_verde_vivo.jpg" alt="Logo Verde Vivo" style="max-width: 180px;" />
        </div>

       <h2 class="text-center mb-2">Restaurante: Verde Vivo</h2>
        <p class="text-center mb-4 fst-italic">
            Cocina natural y saludable para tu bienestar
        </p>

        <ul class="list-group mb-5">
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/ensaladadequinoa.jpg" alt="Ensalada de Quinoa" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Ensalada de Quinoa</strong><br />
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv1" />
                    <input type="hidden" name="nombre" value="Ensalada de Quinoa" />
                    <input type="hidden" name="precio" value="25.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/lasagnadeberenjena.jpg" alt="Lasagna de Berenjena" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Lasagna de Berenjena</strong><br />
                        Precio: S/ 30.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv2" />
                    <input type="hidden" name="nombre" value="Lasagna de Berenjena" />
                    <input type="hidden" name="precio" value="30.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/hamburguesavegetal.jpg" alt="Hamburguesa Vegetal" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Hamburguesa Vegetal</strong><br />
                        Precio: S/ 28.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv3" />
                    <input type="hidden" name="nombre" value="Hamburguesa Vegetal" />
                    <input type="hidden" name="precio" value="28.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/currydegarbanzos.jpg" alt="Curry de Garbanzos" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Curry de Garbanzos</strong><br />
                        Precio: S/ 27.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv4" />
                    <input type="hidden" name="nombre" value="Curry de Garbanzos" />
                    <input type="hidden" name="precio" value="27.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/zucchinalpesto.jpg" alt="Zucchini al Pesto" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Zucchini al Pesto</strong><br />
                        Precio: S/ 29.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv5" />
                    <input type="hidden" name="nombre" value="Zucchini al Pesto" />
                    <input type="hidden" name="precio" value="29.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/pizzavegana.jpg" alt="Pizza Vegana" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Pizza Vegana</strong><br />
                        Precio: S/ 32.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="vv6" />
                    <input type="hidden" name="nombre" value="Pizza Vegana" />
                    <input type="hidden" name="precio" value="32.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>
        </ul>
    </div>

    <footer class="text-center py-3 bg-white border-top">
        <small>Contacto: info@verdevivo.com | Teléfono: (01) 555-1234</small>
    </footer>
</body>
</html>


