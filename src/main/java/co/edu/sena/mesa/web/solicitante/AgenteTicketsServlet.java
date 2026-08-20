package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.dto.AgenteTicketsResumenDTO;
import co.edu.sena.mesa.servicio.agente.AgenteTicketService;
import co.edu.sena.mesa.modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/agente/tickets")
public class AgenteTicketsServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = session == null ? null : (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        AgenteTicketService agenteTicketService = (AgenteTicketService) getServletContext()
                .getAttribute("agenteTicketService");
        String mensajeEstado = "";
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                int idTicket = Integer.parseInt(request.getParameter("idTicket"));
                mensajeEstado = agenteTicketService.actualizarEstado(
                        idTicket,
                        usuario.getId(),
                        request.getParameter("accion"),
                        request.getParameter("nuevoEstado"));
            } catch (Exception exception) {
                mensajeEstado = "Error al guardar el cambio del ticket.";
                exception.printStackTrace();
            }
        }

        AgenteTicketsResumenDTO resumen = agenteTicketService
                .obtenerResumenTicketsAsignados(usuario.getId());
        request.setAttribute("ticketsAsignados", resumen.getTickets());
        request.setAttribute("totalAsignados", resumen.getTotalAsignados());
        request.setAttribute("urgentes", resumen.getUrgentes());
        request.setAttribute("pendientes", resumen.getPendientes());
        request.setAttribute("mensajeEstado", mensajeEstado);
        request.setAttribute("agenteTicketsPreparados", Boolean.TRUE);
        request.getRequestDispatcher("/AgenteTickets.jsp").forward(request, response);
    }
}
