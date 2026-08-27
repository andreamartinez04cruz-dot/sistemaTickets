package co.edu.sena.mesa.servicio.asignacion;

import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.repositorio.AsignacionRepository;
import java.util.List;

public class AsignacionServiceImpl implements AsignacionService {

    private final AsignacionRepository asignacionRepository;
    private final AsignacionStrategy asignacionStrategy;

    public AsignacionServiceImpl(
            AsignacionRepository asignacionRepository,
            AsignacionStrategy asignacionStrategy) {
        this.asignacionRepository = asignacionRepository;
        this.asignacionStrategy = asignacionStrategy;
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
    }
}
