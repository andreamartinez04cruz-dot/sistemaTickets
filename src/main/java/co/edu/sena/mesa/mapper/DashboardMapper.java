package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

public final class DashboardMapper {

    private DashboardMapper() {
    }

    public static DashboardEstadisticasDTO toDTO(ResultSet resultSet) throws SQLException {
        DashboardEstadisticasDTO dto = new DashboardEstadisticasDTO();
        dto.setTotalTicketsMes(resultSet.getInt("total_tickets_mes"));
        dto.setSinAsignar(resultSet.getInt("sin_asignar"));
        dto.setCriticos(resultSet.getInt("criticos"));
        dto.setAgentesConTickets(resultSet.getInt("agentes_con_tickets"));
        dto.setSlaVencidos(resultSet.getInt("sla_vencidos"));
        dto.setCerradosHoy(resultSet.getInt("cerrados_hoy"));
        return dto;
    }

    public static DashboardEstadisticasDTO empty() {
        return new DashboardEstadisticasDTO();
    }
}
