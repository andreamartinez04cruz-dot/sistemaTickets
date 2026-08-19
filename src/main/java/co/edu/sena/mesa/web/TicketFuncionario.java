package co.edu.sena.mesa.web;

import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/tickets/registrar/Funcionario")
public class TicketFuncionario extends HttpServlet {

    @Override
    public void init() throws ServletException {
        // Intentamos recuperar el servicio del contexto de la aplicación
        ticketService = (TicketService) getServletContext().getAttribute("ticketService");

        // Si es null, aquí es donde salta la alerta o se valida
        if (ticketService == null) {
            // Ocurre si el Listener no corrió o guardó el nombre con otra clave
            throw new ServletException("TicketService no fue inicializado en el AppContextListener");
        }
    }

    private TicketService ticketService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String categoriaNombre = request.getParameter("categoria");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

        // 2. Obtener el SlaService del contexto de la aplicación (configurado en el AppContextListener)
        SlaService slaService = (SlaService) getServletContext().getAttribute("slaService");

        // 3. Aplicar el Patrón Strategy sin condicionales usando el SlaService
        CalcularPrioridad estrategiaSla = slaService.obtenerEstrategia(String.valueOf(idCategoria));
        String prioridadCalculada = estrategiaSla.determinarPrioridad();
        int idPrioridad = estrategiaSla.obtenerIdPrioridad(); // ID directo de la BD

        // 4. Obtener el solicitante de la sesión
        HttpSession session = request.getSession();
        Usuario solicitante = (Usuario) session.getAttribute("usuario");

        if (solicitante == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        // 5. Crear y poblar el DTO
        TicketDTO dto = new TicketDTO();
        dto.setTitulo(titulo);
        dto.setDescripcion(descripcion);
        dto.setIdCategoria(idCategoria);
        dto.setIdSolicitante(solicitante.getId());
        dto.setIdPrioridad(idPrioridad);
        dto.setPrioridadNombre(prioridadCalculada);

        // 6. Preparar las entidades requeridas por el servicio
        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        categoria.setNombre(categoriaNombre);

        Prioridad prioridad = new Prioridad();
        prioridad.setId(idPrioridad);
        prioridad.setNombre(prioridadCalculada);

        // 7. Llamar al servicio con los 4 parámetros clásicos
        ticketService.RegistrarTicket(dto, categoria, solicitante, slaService);

        // 8. Respuesta de éxito con SweetAlert
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
        out.println("<script>");
        out.println("Swal.fire({ icon: 'success', title: '¡Ticket registrado!', "
                + "text: 'Se ha asignado prioridad: " + dto.getPrioridadNombre() + "', "
                + "confirmButtonText: 'Aceptar' }).then(() => { "
                + "window.location.href = '" + request.getContextPath() + "/tickets/registrar'; });");
        out.println("</script></body></html>");
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // HISTORIAL DE SOLICITUDES
        if ("historial".equals(action)) {

            HttpSession session = request.getSession(false);
            Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

            if (usuario == null) {
                response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
                return;
            }

            List<HistorialFuncionarioDTO> tickets = ticketService.listarTicketsPorSolicitante((int) usuario.getId());
            request.setAttribute("tickets", tickets);

            // REDIRIGE AL JSP CORRESPONDIENTE
            request.getRequestDispatcher("/MisSolicitudes.jsp").forward(request, response);

        } else {
            // FORMULARIO DE NUEVA SOLICITUD
            List<Categoria> categorias = ticketService.ListarCategorias();
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("/SolicitudFuncionario.jsp").forward(request, response);
        }
    }
}
