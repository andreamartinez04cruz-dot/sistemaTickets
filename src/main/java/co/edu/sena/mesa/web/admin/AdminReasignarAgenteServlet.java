package co.edu.sena.mesa.web.admin;

import co.edu.sena.mesa.servicio.AdminTicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet({"/admin/reasignar-agentes", "/admin/reasignarAgentes"})
public class AdminReasignarAgenteServlet extends HttpServlet {

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

        adminTicketService.asegurarTablaAsignacion();

        String ticketSeleccionado = request.getParameter("idTicket");
        Integer idTicket = null;
        if (ticketSeleccionado != null && !ticketSeleccionado.isBlank()) {
            try {
                idTicket = Integer.parseInt(ticketSeleccionado);
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        request.setAttribute("tickets", adminTicketService.listarTicketsParaReasignar());
        request.setAttribute("agentes", adminTicketService.listarAgentes(idTicket));
        request.setAttribute("ticketSeleccionado", ticketSeleccionado);

        request.getRequestDispatcher("/ReasignarAgentes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        adminTicketService.asegurarTablaAsignacion();

        String idTicket = request.getParameter("idTicket");
        String idAgente = request.getParameter("idAgente");

        if (idTicket != null && !idTicket.isBlank() && idAgente != null && !idAgente.isBlank()) {
            adminTicketService.reasignarTicket(Integer.parseInt(idTicket), Integer.parseInt(idAgente));
        }

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script>");
        out.println("  Swal.fire({");
        out.println("    title: '¡Reasignación Exitosa!',");
        out.println("    text: 'Se guardó el cambio de agente correctamente.',");
        out.println("    icon: 'success',");
        out.println("    timer: 2000,");
        out.println("    showConfirmButton: false,");
        out.println("    timerProgressBar: true");
        out.println("  }).then(() => {");
        out.println("    window.location.href = '" + request.getContextPath() + "/admin/tickets';");
        out.println("  });");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

}
