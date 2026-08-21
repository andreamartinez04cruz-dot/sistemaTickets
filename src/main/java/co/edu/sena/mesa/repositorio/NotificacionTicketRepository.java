package co.edu.sena.mesa.repositorio;

import java.util.List;
import java.util.Map;

public interface NotificacionTicketRepository {

    int finalizarTicket(int idTicket, String rol, int idUsuario);

    String obtenerEstadoActual(int idTicket, String rol, int idUsuario);

    int reabrirTicket(int idTicket, String rol, int idUsuario);

    List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario);
}
