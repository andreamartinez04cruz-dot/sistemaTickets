package co.edu.sena.mesa.web;

import co.edu.sena.mesa.repositorio.TicketRepository;
import co.edu.sena.mesa.repositorio.TicketRepositoryJdbc;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.TicketServiceImpl;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaAltaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaBajaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaCriticaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaMediaStrategy;
import co.edu.sena.mesa.servicio.sla.SlaService;

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
        TicketService ticketService = new TicketServiceImpl(ticketRepository);
        event.getServletContext().setAttribute("ticketService", ticketService);

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
                e.printStackTrace();
            }
            java.util.Enumeration<Driver> drivers = DriverManager.getDrivers();
            while (drivers.hasMoreElements()) {
                Driver driver = drivers.nextElement();
                try {
                    DriverManager.deregisterDriver(driver);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
