package co.edu.sena.mesa.servicio.notificacion;

import java.util.List;
import java.util.Map;

public interface NotificacionTicketService {

    int finalizarTicket(int idTicket, String rol, int idUsuario);

    /** Cierre confirmado por el solicitante mediante el codigo enviado a su correo. */
    int finalizarTicket(int idTicket, String rol, int idUsuario, String codigo);

    int reabrirTicket(int idTicket, String rol, int idUsuario);

    List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario);
}
