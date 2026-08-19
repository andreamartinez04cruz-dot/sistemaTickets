package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.config.ConexionBD;
import co.edu.sena.mesaayuda.servicio.notificacion.NotificacionService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    @Override
    public void init() throws ServletException {
        notificacionService = (NotificacionService) getServletContext().getAttribute("notificacionService");
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
                cancelarTicket(idTicket);

                String destinatario = obtenerCorreoSolicitante(idTicket);
                if (destinatario != null && !destinatario.isBlank()) {
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

    private void cancelarTicket(int idTicket) {
        String sql = "UPDATE ticket SET estado = 'CANCELADO' WHERE id = ?";
        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTicket);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String obtenerCorreoSolicitante(int idTicket) {
        String sql = "SELECT u.correo FROM ticket t INNER JOIN usuario u ON u.id = t.idUsuario WHERE t.id = ?";
        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTicket);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("correo");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
