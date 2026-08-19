package co.edu.sena.mesa.servicio.notificacion;

public class NotificacionServiceImpl implements NotificacionService {

    private final Notificador notificador;

    public NotificacionServiceImpl(Notificador notificador) {
        this.notificador = notificador;
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
}
