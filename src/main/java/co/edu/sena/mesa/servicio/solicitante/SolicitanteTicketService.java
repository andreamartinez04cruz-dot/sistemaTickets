package co.edu.sena.mesa.servicio.solicitante;

import co.edu.sena.mesa.dto.ComentarioDTO;
import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.servicio.sla.SlaService;
import java.util.List;

public interface SolicitanteTicketService {

    Ticket registrarTicket(Ticket ticket);

    void RegistrarTicket(
            TicketDTO dto,
            Categoria categoria,
            Usuario solicitante,
            SlaService slaService
    );

    List<Categoria> ListarCategorias();

    List<HistorialFuncionarioDTO> listarTicketsPorSolicitante(int solicitanteId);

    void agregarComentario(ComentarioDTO comentarioDTO);

    List<ComentarioDTO> listarComentarios(int idTicket);

    TicketDTO obtenerPorId(int idTicket);

    boolean cancelarTicketSolicitante(int idTicket, int idSolicitante);
}
