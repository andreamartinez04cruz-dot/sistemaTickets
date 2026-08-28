package co.edu.sena.mesa.web.system;

import co.edu.sena.mesa.repositorio.TicketRepository;
import co.edu.sena.mesa.repositorio.TicketRepositoryJdbc;
import co.edu.sena.mesa.repositorio.AdminTicketRepository;
import co.edu.sena.mesa.repositorio.AdminTicketRepositoryJdbc;
import co.edu.sena.mesa.repositorio.DashboardRepository;
import co.edu.sena.mesa.repositorio.DashboardRepositoryJdbc;
import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.repositorio.AgenteTicketRepositoryJdbc;
import co.edu.sena.mesa.repositorio.AsignacionRepository;
import co.edu.sena.mesa.repositorio.AsignacionRepositoryJdbc;
import co.edu.sena.mesa.repositorio.NotificacionTicketRepository;
import co.edu.sena.mesa.repositorio.NotificacionTicketRepositoryJdbc;
import co.edu.sena.mesa.servicio.AdminTicketService;
import co.edu.sena.mesa.servicio.AdminTicketServiceImpl;
import co.edu.sena.mesa.servicio.DashboardService;
import co.edu.sena.mesa.servicio.DashboardServiceImpl;
import co.edu.sena.mesa.servicio.agente.AgenteTicketService;
import co.edu.sena.mesa.servicio.agente.AgenteTicketServiceImpl;
import co.edu.sena.mesa.servicio.asignacion.AsignacionRoundRobinStrategy;
import co.edu.sena.mesa.servicio.asignacion.AsignacionService;
import co.edu.sena.mesa.servicio.asignacion.AsignacionServiceImpl;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.TicketServiceImpl;
import co.edu.sena.mesa.servicio.UsuarioService;
import co.edu.sena.mesa.servicio.UsuarioServiceImpl;
import co.edu.sena.mesa.repositorio.UsuarioRepository;
import co.edu.sena.mesa.repositorio.UsuarioRepositoryJdbc;
import co.edu.sena.mesa.config.RegistroErrores;
import co.edu.sena.mesa.servicio.notificacion.NotificacionService;
import co.edu.sena.mesa.servicio.notificacion.NotificacionServiceImpl;
import co.edu.sena.mesa.servicio.notificacion.NotificacionTicketService;
import co.edu.sena.mesa.servicio.notificacion.NotificacionTicketServiceImpl;
import co.edu.sena.mesa.servicio.notificacion.Notificador;
import co.edu.sena.mesa.servicio.notificacion.NotificadorEnAplicacion;
import co.edu.sena.mesa.servicio.notificacion.NotificadorEmail;
import co.edu.sena.mesa.servicio.notificacion.NotificadorCompuesto;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaAltaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaBajaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaCriticaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaMediaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaService;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {

        TicketRepository ticketRepository = new TicketRepositoryJdbc();
        AsignacionRepository asignacionRepository = new AsignacionRepositoryJdbc();
        AsignacionService asignacionService = new AsignacionServiceImpl(
            asignacionRepository,
            new AsignacionRoundRobinStrategy());
        TicketService ticketService = new TicketServiceImpl(ticketRepository, asignacionService);
        event.getServletContext().setAttribute("ticketService", ticketService);
        event.getServletContext().setAttribute("solicitanteTicketService", (SolicitanteTicketService) ticketService);

        UsuarioRepository usuarioRepository = new UsuarioRepositoryJdbc();
        UsuarioService usuarioService = new UsuarioServiceImpl(usuarioRepository);
        event.getServletContext().setAttribute("usuarioService", usuarioService);

        AdminTicketRepository adminTicketRepository = new AdminTicketRepositoryJdbc();
        AdminTicketService adminTicketService = new AdminTicketServiceImpl(adminTicketRepository);
        event.getServletContext().setAttribute("adminTicketService", adminTicketService);

        DashboardRepository dashboardRepository = new DashboardRepositoryJdbc();
        DashboardService dashboardService = new DashboardServiceImpl(dashboardRepository);
        event.getServletContext().setAttribute("dashboardService", dashboardService);

        Notificador notificadorEnAplicacion = new NotificadorEnAplicacion();
        Notificador notificador;
        try {
            Notificador notificadorEmail = new NotificadorEmail();
            notificador = new NotificadorCompuesto(
                java.util.List.of(notificadorEnAplicacion, notificadorEmail));
        } catch (Exception e) {
            // Si el correo real falla al iniciar, la app sigue funcionando solo con notificación en aplicación
            RegistroErrores.registrar("No se pudo inicializar el notificador de correo, se usará solo notificación en aplicación", e);
            notificador = notificadorEnAplicacion;
        }
        NotificacionService notificacionService = new NotificacionServiceImpl(notificador);
        event.getServletContext().setAttribute("notificacionService", notificacionService);

        NotificacionTicketRepository notificacionTicketRepository = new NotificacionTicketRepositoryJdbc();
        NotificacionTicketService notificacionTicketService = new NotificacionTicketServiceImpl(
            notificacionTicketRepository);
        event.getServletContext().setAttribute("notificacionTicketService", notificacionTicketService);

        AgenteTicketRepository agenteTicketRepository = new AgenteTicketRepositoryJdbc();
        AgenteTicketService agenteTicketService = new AgenteTicketServiceImpl(
            agenteTicketRepository,
            notificacionService);
        event.getServletContext().setAttribute("agenteTicketService", agenteTicketService);

        //PRIORIDAD
        // Deja las estrategias de SLA
        SlaService slaService = new SlaService();

// Instancias de tus estrategias
        CalcularPrioridad critica = new SlaCriticaStrategy();
        CalcularPrioridad alta = new SlaAltaStrategy();
        CalcularPrioridad media = new SlaMediaStrategy();
        CalcularPrioridad baja = new SlaBajaStrategy();

// Mapeas los IDs de tus categorías (ejemplo agrupando por criticidad)
        slaService.registrarEstrategia("1", baja);
        slaService.registrarEstrategia("2", baja);
        slaService.registrarEstrategia("8", baja); // Aquí registras el ID 8 que te dio el error

        slaService.registrarEstrategia("3", media);
        slaService.registrarEstrategia("4", media);

        slaService.registrarEstrategia("5", alta);
        slaService.registrarEstrategia("6", alta);

        slaService.registrarEstrategia("7", critica);
        slaService.registrarEstrategia("9", critica);
        slaService.registrarEstrategia("10", critica);

        event.getServletContext().setAttribute("slaService", slaService);
    }

        @Override
        public void contextDestroyed
        (ServletContextEvent event
        
            ) {
        // Limpieza explícita del driver JDBC para evitar bloqueos en Tomcat
        try {
                com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            } catch (Exception e) {
                RegistroErrores.registrar("Error cerrando recursos JDBC de Tomcat", e);
            }
            java.util.Enumeration<Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                Driver driver = drivers.nextElement();
                try {
                    DriverManager.deregisterDriver(driver);
                } catch (SQLException e) {
                    RegistroErrores.registrar("Error liberando driver JDBC", e);
                }
            }
        }
    }
