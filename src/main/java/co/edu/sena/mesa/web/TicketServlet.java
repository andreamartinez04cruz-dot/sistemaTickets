package co.edu.sena.mesa.web;

import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.TicketService;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaFactory;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("historial".equalsIgnoreCase(action)) {
            List<HistorialFuncionarioDTO> tickets = ticketService.listarTicketsPorSolicitante(usuario.getId());
            request.setAttribute("tickets", tickets);
            request.getRequestDispatcher("/MisSolicitudes.jsp").forward(request, response);
            return;
        }

        List<Categoria> categorias = ticketService.ListarCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/RegistroTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Captura de datos del formulario
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
            List<Categoria> categorias = ticketService.ListarCategorias();
            if (categorias != null) {
                for (Categoria cat : categorias) {
                    if (cat.getId() == idCategoria) {
                        categoriaNombre = cat.getNombre();
                        break;
                    }
                }
            }
        }

        // 2. APLICACIÓN DEL PATRÓN STRATEGY + FACTORY
        CalcularPrioridad estrategiaSla = SlaFactory.obtenerEstrategia(idCategoria);
        String prioridadCalculada = estrategiaSla.determinarPrioridad();

        // 3. Obtener el solicitante de la sesión
        HttpSession session = request.getSession();
        Usuario solicitante = (Usuario) session.getAttribute("usuario");

        if (solicitante == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        // 4. Traducir el texto de la prioridad a su ID numérico correspondiente para la BD
        int idPrioridad = 1; // Por defecto BAJA
        String prioridadUpper = prioridadCalculada != null ? prioridadCalculada.toUpperCase() : "";

        if (prioridadUpper.contains("MEDIA")) {
            idPrioridad = 2;
        } else if (prioridadUpper.contains("ALTA")) {
            idPrioridad = 3;
        } else if (prioridadUpper.contains("CRITICA") || prioridadUpper.contains("CRÍTICA")) {
            idPrioridad = 4;
        }

        // 5. Crear y poblar el DTO
        TicketDTO dto = new TicketDTO();
        dto.setTitulo(titulo);
        dto.setDescripcion(descripcion);
        dto.setIdCategoria(idCategoria);
        dto.setIdSolicitante(solicitante.getId());
        dto.setIdPrioridad(idPrioridad); // Guardamos el ID en el DTO por si se usa
        dto.setPrioridadNombre(prioridadCalculada);
        dto.setPrograma(programa);
        dto.setNumeroPrograma(numeroPrograma);
        dto.setInstructor(instructor);
        dto.setJornada(jornada);

        // 6. Preparar entidades para el servicio
        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        categoria.setNombre(categoriaNombre);

        // Creamos el objeto Prioridad con su ID y Nombre exactos para la base de datos
        Prioridad prioridad = new Prioridad();
        prioridad.setId(idPrioridad);       // <--- ¡Aquí está la solución al error de la llave foránea!
        prioridad.setNombre(prioridadCalculada);

        // 7. Registrar en el servicio (pasando los 4 argumentos exactos)
        ticketService.RegistrarTicket(dto, categoria, prioridad, solicitante);

        // 8. Respuesta al usuario (SweetAlert)
        String redirectUrl = request.getContextPath() + "/SolicitudFuncionario.jsp";
        
        // Comprobar rol de aprendiz usando rolUsuario en sesión o los roles de solicitante
        String rolUsuarioPost = (session != null) ? (String) session.getAttribute("rolUsuario") : "";
        if ((rolUsuarioPost == null || rolUsuarioPost.isEmpty()) && solicitante != null) {
            List<co.edu.sena.mesa.modelo.Rol> roles = solicitante.getRoles();
            if (roles != null) {
                for (co.edu.sena.mesa.modelo.Rol rol : roles) {
                    String nombreRol = (rol != null && rol.getTiporol() != null) ? rol.getTiporol().toUpperCase() : "";
                    if (nombreRol.contains("APRENDIZ")) {
                        rolUsuarioPost = "APRENDIZ";
                        break;
                    }
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
