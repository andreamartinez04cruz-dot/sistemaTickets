package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.util.RegistroErrores;
import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesa.mapper.DashboardMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardRepositoryJdbc implements DashboardRepository {

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
