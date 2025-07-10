package controlador;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.dao.ReporteDAO;

import java.io.IOException;
import java.util.Map;

@WebServlet("/exportarReportes")
public class ExportarReportesPDFServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=reportes_admin.pdf");

        try {
            Document doc = new Document();
            PdfWriter.getInstance(doc, response.getOutputStream());
            doc.open();

            Font tituloFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.DARK_GRAY);
            Font subFont = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            Font texto = new Font(Font.FontFamily.HELVETICA, 11);

            ReporteDAO dao = new ReporteDAO();

            doc.add(new Paragraph("📊 Reportes del Administrador", tituloFont));
            doc.add(Chunk.NEWLINE);

            // Platos más pedidos
            doc.add(new Paragraph("🍽 Platos más pedidos", subFont));
            PdfPTable tablaPlatos = new PdfPTable(2);
            tablaPlatos.addCell("Plato");
            tablaPlatos.addCell("Cantidad");

            for (Map.Entry<String, Integer> entry : dao.obtenerPlatosMasPedidos().entrySet()) {
                tablaPlatos.addCell(entry.getKey());
                tablaPlatos.addCell(String.valueOf(entry.getValue()));
            }
            doc.add(tablaPlatos);
            doc.add(Chunk.NEWLINE);

            // Restaurantes más pedidos
            doc.add(new Paragraph("🏠 Restaurantes más pedidos", subFont));
            PdfPTable tablaRest = new PdfPTable(2);
            tablaRest.addCell("Restaurante");
            tablaRest.addCell("Cantidad");

            for (Map.Entry<String, Integer> entry : dao.obtenerRestaurantesMasPedidos().entrySet()) {
                tablaRest.addCell(entry.getKey());
                tablaRest.addCell(String.valueOf(entry.getValue()));
            }
            doc.add(tablaRest);
            doc.add(Chunk.NEWLINE);

            // Usuarios frecuentes
            doc.add(new Paragraph("🧑‍💼 Usuarios que más compran", subFont));
            PdfPTable tablaUsuarios = new PdfPTable(2);
            tablaUsuarios.addCell("Usuario");
            tablaUsuarios.addCell("Cantidad");

            for (Map.Entry<String, Integer> entry : dao.obtenerUsuariosFrecuentes().entrySet()) {
                tablaUsuarios.addCell(entry.getKey());
                tablaUsuarios.addCell(String.valueOf(entry.getValue()));
            }
            doc.add(tablaUsuarios);
            doc.add(Chunk.NEWLINE);

            // Métodos de pago
            doc.add(new Paragraph("💳 Métodos de Pago más usados", subFont));
            PdfPTable tablaMetodos = new PdfPTable(2);
            tablaMetodos.addCell("Método");
            tablaMetodos.addCell("Cantidad");

            for (Map.Entry<String, Integer> entry : dao.obtenerMetodosPagoUsados().entrySet()) {
                tablaMetodos.addCell(entry.getKey());
                tablaMetodos.addCell(String.valueOf(entry.getValue()));
            }
            doc.add(tablaMetodos);

            doc.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
