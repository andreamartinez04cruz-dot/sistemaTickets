package co.edu.sena.mesaayuda.servicio.notificacion;

public interface NotificacionService {

    void notificarCambioEstado(String destinatario, int idTicket, String nuevoEstado);

    void notificarTicketResuelto(String destinatario, int idTicket);
}
