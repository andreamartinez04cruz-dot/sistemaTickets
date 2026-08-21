package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.config.RegistroErrores;
import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;
import co.edu.sena.mesa.servicio.sla.SlaService;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
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
            TicketHistoryHelper.cancelar(request, response, solicitanteTicketService, usuario);
            return;
        }

        if ("historial".equalsIgnoreCase(action)) {
            TicketHistoryHelper.cargar(
                    request, response, solicitanteTicketService, usuario, "/MisSolicitudes.jsp");
            return;
        }

        List<Categoria> categorias = solicitanteTicketService.ListarCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/RegistroTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoriaNombre = request.getParameter("categoria");
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

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
    Usuario solicitante = (Usuario) session.getAttribute("usuario");

        if (solicitante == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        TicketDTO ticketRegistrado = TicketRegistrationHelper.registrar(
            request,
            solicitante,
            categoriaNombre,
            slaService,
            solicitanteTicketService);

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

        RespuestaTicket.escribirRegistroExitoso(response, ticketRegistrado, redirectUrl);
    }
}
