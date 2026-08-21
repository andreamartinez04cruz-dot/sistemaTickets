package co.edu.sena.mesa.servicio.notificacion;

import java.util.List;
import java.util.Map;

public interface NotificacionTicketService {

    int finalizarTicket(int idTicket, String rol, int idUsuario);

    int reabrirTicket(int idTicket, String rol, int idUsuario);

    List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario);
}
