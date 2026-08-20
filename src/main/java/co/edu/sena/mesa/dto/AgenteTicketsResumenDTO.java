package co.edu.sena.mesa.dto;

import java.util.List;

public class AgenteTicketsResumenDTO {

    private final List<AgenteTicketDTO> tickets;
    private final int totalAsignados;
    private final int urgentes;
    private final int pendientes;

    public AgenteTicketsResumenDTO(
            List<AgenteTicketDTO> tickets,
            int totalAsignados,
            int urgentes,
            int pendientes) {
        this.tickets = tickets;
        this.totalAsignados = totalAsignados;
        this.urgentes = urgentes;
        this.pendientes = pendientes;
    }

    public List<AgenteTicketDTO> getTickets() {
        return tickets;
    }

    public int getTotalAsignados() {
        return totalAsignados;
    }

    public int getUrgentes() {
        return urgentes;
    }

    public int getPendientes() {
        return pendientes;
    }
}
