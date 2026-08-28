package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

public final class AgenteTicketMapper {

    private AgenteTicketMapper() {
    }

    public static AgenteTicketDTO toDTO(ResultSet resultSet) throws SQLException {
        AgenteTicketDTO dto = new AgenteTicketDTO();
        dto.setId(resultSet.getInt("id"));
        dto.setTitulo(resultSet.getString("titulo"));
        dto.setEstado(resultSet.getString("estado"));
        dto.setCategoria(resultSet.getString("categoria"));
        dto.setPrioridad(resultSet.getString("prioridad"));
        dto.setHorasAtencion(resultSet.getInt("horas_atencion"));
        dto.setSolicitante(resultSet.getString("solicitante"));
        return dto;
    }
}
