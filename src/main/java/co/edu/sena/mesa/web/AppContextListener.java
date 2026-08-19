/*
 * Click nbfs://nbhost/SystemFileTools/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileTools/Templates/Classes/Class.java to edit this template
 */
package co.edu.sena.mesa.web;

import co.edu.sena.mesa.repositorio.TicketRepository;
import co.edu.sena.mesa.repositorio.TicketRepositoryJdbc;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.TicketServiceImpl;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author Doris López
 */
@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {

        TicketRepository ticketRepository
                = new TicketRepositoryJdbc();

        TicketService ticketService
                = new TicketServiceImpl(ticketRepository);

        event.getServletContext()
                .setAttribute("ticketService", ticketService);
    }
}
