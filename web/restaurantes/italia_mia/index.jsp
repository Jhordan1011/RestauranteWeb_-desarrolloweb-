<%-- 
    Document   : index
    Created on : 20 may. 2025, 10:43:03 p. m.
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Italia Mía</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-warning-subtle">
    <div class="container mt-5">
        <!-- Logo -->
        <div class="text-center mb-4">
            <img src="../../img/logo_italia_mia.jpg" alt="Logo Italia Mía" style="max-width: 180px;" />
        </div>

        <h2 class="text-center mb-2">Restaurante: Italia Mía</h2>
        <p class="text-center mb-4 fst-italic">
            Cocina italiana auténtica con sabores tradicionales y recetas caseras que te transportarán a Italia.
        </p>

        <ul class="list-group mb-5">
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/lasagnabolognesa.jpg" alt="Lasagna Bolognesa" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Lasagna Bolognesa</strong><br />
                        Precio: S/ 40.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Lasagna Bolognesa" />
                    <input type="hidden" name="precio" value="40.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Lasagna Bolognesa al carrito">Agregar</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/spaghetticarbonara.jpg" alt="Spaghetti Carbonara" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Spaghetti Carbonara</strong><br />
                        Precio: S/ 38.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Spaghetti Carbonara" />
                    <input type="hidden" name="precio" value="38.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Spaghetti Carbonara al carrito">Agregar</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/risottodechampinones.jpg" alt="Risotto de Champiñones" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Risotto de Champiñones</strong><br />
                        Precio: S/ 42.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Risotto de Champiñones" />
                    <input type="hidden" name="precio" value="42.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Risotto de Champiñones al carrito">Agregar</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/pizzamargarita.jpg" alt="Pizza Margarita" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Pizza Margarita</strong><br />
                        Precio: S/ 35.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Pizza Margarita" />
                    <input type="hidden" name="precio" value="35.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Pizza Margarita al carrito">Agregar</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/raviolesdeespinaca.jpg" alt="Ravioles de Espinaca" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Ravioles de Espinaca</strong><br />
                        Precio: S/ 39.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Ravioles de Espinaca" />
                    <input type="hidden" name="precio" value="39.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Ravioles de Espinaca al carrito">Agregar</button>
                </form>
            </li>
            <li class="list-group-item d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="../../img/gnocchialpesto.jpg" alt="Gnocchi al Pesto" class="me-3" style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                    <div>
                        <strong>Gnocchi al Pesto</strong><br />
                        Precio: S/ 41.00
                    </div>
                </div>
                <form action="../../CarritoServlet" method="post" class="m-0">
                    <input type="hidden" name="nombre" value="Gnocchi al Pesto" />
                    <input type="hidden" name="precio" value="41.00" />
                    <button type="submit" class="btn btn-sm btn-primary" title="Agregar Gnocchi al Pesto al carrito">Agregar</button>
                </form>
            </li>
        </ul>
    </div>

    <footer class="text-center py-3 bg-light">
        <small>Contacto: info@italiamia.com | Teléfono: (01) 555-1234</small>
    </footer>
</body>
</html>



