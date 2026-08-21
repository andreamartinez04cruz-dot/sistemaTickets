package co.edu.sena.mesa.web.system;

import co.edu.sena.mesa.config.RegistroErrores;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.notificacion.NotificacionTicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/notificaciones")
public class NotificacionesServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = session == null ? null : (Usuario) session.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        String rol = session.getAttribute("rolUsuario") == null
                ? ""
                : session.getAttribute("rolUsuario").toString().trim().toUpperCase();
        NotificacionTicketService service = (NotificacionTicketService) getServletContext()
                .getAttribute("notificacionTicketService");

        if ("POST".equalsIgnoreCase(request.getMethod()) && service != null) {
            try {
                int idTicket = Integer.parseInt(request.getParameter("idTicket"));
                String accion = request.getParameter("accion");
                if ("finalizarTicket".equals(accion)) {
                    service.finalizarTicket(idTicket, rol, usuario.getId());
                } else if ("reabrirTicket".equals(accion)) {
                    service.reabrirTicket(idTicket, rol, usuario.getId());
                }
            } catch (NumberFormatException exception) {
                RegistroErrores.registrar("ID de ticket de notificación inválido", exception);
            }
        }

        if (service != null) {
            request.setAttribute("ticketsUsuario", service.listarNotificaciones(rol, usuario.getId()));
        }
        request.setAttribute("notificacionesPreparadas", Boolean.TRUE);
        request.getRequestDispatcher("/Notificaciones.jsp").forward(request, response);
    }
}
