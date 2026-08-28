package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import co.edu.sena.mesa.dto.DestinatarioNotificacionDTO;
import java.util.List;

public interface AgenteTicketRepository {

    boolean estaAsignado(int idTicket, int idAgente);

    String obtenerEstadoActual(int idTicket, int idAgente);

    int actualizarEstado(int idTicket, int idAgente, String estado);

    String obtenerCorreoSolicitante(int idTicket);

    /** Correos del solicitante, de los agentes asignados y de los administradores. */
    List<DestinatarioNotificacionDTO> obtenerDestinatariosNotificacion(int idTicket);

    List<AgenteTicketDTO> listarTicketsAsignados(int idAgente);
}
