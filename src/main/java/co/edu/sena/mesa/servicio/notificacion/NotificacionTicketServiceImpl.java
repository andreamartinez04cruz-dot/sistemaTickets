package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.repositorio.NotificacionTicketRepository;
import co.edu.sena.mesa.modelo.estado.EstadoTicketFactory;
import java.util.List;
import java.util.Map;

public class NotificacionTicketServiceImpl implements NotificacionTicketService {

    private final NotificacionTicketRepository notificacionTicketRepository;

    public NotificacionTicketServiceImpl(NotificacionTicketRepository notificacionTicketRepository) {
        this.notificacionTicketRepository = notificacionTicketRepository;
    }

    @Override
    public int finalizarTicket(int idTicket, String rol, int idUsuario) {
        String estadoActual = notificacionTicketRepository
                .obtenerEstadoActual(idTicket, rol, idUsuario);
        if (estadoActual == null) {
            return 0;
        }
        EstadoTicketFactory.crear(estadoActual).confirmar();
        return notificacionTicketRepository.finalizarTicket(idTicket, rol, idUsuario);
    }

    @Override
    public int reabrirTicket(int idTicket, String rol, int idUsuario) {
        String estadoActual = notificacionTicketRepository
                .obtenerEstadoActual(idTicket, rol, idUsuario);
        if (estadoActual == null) {
            return 0;
        }
        EstadoTicketFactory.crear(estadoActual).reabrir();
        return notificacionTicketRepository.reabrirTicket(idTicket, rol, idUsuario);
    }

    @Override
    public List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario) {
        return notificacionTicketRepository.listarNotificaciones(rol, idUsuario);
    }
}
