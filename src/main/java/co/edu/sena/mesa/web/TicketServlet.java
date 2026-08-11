/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.sena.mesa.web;

import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.TicketService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/tickets/registrar")
/**
 *
 * @author Doris López
 */
public class TicketServlet extends HttpServlet {

    private TicketService ticketService;

    @Override
    public void init() throws ServletException {

        ticketService = (TicketService) getServletContext()
                .getAttribute("ticketService");

        if (ticketService == null) {
            throw new ServletException(
                    "TicketService no fue configurado"
            );
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");

        Long idCategoria = Long.valueOf(
                request.getParameter("categoria")
        );

        Long idSolicitante = Long.valueOf(
                request.getParameter("solicitante")
        );

        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);

        Prioridad prioridad = new Prioridad();
        prioridad.setId(1L);

        Usuario solicitante = new Usuario();
        solicitante.setId(idSolicitante);

        Ticket ticket = new Ticket();

        ticket.setTitulo(titulo);
        ticket.setDescripcion(descripcion);
        ticket.setCategoria(categoria);
        ticket.setPrioridad(prioridad);
        ticket.setSolicitante(solicitante);
        ticket.setEstado("NUEVO");
        ticket.setFechaCreacion(LocalDateTime.now());

        ticketService.registrarTicket(ticket);

        response.sendRedirect(
                request.getContextPath()
                + "/registrar.jsp?exito=true"
        );
    }
}
