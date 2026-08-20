package co.edu.sena.mesa.web.admin;

import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesa.repositorio.DashboardRepository;
import co.edu.sena.mesa.repositorio.DashboardRepositoryJdbc;
import co.edu.sena.mesa.servicio.DashboardService;
import co.edu.sena.mesa.servicio.DashboardServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/reportes")
public class AdminReportesServlet extends HttpServlet {

    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        DashboardRepository dashboardRepository = new DashboardRepositoryJdbc();
        dashboardService = new DashboardServiceImpl(dashboardRepository);
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
        request.setAttribute("estadisticasAdmin", estadisticas);

        request.getRequestDispatcher("/ReportesAdmin.jsp").forward(request, response);
    }
}
