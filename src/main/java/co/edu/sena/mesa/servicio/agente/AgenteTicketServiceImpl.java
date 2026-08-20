package co.edu.sena.mesa.servicio.agente;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import co.edu.sena.mesa.dto.AgenteTicketsResumenDTO;
import co.edu.sena.mesa.modelo.estado.EstadoAsignado;
import co.edu.sena.mesa.modelo.estado.EstadoEnProceso;
import co.edu.sena.mesa.modelo.estado.EstadoNuevo;
import co.edu.sena.mesa.modelo.estado.EstadoResuelto;
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.servicio.notificacion.NotificacionService;
import java.util.List;
import java.util.Locale;

public class AgenteTicketServiceImpl implements AgenteTicketService {

    private final AgenteTicketRepository agenteTicketRepository;
    private final NotificacionService notificacionService;

    public AgenteTicketServiceImpl(
            AgenteTicketRepository agenteTicketRepository,
            NotificacionService notificacionService) {
        this.agenteTicketRepository = agenteTicketRepository;
        this.notificacionService = notificacionService;
    }

    @Override
    public String actualizarEstado(
            int idTicket,
            int idAgente,
            String accion,
            String nuevoEstado) {
        if (!agenteTicketRepository.estaAsignado(idTicket, idAgente)) {
            return "Este ticket no está asignado a tu usuario.";
        }

        String estadoActual = normalizarEstado(agenteTicketRepository
            .obtenerEstadoActual(idTicket, idAgente));
        String estadoSolicitado = "resolverTicket".equals(accion)
            ? "RESUELTO"
            : normalizarEstado(nuevoEstado);

        if (estadoSolicitado == null) {
            return "Debe elegir un estado válido.";
        }

        String estado = aplicarTransicion(estadoActual, estadoSolicitado);
        if (estado == null) {
            return "La transición de estado no es válida.";
        }

        int filasActualizadas = agenteTicketRepository.actualizarEstado(idTicket, idAgente, estado);
        if (filasActualizadas == 0) {
            return "resolverTicket".equals(accion)
                    ? "No se pudo resolver el ticket."
                    : "No se pudo actualizar el estado.";
        }

        notificarCambioEstado(idTicket, estado);
        return "resolverTicket".equals(accion)
                ? "Ticket resuelto correctamente y guardado en la base de datos."
                : "Estado actualizado correctamente y guardado en la base de datos.";
    }

    @Override
    public AgenteTicketsResumenDTO obtenerResumenTicketsAsignados(int idAgente) {
        List<AgenteTicketDTO> tickets = agenteTicketRepository.listarTicketsAsignados(idAgente);
        int urgentes = 0;
        int pendientes = 0;

        for (AgenteTicketDTO ticket : tickets) {
            if (esPrioridadUrgente(ticket.getPrioridad())) {
                urgentes++;
            }
            if (esPendiente(ticket.getEstado())) {
                pendientes++;
            }
        }

        return new AgenteTicketsResumenDTO(tickets, tickets.size(), urgentes, pendientes);
    }

    private String normalizarEstado(String estado) {
        if (estado == null || estado.trim().isEmpty()) {
            return null;
        }

        String estadoNormalizado = estado.trim().toUpperCase(Locale.ROOT);
        if ("EN_PROCESO".equals(estadoNormalizado)) {
            return "EN PROCESO";
        }
        return estadoNormalizado;
    }

    private String aplicarTransicion(String estadoActual, String estadoSolicitado) {
        if (estadoActual == null || estadoSolicitado.equals(estadoActual)) {
            return estadoSolicitado;
        }

        EstadoTicket estado = crearEstado(estadoActual);
        EstadoTicket siguiente;
        if ("EN PROCESO".equals(estadoSolicitado)) {
            siguiente = estado.iniciarAtencion();
        } else if ("RESUELTO".equals(estadoSolicitado)) {
            siguiente = estado.resolver();
        } else {
            return null;
        }

        return normalizarEstado(siguiente.getNombreEstado());
    }

    private EstadoTicket crearEstado(String estado) {
        if ("NUEVO".equals(estado)) {
            return new EstadoNuevo();
        }
        if ("ASIGNADO".equals(estado)) {
            return new EstadoAsignado();
        }
        if ("EN PROCESO".equals(estado)) {
            return new EstadoEnProceso();
        }
        if ("RESUELTO".equals(estado)) {
            return new EstadoResuelto();
        }
        throw new IllegalStateException("Estado de ticket no reconocido: " + estado);
    }

    private void notificarCambioEstado(int idTicket, String estado) {
        String correoSolicitante = agenteTicketRepository.obtenerCorreoSolicitante(idTicket);
        if (correoSolicitante == null || correoSolicitante.trim().isEmpty()) {
            return;
        }

        if ("RESUELTO".equals(estado)) {
            notificacionService.notificarTicketResuelto(correoSolicitante, idTicket);
        } else {
            notificacionService.notificarCambioEstado(correoSolicitante, idTicket, estado);
        }
    }

    private boolean esPrioridadUrgente(String prioridad) {
        return prioridad != null
                && (prioridad.equalsIgnoreCase("Alta")
                || prioridad.equalsIgnoreCase("Urgente")
                || prioridad.equalsIgnoreCase("Crítica")
                || prioridad.equalsIgnoreCase("Inmediata"));
    }

    private boolean esPendiente(String estado) {
        return estado != null
                && !"CERRADO".equalsIgnoreCase(estado)
                && !"CANCELADO".equalsIgnoreCase(estado);
    }
}
