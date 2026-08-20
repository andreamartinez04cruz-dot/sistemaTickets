package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.repositorio.NotificacionTicketRepository;
import java.util.List;
import java.util.Map;

public class NotificacionTicketServiceImpl implements NotificacionTicketService {

    private final NotificacionTicketRepository notificacionTicketRepository;

    public NotificacionTicketServiceImpl(NotificacionTicketRepository notificacionTicketRepository) {
        this.notificacionTicketRepository = notificacionTicketRepository;
    }

    @Override
    public int finalizarTicket(int idTicket, String rol, int idUsuario) {
        return notificacionTicketRepository.finalizarTicket(idTicket, rol, idUsuario);
    }

    @Override
    public List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario) {
        return notificacionTicketRepository.listarNotificaciones(rol, idUsuario);
    }
}
