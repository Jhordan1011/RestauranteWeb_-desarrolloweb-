<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:41:56 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sabor Criollo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-warning-subtle">
    <div class="container mt-5">
        <!-- Logo del restaurante -->
        <div class="text-center mb-4">
            <img src="../../img/logo_sabor_criollo.jpg" alt="Logo Sabor Criollo" style="max-width: 180px;">
         </div>

        <h2 class="text-center mb-2">Restaurante: Sabor Criollo</h2>
        <p class="text-center mb-4 fst-italic">
            Auténticos sabores peruanos que enamoran
        </p>

        <ul class="list-group">

            <%-- AJÍ DE GALLINA --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/ajidegallina.jpg" alt="Ají de Gallina" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Ají de Gallina</strong><br>
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Ají de Gallina">
                    <input type="hidden" name="precio" value="25.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

            <%-- LOMO SALTADO --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/lomosaltado.jpg" alt="Lomo Saltado" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Lomo Saltado</strong><br>
                        Precio: S/ 28.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Lomo Saltado">
                    <input type="hidden" name="precio" value="28.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

            <%-- ARROZ CHAUFA --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/arrozchaufa.jpg" alt="Arroz Chaufa" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Arroz Chaufa</strong><br>
                        Precio: S/ 22.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Arroz Chaufa">
                    <input type="hidden" name="precio" value="22.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

            <%-- SECO DE RES --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/secoderes.jpg" alt="Seco de Res" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Seco de Res</strong><br>
                        Precio: S/ 30.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Seco de Res">
                    <input type="hidden" name="precio" value="30.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

            <%-- CAUSA LIMEÑA --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/causalimena.jpg" alt="Causa Limeña" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Causa Limeña</strong><br>
                        Precio: S/ 20.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Causa Limeña">
                    <input type="hidden" name="precio" value="20.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

            <%-- TALLARÍN VERDE --%>
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src="../../img/tallarinverde.jpg" alt="Tallarín Verde" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Tallarín Verde</strong><br>
                        Precio: S/ 24.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Tallarín Verde">
                    <input type="hidden" name="precio" value="24.00">
                    <button type="submit" class="btn btn-success btn-sm">Agregar al carrito</button>
                </form>
            </li>

        </ul>
    </div>

    <footer class="text-center py-3 bg-light mt-5">
        <small>Contacto: info@saborcriollo.com | Teléfono: (01) 555-1234</small>
    </footer>
</body>
</html>



