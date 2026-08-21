package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import co.edu.sena.mesa.dto.AgenteTicketsResumenDTO;
import java.util.List;

public final class AgenteTicketsResumenMapper {

    private AgenteTicketsResumenMapper() {
    }

    public static AgenteTicketsResumenDTO toDTO(
            List<AgenteTicketDTO> tickets,
            int urgentes,
            int pendientes) {
        return new AgenteTicketsResumenDTO(
                tickets,
                tickets.size(),
                urgentes,
                pendientes);
    }
}
