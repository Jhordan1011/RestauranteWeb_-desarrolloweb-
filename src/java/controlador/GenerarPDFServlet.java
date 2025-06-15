/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URL;
import java.util.List;
import modelo.Pedido;
import modelo.DetallePedido;

@WebServlet("/GenerarPDFServlet")
public class GenerarPDFServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Pedido pedido = (Pedido) session.getAttribute("pedido");

        if (pedido == null) {
            response.sendRedirect("pedido_confirmado.jsp");
            return;
        }

        String nombreCliente = (String) session.getAttribute("usuarioNombre");

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=boleta_" + pedido.getId() + ".pdf");

        try {
            Document documento = new Document();
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            // Logo del restaurante
            String logoPath = getServletContext().getRealPath("/img/logopdf.jpg"); // Cambia por tu logo si tienes
            Image logo = Image.getInstance(logoPath);
            logo.scaleToFit(100, 100);
            logo.setAlignment(Image.ALIGN_LEFT);
            documento.add(logo);

            // Títulos y estilos
            Font titulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            Font negrita = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            Font normal = new Font(Font.FontFamily.HELVETICA, 11, Font.NORMAL);
            Font agradecimiento = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLDITALIC, BaseColor.DARK_GRAY);

            documento.add(new Paragraph("Boleta #" + pedido.getId(), titulo));
            documento.add(new Paragraph("Cliente: " + (nombreCliente != null ? nombreCliente : "Sin nombre"), normal));
            documento.add(new Paragraph("Dirección: " + pedido.getDireccionEntrega(), normal));
            documento.add(new Paragraph("Método de pago: " + pedido.getMetodoPago(), normal));
            documento.add(new Paragraph(" ")); // espacio

            // Tabla de pedidos
            PdfPTable tabla = new PdfPTable(4);
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{4, 2, 2, 2});

            tabla.addCell(new PdfPCell(new Phrase("Plato", negrita)));
            tabla.addCell(new PdfPCell(new Phrase("Cantidad", negrita)));
            tabla.addCell(new PdfPCell(new Phrase("Precio Unitario", negrita)));
            tabla.addCell(new PdfPCell(new Phrase("Subtotal", negrita)));

            for (DetallePedido item : pedido.getDetalles()) {
                tabla.addCell(item.getNombrePlato());
                tabla.addCell(String.valueOf(item.getCantidad()));
                tabla.addCell("S/ " + String.format("%.2f", item.getPrecioUnitario()));
                tabla.addCell("S/ " + String.format("%.2f", item.getSubtotal()));
            }

            PdfPCell totalCell = new PdfPCell(new Phrase("TOTAL", negrita));
            totalCell.setColspan(3);
            totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            tabla.addCell(totalCell);
            tabla.addCell("S/ " + String.format("%.2f", pedido.getTotal()));

            documento.add(tabla);

            // Espacio y mensaje de agradecimiento
            documento.add(new Paragraph(" "));
            Paragraph gracias = new Paragraph("¡Gracias por su compra!", agradecimiento);
            gracias.setAlignment(Element.ALIGN_CENTER);
            documento.add(gracias);

            documento.close();

        } catch (Exception e) {
            throw new ServletException("Error al generar PDF", e);
        }
    }
}


