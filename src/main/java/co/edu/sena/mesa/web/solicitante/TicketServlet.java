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

@WebServlet("/tickets/registrar")
public class TicketServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        if ("historial".equalsIgnoreCase(action)) {
            List<HistorialFuncionarioDTO> tickets = solicitanteTicketService.listarTicketsPorSolicitante(usuario.getId());
            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("/MisSolicitudes.jsp").forward(request, response);
            return;
        }

        List<Categoria> categorias = solicitanteTicketService.ListarCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/RegistroTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String categoriaNombre = request.getParameter("categoria");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

        String programa = request.getParameter("programa");
        String numeroPrograma = request.getParameter("numeroPrograma");
        String instructor = request.getParameter("instructor");
        String jornada = request.getParameter("jornada");

        // Si categoriaNombre no viene, lo buscamos usando idCategoria
        if (categoriaNombre == null || categoriaNombre.trim().isEmpty()) {
            List<Categoria> categorias = solicitanteTicketService.ListarCategorias();
            if (categorias != null) {
                for (Categoria cat : categorias) {
                    if (cat.getId() == idCategoria) {
                        categoriaNombre = cat.getNombre();
                        break;
                    }
                }
            }
        }
    HttpSession session = request.getSession();
    SlaService slaService = (SlaService) getServletContext().getAttribute("slaService");
    CalcularPrioridad estrategiaSla = slaService.obtenerEstrategia(String.valueOf(idCategoria));
    String prioridadCalculada = estrategiaSla.determinarPrioridad();
    int idPrioridad = estrategiaSla.obtenerIdPrioridad();
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
        dto.setPrograma(programa);
        dto.setNumeroPrograma(numeroPrograma);
        dto.setInstructor(instructor);
        dto.setJornada(jornada);

        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        categoria.setNombre(categoriaNombre);

        Prioridad prioridad = new Prioridad();
        prioridad.setId(idPrioridad);
        prioridad.setNombre(prioridadCalculada);

        solicitanteTicketService.RegistrarTicket(dto, categoria, solicitante, slaService);

        String redirectUrl = request.getContextPath() + "/SolicitudFuncionario.jsp";
        String rolUsuarioPost = (String) session.getAttribute("rolUsuario");
        if ((rolUsuarioPost == null || rolUsuarioPost.isEmpty()) && solicitante.getRoles() != null) {
            for (co.edu.sena.mesa.modelo.Rol rol : solicitante.getRoles()) {
                String nombreRol = (rol != null && rol.getTiporol() != null)
                        ? rol.getTiporol().toUpperCase() : "";
                if (nombreRol.contains("APRENDIZ")) {
                    rolUsuarioPost = "APRENDIZ";
                    break;
                }
            }
        }
        if ("APRENDIZ".equals(rolUsuarioPost)) {
            redirectUrl = request.getContextPath() + "/RegistroTicket.jsp";
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
        out.println("<script>");
        out.println("Swal.fire({ icon: 'success', title: '¡Ticket registrado!', "
                + "text: 'Se ha asignado prioridad: " + dto.getPrioridadNombre() + "', "
                + "confirmButtonText: 'Aceptar' }).then(() => { "
                + "window.location.href = '" + redirectUrl + "'; });");
        out.println("</script></body></html>");
    }
}
