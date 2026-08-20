package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;
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
        solicitanteTicketService = (SolicitanteTicketService) getServletContext()
                .getAttribute("solicitanteTicketService");
        if (solicitanteTicketService == null) {
            throw new ServletException("TicketService no fue inicializado en el AppContextListener");
        }
    }

    private SolicitanteTicketService solicitanteTicketService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String categoriaNombre = request.getParameter("categoria");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        SlaService slaService = (SlaService) getServletContext().getAttribute("slaService");
        CalcularPrioridad estrategiaSla = slaService.obtenerEstrategia(String.valueOf(idCategoria));
        String prioridadCalculada = estrategiaSla.determinarPrioridad();
        int idPrioridad = estrategiaSla.obtenerIdPrioridad();
        HttpSession session = request.getSession();
        Usuario solicitante = (Usuario) session.getAttribute("usuario");

        if (solicitante == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        TicketDTO dto = new TicketDTO();
        dto.setTitulo(titulo);
        dto.setDescripcion(descripcion);
        dto.setIdCategoria(idCategoria);
        dto.setIdSolicitante(solicitante.getId());
        dto.setIdPrioridad(idPrioridad);
        dto.setPrioridadNombre(prioridadCalculada);
        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        categoria.setNombre(categoriaNombre);
        Prioridad prioridad = new Prioridad();
        prioridad.setId(idPrioridad);
        prioridad.setNombre(prioridadCalculada);
        solicitanteTicketService.RegistrarTicket(dto, categoria, solicitante, slaService);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
        out.println("<script>");
        out.println("Swal.fire({ icon: 'success', title: '¡Ticket registrado!', "
            + "text: 'Se ha asignado prioridad: " + dto.getPrioridadNombre() + "', "
            + "confirmButtonText: 'Aceptar' }).then(() => { "
            + "window.location.href = '" + request.getContextPath() + "/tickets/registrar/Funcionario?action=historial'; });");
        out.println("</script></body></html>");
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("cancelar".equalsIgnoreCase(action)) {
            String idTicketParam = request.getParameter("idTicket");
            if (idTicketParam != null && !idTicketParam.isBlank()) {
                try {
                    int idTicket = Integer.parseInt(idTicketParam);
                    solicitanteTicketService.cancelarTicketSolicitante(idTicket, usuario.getId());
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            response.sendRedirect(request.getContextPath() + "/tickets/registrar?action=historial");
            return;
        }

        // HISTORIAL DE SOLICITUDES
        if ("historial".equals(action)) {

            List<HistorialFuncionarioDTO> tickets = solicitanteTicketService.listarTicketsPorSolicitante((int) usuario.getId());
            request.setAttribute("tickets", tickets);

            // REDIRIGE AL JSP CORRESPONDIENTE
            request.getRequestDispatcher("/MisSolicitudes.jsp").forward(request, response);

        } else {
            // FORMULARIO DE NUEVA SOLICITUD
            List<Categoria> categorias = solicitanteTicketService.ListarCategorias();
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("/SolicitudFuncionario.jsp").forward(request, response);
        }
    }
}
