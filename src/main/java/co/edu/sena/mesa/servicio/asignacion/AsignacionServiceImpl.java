package co.edu.sena.mesa.servicio.asignacion;

import co.edu.sena.mesa.dto.DestinatarioNotificacionDTO;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.repositorio.AsignacionRepository;
import co.edu.sena.mesa.servicio.notificacion.NotificacionService;
import co.edu.sena.mesa.util.RegistroErrores;
import java.util.List;

public class AsignacionServiceImpl implements AsignacionService {

    private final AsignacionRepository asignacionRepository;
    private final AsignacionStrategy asignacionStrategy;
    private final NotificacionService notificacionService;
    private final AgenteTicketRepository agenteTicketRepository;

    public AsignacionServiceImpl(
            AsignacionRepository asignacionRepository,
            AsignacionStrategy asignacionStrategy) {
        this(asignacionRepository, asignacionStrategy, null, null);
    }

    public AsignacionServiceImpl(
            AsignacionRepository asignacionRepository,
            AsignacionStrategy asignacionStrategy,
            NotificacionService notificacionService,
            AgenteTicketRepository agenteTicketRepository) {
        this.asignacionRepository = asignacionRepository;
        this.asignacionStrategy = asignacionStrategy;
        this.notificacionService = notificacionService;
        this.agenteTicketRepository = agenteTicketRepository;
    }

    @Override
    public void asignarTicket(Ticket ticket) {
        if (ticket == null || ticket.getId() >= 0) {
            throw new IllegalArgumentException("El ticket debe estar guardado antes de asignarlo");
        }

        List<Usuario> agentes = asignacionRepository.listarAgentesDisponibles();
        Usuario agente = asignacionStrategy.asignar(ticket, agentes);
        if (agente == null) {
            throw new IllegalStateException("No hay agentes disponibles para asignar el ticket");
        }

        EstadoTicket estadoAsignado = ticket.getEsatdo().asignar();
        ticket.setEsatdo(estadoAsignado);
        asignacionRepository.asignarTicket(
            ticket.getId(),
            agente.getId(),
            estadoAsignado.getNombreEstado());

        notificarAsignacion(ticket.getId(), estadoAsignado.getNombreEstado());
    }

    private void notificarAsignacion(int idTicket, String estado) {
        if (notificacionService == null) {
            return;
        }
        notificacionService.notificarATodosLosRoles(idTicket, estado);
    }
}
