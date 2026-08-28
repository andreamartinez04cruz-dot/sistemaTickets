package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.dto.ChatDTO;
import co.edu.sena.mesa.servicio.MensajeChatService;
import co.edu.sena.mesa.servicio.MensajeChatServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    private MensajeChatService mensajeChatService;

    @Override
    public void init() throws ServletException {
        mensajeChatService = (MensajeChatService) getServletContext()
                .getAttribute("mensajeService");

        if (mensajeChatService == null) {
            throw new ServletException(
                    "TicketService no fue configurado"
            );
        }

    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idTicketStr = request.getParameter("idTicket");

        // Validar si el parámetro es nulo o está vacío
        if (idTicketStr == null || idTicketStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El parámetro idTicket es obligatorio.");
            return;
        }

        int idTicket;
        try {
            idTicket = Integer.parseInt(idTicketStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El formato del idTicket no es válido.");
            return;
        }

        List<ChatDTO> historial = mensajeChatService.ObtenerHistorialDeChats(idTicket);

        request.setAttribute("historial", historial);
        request.setAttribute("idTicket", idTicket);

        request.getRequestDispatcher("/Chat.jsp")
                .forward(request, response);

    }
}
