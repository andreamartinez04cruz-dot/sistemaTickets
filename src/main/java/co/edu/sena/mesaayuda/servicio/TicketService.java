package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.dto.ComentarioDTO;
import co.edu.sena.mesaayuda.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesaayuda.dto.TicketDTO;
import co.edu.sena.mesaayuda.modelo.Categoria;
import co.edu.sena.mesaayuda.modelo.Prioridad;
import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import java.util.List;

public interface TicketService {

    // Definir el servicio para registrar  Doris
    Ticket registrarTicket(Ticket ticket);
    
     // Método para el registro mediante DTO funcionario
    void RegistrarTicket(
            TicketDTO dto,
            Categoria categoria,
            Prioridad prioridad,
            Usuario solicitante
    );
    
    //lISTA DE CATEGORIAS
    List<Categoria> ListarCategorias();
    
    //Historial de funcinario
    List<HistorialFuncionarioDTO> listarTicketsPorSolicitante(int solicitanteId);
    
    //Comentario
    void agregarComentario(ComentarioDTO comentarioDTO);
    List<ComentarioDTO> listarComentarios(int idTicket);
    
    // obtener id de ticket
    TicketDTO obtenerPorId(int idTicket);

}
