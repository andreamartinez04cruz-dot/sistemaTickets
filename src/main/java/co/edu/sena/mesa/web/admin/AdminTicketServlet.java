package co.edu.sena.mesa.web.admin;

import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesa.servicio.AdminTicketService;
import co.edu.sena.mesa.servicio.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/tickets")
public class AdminTicketServlet extends HttpServlet {

    private AdminTicketService adminTicketService;
    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        adminTicketService = (AdminTicketService) getServletContext()
                .getAttribute("adminTicketService");
        if (adminTicketService == null) {
            throw new ServletException("AdminTicketService no fue inicializado en el AppContextListener");
        }

        dashboardService = (DashboardService) getServletContext()
                .getAttribute("dashboardService");
        if (dashboardService == null) {
            throw new ServletException("DashboardService no fue inicializado en el AppContextListener");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        DashboardEstadisticasDTO estadisticas = dashboardService.obtenerEstadisticasAdministrador();

        request.setAttribute("aprendizTickets", adminTicketService.listarTicketsAprendiz());
        request.setAttribute("funcionarioTickets", adminTicketService.listarTicketsFuncionario());
        request.setAttribute("estadisticasAdmin", estadisticas);

        request.getRequestDispatcher("/AdminTickets.jsp").forward(request, response);
    }
}
