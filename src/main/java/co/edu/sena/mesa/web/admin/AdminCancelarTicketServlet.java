package co.edu.sena.mesa.web.admin;

import co.edu.sena.mesa.servicio.AdminTicketService;
import co.edu.sena.mesa.servicio.AdminTicketServiceImpl;
import co.edu.sena.mesa.repositorio.AdminTicketRepositoryJdbc;
import co.edu.sena.mesa.servicio.notificacion.NotificacionService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/admin/cancelar-ticket", "/admin/cancelarTicket"})
public class AdminCancelarTicketServlet extends HttpServlet {

    private NotificacionService notificacionService;
    private final AdminTicketService adminTicketService = new AdminTicketServiceImpl(new AdminTicketRepositoryJdbc());

    @Override
    public void init() throws ServletException {
        notificacionService = (NotificacionService) getServletContext().getAttribute("notificacionService");
        if (notificacionService == null) {
            notificacionService = new co.edu.sena.mesa.servicio.notificacion.NotificacionServiceImpl(
                    new co.edu.sena.mesa.servicio.notificacion.NotificadorEnAplicacion()
            );
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        String idTicketStr = request.getParameter("idTicket");
        if (idTicketStr != null && !idTicketStr.isBlank()) {
            try {
                int idTicket = Integer.parseInt(idTicketStr);
                adminTicketService.cancelarTicket(idTicket);

                String destinatario = adminTicketService.obtenerCorreoSolicitante(idTicket);
                if (notificacionService != null && destinatario != null && !destinatario.isBlank()) {
                    notificacionService.notificarCambioEstado(destinatario, idTicket, "CANCELADO");

                    List<String> notificaciones = (List<String>) session.getAttribute("notificaciones");
                    if (notificaciones == null) {
                        notificaciones = new ArrayList<>();
                    }
                    notificaciones.add(0, "Tu ticket #" + idTicket + " cambió a CANCELADO.");
                    session.setAttribute("notificaciones", notificaciones);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script>");
        out.println("  Swal.fire({");
        out.println("    title: '¡Ticket Cancelado!',");
        out.println("    text: 'El ticket se canceló correctamente.',");
        out.println("    icon: 'success',");
        out.println("    timer: 2000,");
        out.println("    showConfirmButton: false,");
        out.println("    timerProgressBar: true");
        out.println("  }).then(() => {");
        out.println("    window.location.href = '" + request.getContextPath() + "/admin/tickets';");
        out.println("  });");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

}
