package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.repositorio.TicketRepository;

public class TicketServiceImpl implements TicketService {

    
    // Implementar ese servicio Doris
    private final TicketRepository ticketRepository;

    public TicketServiceImpl(TicketRepository ticketRepository) {
        this.ticketRepository = ticketRepository;
    }

    @Override
    public Ticket registrarTicket(Ticket ticket) {
        return ticketRepository.guardar(ticket);
    }
}
