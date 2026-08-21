package co.edu.sena.mesa.web.admin;

import co.edu.sena.mesa.servicio.AdminTicketService;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/admin/usuarios", "/admin/usuariosList"})
public class AdminUsuariosServlet extends HttpServlet {

    private AdminTicketService adminTicketService;

    @Override
    public void init() throws ServletException {
        adminTicketService = (AdminTicketService) getServletContext()
                .getAttribute("adminTicketService");
        if (adminTicketService == null) {
            throw new ServletException("AdminTicketService no fue inicializado en el AppContextListener");
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

        List<Map<String, Object>> gestores = adminTicketService.listarGestores();
        request.setAttribute("gestores", gestores);
        request.getRequestDispatcher("/usuarios.jsp").forward(request, response);
    }
}
