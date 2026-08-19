package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.config.ConexionBD;
import co.edu.sena.mesaayuda.dto.DashboardEstadisticasDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardRepositoryJdbc implements DashboardRepository {

    @Override
    public DashboardEstadisticasDTO obtenerEstadisticasAdministrador() {
        DashboardEstadisticasDTO dto = new DashboardEstadisticasDTO();

        String sql = "SELECT "
                + "(SELECT COUNT(*) FROM ticket WHERE MONTH(fechaCreacion) = MONTH(CURRENT_DATE()) AND YEAR(fechaCreacion) = YEAR(CURRENT_DATE())) AS total_tickets_mes, "
                + "(SELECT COUNT(*) FROM ticket t LEFT JOIN ticketagente ta ON ta.idTicket = t.id WHERE ta.idTicket IS NULL AND UPPER(COALESCE(t.estado, '')) NOT IN ('CERRADO', 'CANCELADO')) AS sin_asignar, "
                + "(SELECT COUNT(*) FROM ticket t INNER JOIN prioridad p ON p.id = t.idPrioridad WHERE (UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%ALTA%' OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%CRITICA%' OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%CRÍTICA%' OR UPPER(COALESCE(p.tipoPrioridad, '')) LIKE '%URGENTE%') AND UPPER(COALESCE(t.estado, '')) NOT IN ('CERRADO', 'CANCELADO')) AS criticos, "
                + "(SELECT COUNT(*) FROM ticket WHERE UPPER(COALESCE(estado, '')) = 'CERRADO' AND DATE(fechaCreacion) = CURDATE()) AS cerrados_hoy";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                dto.setTotalTicketsMes(rs.getInt("total_tickets_mes"));
                dto.setSinAsignar(rs.getInt("sin_asignar"));
                dto.setCriticos(rs.getInt("criticos"));
                dto.setCerradosHoy(rs.getInt("cerrados_hoy"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dto;
    }
}
