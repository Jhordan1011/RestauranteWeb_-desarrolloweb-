<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Pedido" %>
<%@ page import="modelo.DetallePedido" %>
<%@ page import="java.util.List" %>

<%
    Pedido pedido = (Pedido) session.getAttribute("pedido");

    if (pedido == null || pedido.getDetalles() == null) {
        response.sendRedirect("ver_pedido.jsp"); // Redirigir si no hay pedido
        return;
    }

    List<DetallePedido> detalles = pedido.getDetalles();
    int numeroBoleta = pedido.getId();
    String textoBoleta = (numeroBoleta > 0) ? String.valueOf(numeroBoleta) : "No asignado";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Boleta #<%= textoBoleta %></title> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
            font-family: Arial, sans-serif;
            margin: 2em;
        }

        h2 {
            color: #FFD700;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1em;
            background-color: #111;
            color: #fff;
            border: 1px solid #FFD700;
        }

        th, td {
            border: 1px solid #FFD700;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #222;
            color: #FFD700;
        }

        .total {
            text-align: right;
            font-weight: bold;
            color: #FFD700;
            margin-top: 1em;
        }

        p strong {
            color: #FFD700;
        }

        .btn-primary {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border: none;
            padding: 10px 20px;
            margin-top: 2em;
        }

        .btn-primary:hover {
            background-color: #e6c200;
        }

        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>Boleta #<%= textoBoleta %></h2>

    <p><strong>Cliente:</strong> ${sessionScope.usuarioNombre}</p>
    <p><strong>Dirección:</strong> <%= pedido.getDireccionEntrega() %></p>

    <table>
        <thead>
            <tr>
                <th>Plato</th>
                <th>Cantidad</th>
                <th>P. Unitario</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (DetallePedido detalle : detalles) {
            %>
                <tr>
                    <td><%= detalle.getNombrePlato() %></td>
                    <td><%= detalle.getCantidad() %></td>
                    <td>S/. <%= String.format("%.2f", detalle.getPrecioUnitario()) %></td>
                    <td>S/. <%= String.format("%.2f", detalle.getSubtotal()) %></td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <p class="total">TOTAL: S/. <%= String.format("%.2f", pedido.getTotal()) %></p>
    <p><strong>Método de pago:</strong> <%= pedido.getMetodoPago() %></p>

    <form action="GenerarPDFServlet" method="post" target="_blank">
        <div class="text-center">
            <button type="submit" class="btn btn-primary">📄 Descargar Boleta en PDF</button>
        </div>
    </form>

</body>
</html>


