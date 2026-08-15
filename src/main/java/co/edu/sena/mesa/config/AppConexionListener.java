package co.edu.sena.mesa.config;

import co.edu.sena.mesa.repositorio.TicketRepository;
import co.edu.sena.mesa.repositorio.TicketRepositoryJdbc;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.TicketServiceImpl;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppConexionListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {

        // Crear el repositorio
        TicketRepository ticketRepository
                = new TicketRepositoryJdbc();

        // Crear el servicio
        TicketService ticketService
                = new TicketServiceImpl(ticketRepository);

        // Guardar el servicio en el contexto de la aplicación
        event.getServletContext().setAttribute(
                "ticketService",
                ticketService
        );

        System.out.println(
                ">>> TicketService configurado correctamente"
        );
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        // Aquí se pueden cerrar recursos cuando se detenga la aplicación
    }
}
