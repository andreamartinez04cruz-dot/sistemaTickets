package co.edu.sena.mesa.web.system;

import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.servicio.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet({"/check-categories", "/check_categories.jsp"})
public class CategoriasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TicketService ticketService = (TicketService) getServletContext()
                .getAttribute("ticketService");
        List<Categoria> categorias = ticketService != null
                ? ticketService.ListarCategorias()
                : Collections.emptyList();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/check_categories_view.jsp").forward(request, response);
    }
}
