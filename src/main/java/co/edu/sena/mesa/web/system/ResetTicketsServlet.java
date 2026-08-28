package co.edu.sena.mesa.web.system;

import co.edu.sena.mesa.util.RegistroErrores;
import co.edu.sena.mesa.servicio.AdminTicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/reset-tickets", "/ResetTickets.jsp"})
public class ResetTicketsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AdminTicketService adminTicketService = (AdminTicketService) getServletContext()
                .getAttribute("adminTicketService");
        String message;
        try {
            if (adminTicketService == null) {
                throw new IllegalStateException("AdminTicketService no fue inicializado");
            }
            adminTicketService.restablecerEstadosTicketsPrueba();
            message = "¡Estados de tickets reseteados con éxito! <br/><br/>"
                    + "• Ticket #5 cambiado a ASIGNADO (para que pruebes pasarlo a EN PROCESO o RESUELTO)<br/>"
                    + "• Ticket #3 cambiado a EN PROCESO (para que pruebes pasarlo a RESUELTO)<br/>"
                    + "• Ticket #2 cambiado a ASIGNADO (para que pruebes todo su ciclo de vida desde cero)";
        } catch (Exception exception) {
            message = "Hubo un error al resetear los estados: " + exception.getMessage();
            RegistroErrores.registrar("Error al restablecer tickets de prueba", exception);
        }
        request.setAttribute("message", message);
        request.getRequestDispatcher("/ResetTickets_view.jsp").forward(request, response);
    }
}
