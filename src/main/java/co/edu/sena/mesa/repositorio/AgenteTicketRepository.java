package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import java.util.List;

public interface AgenteTicketRepository {

    boolean estaAsignado(int idTicket, int idAgente);

    String obtenerEstadoActual(int idTicket, int idAgente);

    int actualizarEstado(int idTicket, int idAgente, String estado);

    String obtenerCorreoSolicitante(int idTicket);

    List<AgenteTicketDTO> listarTicketsAsignados(int idAgente);
}
