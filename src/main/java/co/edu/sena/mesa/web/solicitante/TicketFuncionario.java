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
        String categoriaNombre = request.getParameter("categoria");
        SlaService slaService = (SlaService) getServletContext().getAttribute("slaService");
        HttpSession session = request.getSession();
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

        RespuestaTicket.escribirRegistroExitoso(
            response,
                ticketRegistrado,
            request.getContextPath() + "/tickets/registrar/Funcionario?action=historial");
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
            TicketHistoryHelper.cancelar(request, response, solicitanteTicketService, usuario);
            return;
        }

        // HISTORIAL DE SOLICITUDES
        if ("historial".equals(action)) {

                TicketHistoryHelper.cargar(
                    request, response, solicitanteTicketService, usuario, "/MisSolicitudes.jsp");

        } else {
            // FORMULARIO DE NUEVA SOLICITUD
            List<Categoria> categorias = solicitanteTicketService.ListarCategorias();
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("/SolicitudFuncionario.jsp").forward(request, response);
        }
    }
}
