package co.edu.sena.mesa.servicio.notificacion;

public interface NotificacionService {

    void notificarCambioEstado(String destinatario, int idTicket, String nuevoEstado);

    void notificarTicketResuelto(String destinatario, int idTicket);
}
