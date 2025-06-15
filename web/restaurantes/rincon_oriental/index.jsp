<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:43:20 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Rincón Oriental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-secondary-subtle">
    <div class="container mt-5">
        <!-- Logo -->
        <div class="text-center mb-4">
            <img src="../../img/logo_rincon_oriental.jpg" alt="Logo Rincón Oriental" style="max-width: 180px;">
        </div>

        <h2 class="text-center mb-2">Restaurante: Rincón Oriental</h2>
        <p class="text-center mb-4 fst-italic">
            Sabores auténticos de la gastronomía oriental, con ingredientes frescos y recetas tradicionales.
        </p>

        <ul class="list-group mb-5">
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/arrozchaufaa.jpg" alt="Arroz Chaufa" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Arroz Chaufa</strong><br>
                        Precio: S/ 28.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Arroz Chaufa">
                    <input type="hidden" name="precio" value="28.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/tallarin_saltado.jpg" alt="Tallarín Saltado" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Tallarín Saltado</strong><br>
                        Precio: S/ 30.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Tallarín Saltado">
                    <input type="hidden" name="precio" value="30.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/pollo_teriyaki.jpg" alt="Pollo Teriyaki" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Pollo Teriyaki</strong><br>
                        Precio: S/ 33.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Pollo Teriyaki">
                    <input type="hidden" name="precio" value="33.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/sushi_varios.jpg" alt="Sushi Variado" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Sushi Variado</strong><br>
                        Precio: S/ 40.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Sushi Variado">
                    <input type="hidden" name="precio" value="40.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/rollos_primavera.jpg" alt="Rollos Primavera" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Rollos Primavera</strong><br>
                        Precio: S/ 25.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Rollos Primavera">
                    <input type="hidden" name="precio" value="25.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>

            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/sopa_miso.jpg" alt="Sopa Miso" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;">
                    <div>
                        <strong>Sopa Miso</strong><br>
                        Precio: S/ 20.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Sopa Miso">
                    <input type="hidden" name="precio" value="20.00">
                    <button type="submit" class="btn btn-sm btn-primary">Agregar</button>
                </form>
            </li>
        </ul>
    </div>

    <footer class="text-center py-3 bg-light">
        <small>Contacto: info@rinconoriental.com | Teléfono: (01) 555-6789</small>
    </footer>
</body>
</html>


