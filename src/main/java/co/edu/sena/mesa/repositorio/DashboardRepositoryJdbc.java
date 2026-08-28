package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.RegistroErrores;
import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesa.mapper.DashboardMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DashboardRepositoryJdbc implements DashboardRepository {

    @Override
    public List<Map<String, Object>> listarTicketsPorEstado() {
        List<Map<String, Object>> resultado = new ArrayList<>();
        String sql = "SELECT COALESCE(NULLIF(TRIM(estado), ''), 'SIN ESTADO') AS estado, "
                + "COUNT(*) AS cantidad FROM ticket GROUP BY estado ORDER BY cantidad DESC";

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("estado", rs.getString("estado"));
                fila.put("cantidad", rs.getInt("cantidad"));
                resultado.add(fila);
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error listando tickets por estado", e);
        }
        return resultado;
    }

    @Override
    public List<Map<String, Object>> listarTicketsPorAgente() {
        List<Map<String, Object>> resultado = new ArrayList<>();
        String sql = "SELECT u.nombre AS agente, COUNT(ta.idTicket) AS cantidad "
                + "FROM ticketagente ta INNER JOIN usuario u ON u.id = ta.idUsuario "
                + "INNER JOIN ticket t ON t.id = ta.idTicket "
                + "WHERE REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') "
                + "NOT IN ('CERRADO', 'CANCELADO', 'RESUELTO') "
                + "GROUP BY u.id, u.nombre ORDER BY cantidad DESC, u.nombre ASC";

        try (Connection cn = ConexionBD.obtenerConexion()) {
            asegurarTablaAsignacion(cn);
            try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> fila = new HashMap<>();
                    fila.put("agente", rs.getString("agente"));
                    fila.put("cantidad", rs.getInt("cantidad"));
                    resultado.add(fila);
                }
            }
        } catch (SQLException e) {
            RegistroErrores.registrar("Error listando tickets por agente", e);
        }
        return resultado;
    }

    private void asegurarTablaAsignacion(Connection cn) throws SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS ticketagente ("
                + "id INT NOT NULL AUTO_INCREMENT, "
                + "idTicket INT NOT NULL, "
                + "idUsuario INT NOT NULL, "
                + "fechaAsignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, "
                + "PRIMARY KEY (id), "
                + "UNIQUE KEY uq_ticketagente_ticket (idTicket), "
                + "KEY idx_ticketagente_usuario (idUsuario) "
                + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.executeUpdate();
        }
    }

    @Override
    public DashboardEstadisticasDTO obtenerEstadisticasAdministrador() {
        String sql = "SELECT "
                + "(SELECT COUNT(*) FROM ticket WHERE MONTH(fechaCreacion) = MONTH(CURRENT_DATE()) AND YEAR(fechaCreacion) = YEAR(CURRENT_DATE())) AS total_tickets_mes, "
                + "(SELECT COUNT(*) FROM ticket t LEFT JOIN ticketagente ta ON ta.idTicket = t.id WHERE ta.idTicket IS NULL "
                + "AND REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') NOT IN ('CERRADO', 'CANCELADO', 'RESUELTO')) AS sin_asignar, "
                + "(SELECT COUNT(*) FROM ticket t INNER JOIN prioridad p ON p.id = t.idPrioridad WHERE "
                + "(UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%ALTA%' OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%CRITICA%' "
                + "OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%CRÍTICA%' OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%URGENTE%') "
                + "AND REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') NOT IN ('CERRADO', 'CANCELADO', 'RESUELTO')) AS criticos, "
                + "(SELECT COUNT(DISTINCT ta.idUsuario) FROM ticketagente ta "
                + "INNER JOIN ticket t ON t.id = ta.idTicket "
                + "WHERE REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') NOT IN ('CERRADO', 'CANCELADO')) AS agentes_con_tickets, "
                + "(SELECT COUNT(*) FROM ticket t INNER JOIN prioridad p ON p.id = t.idPrioridad "
                + "WHERE REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') NOT IN ('CERRADO', 'CANCELADO', 'RESUELTO') "
                + "AND TIMESTAMPDIFF(HOUR, t.fechaCreacion, CURRENT_TIMESTAMP()) > CASE "
                + "WHEN UPPER(p.tipoPrioridad) LIKE '%CRIT%' THEN 2 "
                + "WHEN UPPER(p.tipoPrioridad) LIKE '%ALTA%' THEN 8 "
                + "WHEN UPPER(p.tipoPrioridad) LIKE '%MEDIA%' THEN 24 "
                + "ELSE 48 END) AS sla_vencidos, "
                + "(SELECT COUNT(*) FROM ticket WHERE UPPER(COALESCE(estado, '')) = 'CERRADO' AND DATE(fechaCreacion) = CURDATE()) AS cerrados_hoy";
        try (Connection cn = ConexionBD.obtenerConexion()) {

            asegurarTablaAsignacion(cn);

            try (PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return DashboardMapper.toDTO(rs);
                }
            }

        } catch (SQLException e) {
            RegistroErrores.registrar("Error al consultar métricas del dashboard", e);
        }

        return DashboardMapper.empty();
    }
}
