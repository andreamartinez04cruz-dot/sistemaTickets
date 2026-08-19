package co.edu.sena.mesaayuda.web;

import co.edu.sena.mesaayuda.config.ConexionBD;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet({"/admin/reasignar-agentes", "/admin/reasignarAgentes"})
public class AdminReasignarAgenteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        asegurarTablaAsignacion();

        String ticketSeleccionado = request.getParameter("idTicket");
        Integer idTicket = null;
        if (ticketSeleccionado != null && !ticketSeleccionado.isBlank()) {
            try {
                idTicket = Integer.parseInt(ticketSeleccionado);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        request.setAttribute("tickets", listarTicketsParaReasignar());
        request.setAttribute("agentes", listarAgentes(idTicket));
        request.setAttribute("ticketSeleccionado", ticketSeleccionado);

        request.getRequestDispatcher("/ReasignarAgentes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        asegurarTablaAsignacion();

        String idTicket = request.getParameter("idTicket");
        String idAgente = request.getParameter("idAgente");

        if (idTicket != null && !idTicket.isBlank() && idAgente != null && !idAgente.isBlank()) {
            reasignarTicket(Integer.parseInt(idTicket), Integer.parseInt(idAgente));
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
        out.println("    title: '¡Reasignación Exitosa!',");
        out.println("    text: 'Se guardó el cambio de agente correctamente.',");
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

    private void asegurarTablaAsignacion() {
        String sql = "CREATE TABLE IF NOT EXISTS ticketagente ("
                + "id INT NOT NULL AUTO_INCREMENT, "
                + "idTicket INT NOT NULL, "
                + "idUsuario INT NOT NULL, "
                + "fechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                + "PRIMARY KEY (id), "
                + "UNIQUE KEY uq_ticketagente_ticket (idTicket), "
                + "KEY idx_ticketagente_usuario (idUsuario) "
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void reasignarTicket(int idTicket, int idAgente) {
        String selectSql = "SELECT id FROM ticketagente WHERE idTicket = ? LIMIT 1";
        String updateSql = "UPDATE ticketagente SET idUsuario = ?, fechaAsignacion = CURRENT_TIMESTAMP WHERE idTicket = ?";
        String insertSql = "INSERT INTO ticketagente (idTicket, idUsuario) VALUES (?, ?)";

        try (Connection cn = ConexionBD.obtenerConexion()) {
            try (PreparedStatement ps = cn.prepareStatement(selectSql)) {
                ps.setInt(1, idTicket);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement updatePs = cn.prepareStatement(updateSql)) {
                            updatePs.setInt(1, idAgente);
                            updatePs.setInt(2, idTicket);
                            updatePs.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement insertPs = cn.prepareStatement(insertSql)) {
                            insertPs.setInt(1, idTicket);
                            insertPs.setInt(2, idAgente);
                            insertPs.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<Map<String, Object>> listarTicketsParaReasignar() {
        List<Map<String, Object>> tickets = new ArrayList<>();
        String sql = "SELECT t.id, t.estado, c.nombre AS categoria, p.tipoPrioridad AS prioridad, "
                + "CONCAT(u.nombre, ' ', u.apellido) AS solicitante, ta.idUsuario AS idAgenteAsignado "
                + "FROM ticket t "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad p ON p.id = t.idPrioridad "
                + "LEFT JOIN ticketagente ta ON ta.idTicket = t.id "
                + "WHERE UPPER(COALESCE(t.estado, '')) NOT IN ('CERRADO', 'CANCELADO') "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> ticket = new HashMap<>();
                ticket.put("id", rs.getInt("id"));
                ticket.put("estado", rs.getString("estado"));
                ticket.put("categoria", rs.getString("categoria"));
                ticket.put("prioridad", rs.getString("prioridad"));
                ticket.put("solicitante", rs.getString("solicitante"));
                ticket.put("idAgenteAsignado", rs.getObject("idAgenteAsignado"));
                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }

    private List<Map<String, Object>> listarAgentes(Integer idTicketExcluir) {
        List<Map<String, Object>> agentes = new ArrayList<>();
        String sql = "SELECT u.id, CONCAT(u.nombre, ' ', u.apellido) AS nombre "
                + "FROM usuario u "
                + "INNER JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "INNER JOIN rol r ON r.id = ru.idRol "
                + "WHERE (r.id IN (2, 3) OR LOWER(COALESCE(r.tipoRol, '')) LIKE '%agente%') ";

        if (idTicketExcluir != null) {
            sql += "AND u.id NOT IN (SELECT idUsuario FROM ticketagente WHERE idTicket = ?) ";
        }

        sql += "ORDER BY u.nombre ASC";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            if (idTicketExcluir != null) {
                ps.setInt(1, idTicketExcluir);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> agente = new HashMap<>();
                    agente.put("id", rs.getInt("id"));
                    agente.put("nombre", rs.getString("nombre"));
                    agentes.add(agente);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return agentes;
    }
}
