package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.repositorio.NotificacionTicketRepository;
import co.edu.sena.mesa.modelo.estado.EstadoTicketFactory;
import java.util.List;
import java.util.Map;

public class NotificacionTicketServiceImpl implements NotificacionTicketService {

    private final NotificacionTicketRepository notificacionTicketRepository;
    private final NotificacionService notificacionService;

    public NotificacionTicketServiceImpl(NotificacionTicketRepository notificacionTicketRepository) {
        this(notificacionTicketRepository, null);
    }

    public NotificacionTicketServiceImpl(
            NotificacionTicketRepository notificacionTicketRepository,
            NotificacionService notificacionService) {
        this.notificacionTicketRepository = notificacionTicketRepository;
        this.notificacionService = notificacionService;
    }

    @Override
    public int finalizarTicket(int idTicket, String rol, int idUsuario) {
        String estadoActual = notificacionTicketRepository
                .obtenerEstadoActual(idTicket, rol, idUsuario);
        if (estadoActual == null) {
            return 0;
        }
        EstadoTicketFactory.crear(estadoActual).confirmar();
        int filas = notificacionTicketRepository.finalizarTicket(idTicket, rol, idUsuario);
        if (filas > 0 && notificacionService != null) {
            notificacionService.notificarATodosLosRoles(idTicket, "CERRADO");
        }
        return filas;
    }

    @Override
    public int reabrirTicket(int idTicket, String rol, int idUsuario) {
        String estadoActual = notificacionTicketRepository
                .obtenerEstadoActual(idTicket, rol, idUsuario);
        if (estadoActual == null) {
            return 0;
        }
        EstadoTicketFactory.crear(estadoActual).reabrir();
        int filas = notificacionTicketRepository.reabrirTicket(idTicket, rol, idUsuario);
        if (filas > 0 && notificacionService != null) {
            notificacionService.notificarATodosLosRoles(idTicket, "EN PROCESO");
        }
        return filas;
    }

    @Override
    public List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario) {
        return notificacionTicketRepository.listarNotificaciones(rol, idUsuario);
    }
}
