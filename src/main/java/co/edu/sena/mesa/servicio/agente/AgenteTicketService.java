package co.edu.sena.mesa.servicio.agente;

import co.edu.sena.mesa.dto.AgenteTicketsResumenDTO;

public interface AgenteTicketService {

    String actualizarEstado(int idTicket, int idAgente, String accion, String nuevoEstado);

    AgenteTicketsResumenDTO obtenerResumenTicketsAsignados(int idAgente);
}
