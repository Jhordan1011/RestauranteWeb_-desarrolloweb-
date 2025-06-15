<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:42:14 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mar del Sur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-info-subtle">
    <div class="container mt-5">
        <!-- Logo -->
        <div class="text-center mb-4">
            <img src="../../img/logo_mar_del_sur.jpg" alt="Logo Mar del Sur" style="max-width: 180px;">
        </div>

        <h2 class="text-center mb-2">Restaurante: Mar del Sur</h2>
        <p class="text-center mb-4 fst-italic">
            Disfruta de los mejores sabores del mar con platos frescos y tradicionales que te harán sentir la costa peruana.
        </p>

        <ul class="list-group mb-5">

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/ceviche.jpg" alt="Ceviche" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Ceviche</strong><br>
                        Precio: S/ 35.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Ceviche">
                    <input type="hidden" name="precio" value="35.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/arrozconmariscos.jpg" alt="Arroz con Mariscos" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Arroz con Mariscos</strong><br>
                        Precio: S/ 42.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Arroz con Mariscos">
                    <input type="hidden" name="precio" value="42.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/jalea.jpg" alt="Jalea" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Jalea</strong><br>
                        Precio: S/ 40.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Jalea">
                    <input type="hidden" name="precio" value="40.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/pescado_frito.jpg" alt="Pescado Frito" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Pescado Frito</strong><br>
                        Precio: S/ 38.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Pescado Frito">
                    <input type="hidden" name="precio" value="38.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/tacu_tacu_mariscos.jpg" alt="Tacu Tacu con Mariscos" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Tacu Tacu con Mariscos</strong><br>
                        Precio: S/ 39.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Tacu Tacu con Mariscos">
                    <input type="hidden" name="precio" value="39.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/sudado_de_pescado.jpg" alt="Sudado de Pescado" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Sudado de Pescado</strong><br>
                        Precio: S/ 37.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Sudado de Pescado">
                    <input type="hidden" name="precio" value="37.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

        </ul>
    </div>

    <footer class="text-center py-3 bg-light">
        <small>Contacto: info@mardelsur.com | Teléfono: (01) 555-5678</small>
    </footer>
</body>
</html>




