package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.dto.DestinatarioNotificacionDTO;

public interface NotificacionService {

    void notificarCambioEstado(String destinatario, int idTicket, String nuevoEstado);

    void notificarTicketResuelto(String destinatario, int idTicket);

    /** Envia el mensaje que le corresponde al rol del destinatario. */
    void notificarSegunRol(DestinatarioNotificacionDTO destinatario, int idTicket, String nuevoEstado);

    /** Notifica a solicitante, agente asignado y administradores del ticket. */
    void notificarATodosLosRoles(int idTicket, String nuevoEstado);
}
