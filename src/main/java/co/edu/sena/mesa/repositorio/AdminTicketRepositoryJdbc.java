package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.util.RegistroErrores;
import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.AdminTicketDTO;
import co.edu.sena.mesa.mapper.AdminTicketMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminTicketRepositoryJdbc implements AdminTicketRepository {

    @Override
    public List<AdminTicketDTO> listarTicketsAprendiz() {
        List<AdminTicketDTO> ticketsAprendiz = new ArrayList<>();

        String sql = "SELECT t.id, t.titulo, t.descripcion, "
                + "u.nombre AS nombre_aprendiz, "
                + "p.nombrePrograma AS programa, "
                + "p.numeroFicha AS numero_programa, "
                + "i.nombre AS nombre_instructor, "
                + "i.apellido AS apellido_instructor, "
                + "c.nombre AS categoria, "
                + "pr.tipoPrioridad AS prioridad, "
                + "t.estado, "
                + "'APRENDIZ' AS tipo_persona, "
                + "COALESCE(t.jornada, 'No definida') AS jornada "
                + "FROM ticket t "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
                + "LEFT JOIN usuarioprograma up ON up.idUsuario = u.id "
                + "LEFT JOIN programa p ON p.id = up.idPrograma "
                + "LEFT JOIN instructor i ON i.id = p.idInstructor "
                + "WHERE EXISTS ("
                + "    SELECT 1 FROM rolusuario ru "
                + "    INNER JOIN rol r ON r.id = ru.idRol "
                + "    WHERE ru.idUsuario = u.id "
                + "    AND LOWER(TRIM(r.tipoRol)) LIKE '%aprendiz%'"
                + ") "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ticketsAprendiz.add(AdminTicketMapper.toDTO(rs, true));
            }

        } catch (SQLException e) {
            RegistroErrores.registrar("Error listando tickets de aprendiz", e);
        }

        return ticketsAprendiz;
    }

    @Override
    public List<AdminTicketDTO> listarTicketsFuncionario() {
        List<AdminTicketDTO> ticketsFuncionario = new ArrayList<>();

        String sql = "SELECT DISTINCT t.id, t.titulo, t.descripcion, "
                + "u.nombre AS nombre_funcionario, "
                + "COALESCE(r.tipoRol, 'SIN ROL') AS rol, "
                + "c.nombre AS categoria, pr.tipoPrioridad AS prioridad, t.estado, "
                + "'FUNCIONARIO' AS tipo_persona, COALESCE(t.jornada, 'No definida') AS jornada "
                + "FROM ticket t "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "LEFT JOIN rol r ON r.id = ru.idRol "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
                + "WHERE NOT EXISTS ("
                + "    SELECT 1 FROM rolusuario ruAprendiz "
                + "    INNER JOIN rol rAprendiz ON rAprendiz.id = ruAprendiz.idRol "
                + "    WHERE ruAprendiz.idUsuario = u.id "
                + "    AND LOWER(TRIM(rAprendiz.tipoRol)) LIKE '%aprendiz%'"
                + ") "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminTicketDTO dto = AdminTicketMapper.toDTO(rs, false);
                if (dto.getJornada() == null) {
                    dto.setJornada("Noche");
                }
                ticketsFuncionario.add(dto);
            }

        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }

        return ticketsFuncionario;
    }

    @Override
    public void asegurarTablaAsignacion() {
        String sql = "CREATE TABLE IF NOT EXISTS ticketagente ("
                + "id INT NOT NULL AUTO_INCREMENT, "
                + "idTicket INT NOT NULL, "
                + "idUsuario INT NOT NULL, "
                + "fechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                + "PRIMARY KEY (id), "
                + "UNIQUE KEY uq_ticketagente_ticket (idTicket), "
                + "KEY idx_ticketagente_usuario (idUsuario) "
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
    }

    @Override
    public void reasignarTicket(int idTicket, int idAgente) {
        String selectSql = "SELECT id FROM ticketagente WHERE idTicket = ? LIMIT 1";
        String updateSql = "UPDATE ticketagente ta "
            + "INNER JOIN ticket t ON t.id = ta.idTicket "
            + "SET ta.idUsuario = ?, ta.fechaAsignacion = CURRENT_TIMESTAMP "
            + "WHERE ta.idTicket = ? "
            + "AND REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') IN ('NUEVO', 'ASIGNADO', 'EN_PROCESO')";
        String insertSql = "INSERT INTO ticketagente (idTicket, idUsuario) "
            + "SELECT t.id, ? FROM ticket t WHERE t.id = ? "
            + "AND REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') IN ('NUEVO', 'ASIGNADO', 'EN_PROCESO')";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(selectSql)) {
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
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
    }

    @Override
    public List<Map<String, Object>> listarTicketsParaReasignar() {
        List<Map<String, Object>> tickets = new ArrayList<>();
        String sql = "SELECT t.id, t.estado, c.nombre AS categoria, p.tipoPrioridad AS prioridad, "
                + "u.nombre AS solicitante, "
            + "ta.idUsuario AS idAgenteAsignado "
                + "FROM ticket t "
                + "LEFT JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad p ON p.id = t.idPrioridad "
                + "LEFT JOIN ticketagente ta ON ta.idTicket = t.id "
                + "WHERE REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') IN ('NUEVO', 'ASIGNADO', 'EN_PROCESO') "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
        return tickets;
    }

    @Override
    public List<Map<String, Object>> listarAgentes(Integer idTicketExcluir) {
        List<Map<String, Object>> agentes = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id, u.nombre AS nombre "
                + "FROM usuario u "
                + "INNER JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "INNER JOIN rol r ON r.id = ru.idRol "
            + "WHERE LOWER(TRIM(r.tipoRol)) IN ('agente', 'support_agent') ";
        if (idTicketExcluir != null) {
            sql += "AND u.id NOT IN (SELECT idUsuario FROM ticketagente WHERE idTicket = ?) ";
        }
        sql += "ORDER BY u.nombre ASC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
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
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
        return agentes;
    }

    @Override
    public List<Map<String, Object>> listarGestores() {
        List<Map<String, Object>> gestores = new ArrayList<>();
        String sql = "SELECT DISTINCT u.id, u.nombre AS nombre, u.correo, r.tipoRol AS rol "
                + "FROM usuario u "
                + "INNER JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "INNER JOIN rol r ON r.id = ru.idRol "
                + "WHERE LOWER(TRIM(r.tipoRol)) IN ('agente', 'support_agent') "
                + "ORDER BY r.tipoRol ASC, u.nombre ASC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> gestor = new HashMap<>();
                gestor.put("id", rs.getInt("id"));
                gestor.put("nombre", rs.getString("nombre"));
                gestor.put("correo", rs.getString("correo"));
                gestor.put("rol", rs.getString("rol"));
                gestores.add(gestor);
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
        return gestores;
    }

    @Override
    public void cancelarTicket(int idTicket) {
        String sql = "UPDATE ticket SET estado = 'CANCELADO' WHERE id = ?";
        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTicket);
            ps.executeUpdate();
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
    }

    @Override
    public String obtenerEstadoActual(int idTicket) {
        String sql = "SELECT estado FROM ticket WHERE id = ?";
        try (Connection cn = ConexionBD.obtenerConexion();
                PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTicket);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString("estado") : null;
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
            return null;
        }
    }

    @Override
    public boolean actualizarEstado(int idTicket, String estado) {
        String sql = "UPDATE ticket SET estado = ? WHERE id = ?";
        try (Connection cn = ConexionBD.obtenerConexion();
                PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setInt(2, idTicket);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
            return false;
        }
    }

    @Override
    public String obtenerCorreoSolicitante(int idTicket) {
        String sql = "SELECT u.correo FROM ticket t "
            + "INNER JOIN usuario u ON u.id = t.idUsuario "
            + "WHERE t.id = ?";
        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idTicket);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("correo");
                }
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
        return null;
    }

    @Override
    public void restablecerEstadosTicketsPrueba() {
        String[] sqls = {
            "UPDATE ticket SET estado = 'ASIGNADO' WHERE id = 5",
            "UPDATE ticket SET estado = 'EN PROCESO' WHERE id = 3",
            "UPDATE ticket SET estado = 'ASIGNADO' WHERE id = 2"
        };

        try (Connection cn = ConexionBD.obtenerConexion()) {
            for (String sql : sqls) {
                try (PreparedStatement ps = cn.prepareStatement(sql)) {
                    ps.executeUpdate();
                }
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error en repositorio administrativo", e);
        }
    }
}
