<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:44:28 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Veggie Express</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-danger-subtle p-3">
    <div class="container">
        <div class="text-center mb-4">
            <img src="../../img/logo_veggie_express.jpg" alt="Logo Veggie Express" style="max-width: 180px;" />
        </div>
        <h2 class="text-center mb-2">Restaurante: Veggie Express</h2>
        <p class="text-center mb-4 fst-italic">
            Opciones vegetarianas llenas de sabor y color
        </p>

        <ul class="list-group">
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/burrito_vegetariano.jpg" alt="Burrito Vegetariano" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Burrito Vegetariano</strong><br />
                        Precio: S/ 22.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg1" />
                    <input type="hidden" name="nombre" value="Burrito Vegetariano" />
                    <input type="hidden" name="precio" value="22.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/tofu_saltado.jpg" alt="Tofu Saltado" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Tofu Saltado</strong><br />
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg2" />
                    <input type="hidden" name="nombre" value="Tofu Saltado" />
                    <input type="hidden" name="precio" value="25.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/ensalada_thai.jpg" alt="Ensalada Thai" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Ensalada Thai</strong><br />
                        Precio: S/ 20.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg3" />
                    <input type="hidden" name="nombre" value="Ensalada Thai" />
                    <input type="hidden" name="precio" value="20.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/hamburguesa_garbanzos.jpg" alt="Hamburguesa de Garbanzos" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Hamburguesa de Garbanzos</strong><br />
                        Precio: S/ 28.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg4" />
                    <input type="hidden" name="nombre" value="Hamburguesa de Garbanzos" />
                    <input type="hidden" name="precio" value="28.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/curry_verde.jpg" alt="Curry Verde" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Curry Verde</strong><br />
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg5" />
                    <input type="hidden" name="nombre" value="Curry Verde" />
                    <input type="hidden" name="precio" value="25.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/sopa_misoo.jpg" alt="Sopa Miso" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Sopa Miso</strong><br />
                        Precio: S/ 20.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="id" value="veg6" />
                    <input type="hidden" name="nombre" value="Sopa Miso" />
                    <input type="hidden" name="precio" value="20.00" />
                    <button type="submit" class="btn btn-sm btn-success">Agregar</button>
                </form>
            </li>
        </ul>
    </div>

    <footer class="text-center py-3 bg-white border-top">
        <small>Contacto: contacto@veggieexpress.com | Teléfono: (01) 555-6789</small>
    </footer>
</body>
</html>




