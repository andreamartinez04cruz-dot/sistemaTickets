package co.edu.sena.mesa.servicio.agente;

import co.edu.sena.mesa.dto.AgenteTicketDTO;
import co.edu.sena.mesa.dto.AgenteTicketsResumenDTO;
import co.edu.sena.mesa.mapper.AgenteTicketsResumenMapper;
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.modelo.estado.EstadoTicketFactory;
import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.servicio.notificacion.NotificacionService;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.function.Function;

public class AgenteTicketServiceImpl implements AgenteTicketService {

    private static final Map<String, Function<EstadoTicket, EstadoTicket>> TRANSICIONES = Map.of(
            "EN PROCESO", EstadoTicket::iniciarAtencion,
            "RESUELTO", EstadoTicket::resolver
    );
        private static final Map<String, String> ACCIONES_RESOLUCION = Map.of(
            "resolverTicket", "RESUELTO"
        );

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
        String estadoSolicitado = ACCIONES_RESOLUCION.getOrDefault(
            accion,
            normalizarEstado(nuevoEstado));

        if (estadoSolicitado == null) {
            return "Debe elegir un estado válido.";
        }

        String estado = aplicarTransicion(estadoActual, estadoSolicitado);
        if (estado == null) {
            return "La transición de estado no es válida.";
        }

        int filasActualizadas = agenteTicketRepository.actualizarEstado(idTicket, idAgente, estado);
        if (filasActualizadas == 0) {
            return ACCIONES_RESOLUCION.containsKey(accion)
                ? "No se pudo resolver el ticket."
                : "No se pudo actualizar el estado.";
        }

        notificarCambioEstado(idTicket, estado);
        return ACCIONES_RESOLUCION.containsKey(accion)
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

        return AgenteTicketsResumenMapper.toDTO(tickets, urgentes, pendientes);
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

        Function<EstadoTicket, EstadoTicket> transicion = TRANSICIONES.get(estadoSolicitado);
        if (transicion == null) {
            return null;
        }

        return normalizarEstado(transicion.apply(EstadoTicketFactory.crear(estadoActual))
                .getNombreEstado());
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
