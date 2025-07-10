package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.dao.ReporteDAO;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Map;

@WebServlet("/adminReportes")
public class ReportesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReporteDAO dao = new ReporteDAO();
        Map<String, Integer> platosMap = dao.obtenerPlatosMasPedidos();
        Map<String, Integer> restaurantesMap = dao.obtenerRestaurantesMasPedidos();
        Map<String, Integer> pedidosPorDia = dao.obtenerPedidosPorDia();
        Map<String, Integer> pedidosPorMes = dao.obtenerPedidosPorMes();
        Map<String, Integer> metodosPago = dao.obtenerMetodosPagoUsados();
        Map<String, Integer> usuariosFrecuentes = dao.obtenerUsuariosFrecuentes();

        JSONArray platosArray = new JSONArray();
        for (Map.Entry<String, Integer> entry : platosMap.entrySet()) {
            JSONObject obj = new JSONObject();
            obj.put("plato", entry.getKey());
            obj.put("total", entry.getValue());
            platosArray.put(obj);
        }

        JSONArray restaurantesArray = new JSONArray();
        for (Map.Entry<String, Integer> entry : restaurantesMap.entrySet()) {
            JSONObject obj = new JSONObject();
            obj.put("restaurante", entry.getKey());
            obj.put("total", entry.getValue());
            restaurantesArray.put(obj);
        }
        
        JSONArray pedidosPorDiaArray = new JSONArray();
for (Map.Entry<String, Integer> entry : pedidosPorDia.entrySet()) {
    JSONObject obj = new JSONObject();
    obj.put("dia", entry.getKey());
    obj.put("total", entry.getValue());
    pedidosPorDiaArray.put(obj);
}

JSONArray pedidosPorMesArray = new JSONArray();
for (Map.Entry<String, Integer> entry : pedidosPorMes.entrySet()) {
    JSONObject obj = new JSONObject();
    obj.put("mes", entry.getKey());
    obj.put("total", entry.getValue());
    pedidosPorMesArray.put(obj);
}


JSONArray metodosPagoArray = new JSONArray();
for (Map.Entry<String, Integer> entry : metodosPago.entrySet()) {
    JSONObject obj = new JSONObject();
    obj.put("metodo", entry.getKey());
    obj.put("total", entry.getValue());
    metodosPagoArray.put(obj);
}



JSONArray usuariosFrecuentesArray = new JSONArray();
for (Map.Entry<String, Integer> entry : usuariosFrecuentes.entrySet()) {
    JSONObject obj = new JSONObject();
    obj.put("usuario", entry.getKey());
    obj.put("total", entry.getValue());
    usuariosFrecuentesArray.put(obj);
}
        // Enviar como string, para el JSP
        request.setAttribute("platosMasPedidos", platosArray.toString());
        request.setAttribute("restaurantesMasPedidos", restaurantesArray.toString());
        request.setAttribute("pedidosPorDia", pedidosPorDiaArray.toString());
        request.setAttribute("pedidosPorMes", pedidosPorMesArray.toString());
        request.setAttribute("metodosPagoUsados", metodosPagoArray.toString());
        request.setAttribute("usuariosFrecuentes", usuariosFrecuentesArray.toString());

        request.getRequestDispatcher("AdminReportes.jsp").forward(request, response);
    }
}
