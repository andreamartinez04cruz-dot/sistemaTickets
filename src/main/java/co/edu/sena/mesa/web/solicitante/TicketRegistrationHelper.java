package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaService;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;
import jakarta.servlet.http.HttpServletRequest;

public final class TicketRegistrationHelper {

    private TicketRegistrationHelper() {
    }

    public static TicketData preparar(
            HttpServletRequest request,
            Usuario solicitante,
            String categoriaNombre,
            SlaService slaService) {
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        CalcularPrioridad estrategia = slaService.obtenerEstrategia(String.valueOf(idCategoria));
        int idPrioridad = estrategia.obtenerIdPrioridad();
        String prioridadNombre = estrategia.determinarPrioridad();

        TicketDTO dto = new TicketDTO();
        dto.setTitulo(request.getParameter("titulo"));
        dto.setDescripcion(request.getParameter("descripcion"));
        dto.setIdCategoria(idCategoria);
        dto.setIdSolicitante(solicitante.getId());
        dto.setIdPrioridad(idPrioridad);
        dto.setPrioridadNombre(prioridadNombre);
        dto.setPrograma(request.getParameter("programa"));
        dto.setNumeroPrograma(request.getParameter("numeroPrograma"));
        dto.setInstructor(request.getParameter("instructor"));
        dto.setJornada(request.getParameter("jornada"));

        Categoria categoria = new Categoria();
        categoria.setId(idCategoria);
        categoria.setNombre(categoriaNombre);
        return new TicketData(dto, categoria);
    }

    public static TicketDTO registrar(
            HttpServletRequest request,
            Usuario solicitante,
            String categoriaNombre,
            SlaService slaService,
            SolicitanteTicketService service) {
        TicketData datos = preparar(request, solicitante, categoriaNombre, slaService);
        service.RegistrarTicket(datos.getDto(), datos.getCategoria(), solicitante, slaService);
        return datos.getDto();
    }

    public static final class TicketData {
        private final TicketDTO dto;
        private final Categoria categoria;

        private TicketData(TicketDTO dto, Categoria categoria) {
            this.dto = dto;
            this.categoria = categoria;
        }

        public TicketDTO getDto() {
            return dto;
        }

        public Categoria getCategoria() {
            return categoria;
        }
    }
}
