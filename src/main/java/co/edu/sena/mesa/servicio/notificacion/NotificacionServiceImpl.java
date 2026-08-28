package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.dto.DestinatarioNotificacionDTO;
import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.util.RegistroErrores;
import java.util.List;

public class NotificacionServiceImpl implements NotificacionService {

    private final Notificador notificador;
    private final AgenteTicketRepository agenteTicketRepository;

    public NotificacionServiceImpl(Notificador notificador) {
        this(notificador, null);
    }

    public NotificacionServiceImpl(Notificador notificador,
            AgenteTicketRepository agenteTicketRepository) {
        this.notificador = notificador;
        this.agenteTicketRepository = agenteTicketRepository;
    }

    @Override
    public void notificarATodosLosRoles(int idTicket, String nuevoEstado) {
        if (agenteTicketRepository == null) {
            return;
        }
        try {
            List<DestinatarioNotificacionDTO> destinatarios =
                agenteTicketRepository.obtenerDestinatariosNotificacion(idTicket);
            for (DestinatarioNotificacionDTO destinatario : destinatarios) {
                notificarSegunRol(destinatario, idTicket, nuevoEstado);
            }
        } catch (Exception e) {
            // Notificar nunca debe interrumpir la operacion sobre el ticket
            RegistroErrores.registrar("Error notificando el ticket " + idTicket, e);
        }
    }

    @Override
    public void notificarCambioEstado(String destinatario, int idTicket, String nuevoEstado) {
        String asunto = "Cambio de estado del ticket";
        String mensaje = "El ticket #" + idTicket + " cambió a " + nuevoEstado + ".";
        notificador.enviar(destinatario, asunto, mensaje);
    }

    @Override
    public void notificarTicketResuelto(String destinatario, int idTicket) {
        String asunto = "Ticket resuelto";
        String mensaje = "El ticket #" + idTicket + " fue marcado como RESUELTO.";
        notificador.enviar(destinatario, asunto, mensaje);
    }

    @Override
    public void notificarSegunRol(DestinatarioNotificacionDTO destinatario, int idTicket,
            String nuevoEstado) {
        String titulo = destinatario.getTitulo();
        String asunto;
        String mensaje;

        if ("AGENTE".equals(destinatario.getRol())) {
            asunto = "Asignacion de ticket";
            mensaje = "Se te asigno el ticket #" + idTicket + " - " + titulo
                + ". Estado actual: " + nuevoEstado + ".";
        } else if ("ADMIN".equals(destinatario.getRol())) {
            asunto = "Ticket asignado";
            mensaje = "El ticket #" + idTicket + " - " + titulo
                + " (" + destinatario.getCategoria() + ") fue asignado a "
                + destinatario.getAgente() + ". Estado actual: " + nuevoEstado + ".";
        } else {
            asunto = "Cambio de estado del ticket";
            mensaje = "El ticket #" + idTicket + " - " + titulo
                + " esta en estado " + nuevoEstado + ".";
        }

        notificador.enviar(destinatario.getCorreo(), asunto, mensaje);
    }
}
