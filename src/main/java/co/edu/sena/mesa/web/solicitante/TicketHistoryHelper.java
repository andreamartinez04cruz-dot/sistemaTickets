package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.config.RegistroErrores;
import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public final class TicketHistoryHelper {

    private TicketHistoryHelper() {
    }

    public static void cancelar(
            HttpServletRequest request,
            HttpServletResponse response,
            SolicitanteTicketService service,
            Usuario usuario) throws IOException {
        String idTicketParam = request.getParameter("idTicket");
        if (idTicketParam != null && !idTicketParam.isBlank()) {
            try {
                service.cancelarTicketSolicitante(
                        Integer.parseInt(idTicketParam),
                        usuario.getId());
            } catch (NumberFormatException exception) {
                RegistroErrores.registrar("ID de ticket inválido al cancelar", exception);
            }
        }
        response.sendRedirect(request.getContextPath() + "/tickets/registrar?action=historial");
    }

    public static void cargar(
            HttpServletRequest request,
            HttpServletResponse response,
            SolicitanteTicketService service,
            Usuario usuario,
            String vista) throws ServletException, IOException {
        List<HistorialFuncionarioDTO> tickets = service
                .listarTicketsPorSolicitante(usuario.getId());
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher(vista).forward(request, response);
    }
}
