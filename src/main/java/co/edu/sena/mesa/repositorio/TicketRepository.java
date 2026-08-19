package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Comentario;
import co.edu.sena.mesa.modelo.Ticket;
import java.util.List;

public interface TicketRepository {

    
    // Definir la operación para guardar el ticket  Doris
    Ticket guardar(Ticket ticket);
    //Insertar ticket de funcionario
    void TicketFuncionario(Ticket ticket, int idSolicitante);
    //Listar categorias para el formulario de ticcket
    List<Categoria> listarCategorias();
    //HISTORIAL del funcinario obtenidos por su id
    List<Ticket> buscarSolicitantePorId(int idUsuario);
    //COMKENTARIO
    void guardar(Comentario comentario, int idTicket);
    List<Comentario> obtenerComentariosPorTicket(int idTicket);
   
    //obtener id
    Ticket obtenerPorId(int idTicket);

}
