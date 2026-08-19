package co.edu.sena.mesa.web;

import co.edu.sena.mesa.dto.ComentarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/tickets/comentar")
public class ComentarioServlet extends HttpServlet {

    private TicketService ticketService;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Obtener la sesión activa y validar usuario
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Obtener parámetros del formulario
        String idTicketStr = request.getParameter("idTicket");
        String texto = request.getParameter("texto");

        if (idTicketStr != null && texto != null && !texto.trim().isEmpty()) {
            int idTicket = Integer.parseInt(idTicketStr);

            // 3. Crear el DTO con la información
            ComentarioDTO dto = new ComentarioDTO();
            dto.setIdTicket(idTicket);
            dto.setIdUsuario(usuario.getId());
            dto.setTexto(texto.trim());

// 4. Guardar el comentario mediante el servicio
            ticketService.agregarComentario(dto);

// 5. Guardar una bandera de éxito en la sesión
            request.getSession().setAttribute("mensajeExito", "Comentario agregado correctamente");

// 6. Redireccionar al detalle del ticket
            response.sendRedirect(request.getContextPath() + "/tickets/comentar?id=" + idTicket);
        } else {
            // Si el texto está vacío, recargamos la misma página sin guardar nada
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/tickets");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idTicket = Integer.parseInt(request.getParameter("id"));

        // 1. Obtener ticket y su lista de comentarios DTO
        TicketDTO ticket = ticketService.obtenerPorId(idTicket);
        List<ComentarioDTO> comentarios = ticketService.listarComentarios(idTicket);

        // 2. Pasar los atributos al JSP
        request.setAttribute("ticket", ticket);
        request.setAttribute("comentarios", comentarios);

        // 3. Renderizar la vista
        request.getRequestDispatcher("/Comentarios.jsp").forward(request, response);
    }
}
