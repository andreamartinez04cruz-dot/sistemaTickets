package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.ComentarioDTO;
import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.mapper.ComentarioMapper;
import co.edu.sena.mesa.mapper.TicketMapper;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Comentario;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.repositorio.TicketRepository;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TicketServiceImpl implements TicketService {

    // Servicio de Doris
    private final TicketRepository ticketRepository;

    public TicketServiceImpl(TicketRepository ticketRepository) {
        this.ticketRepository = ticketRepository;
    }

    @Override
    public Ticket registrarTicket(Ticket ticket) {
        return ticketRepository.guardar(ticket);
    }

    // ------------------------------------------------
    // Servicio para registro con DTO - Andrea
    // ------------------------------------------------private final TicketMapper ticketMapper = new TicketMapper();
    private final TicketMapper ticketMapper = new TicketMapper();

    public void RegistrarTicket(
            TicketDTO dto,
            Categoria categoria,
            Prioridad prioridad,
            Usuario solicitante) {

        Ticket ticket = ticketMapper.toEntity(
                dto,
                categoria,
                prioridad,
                solicitante
        );

        ticketRepository.TicketFuncionario(
                ticket,
                solicitante.getId()
        );
    }

    //Lista de categorias
    public List<Categoria> ListarCategorias() {
        return ticketRepository.listarCategorias();

    }

    //Historial solicitante
    @Override
    public List<HistorialFuncionarioDTO> listarTicketsPorSolicitante(int solicitanteId) {
        List<Ticket> tickets = ticketRepository.buscarSolicitantePorId(solicitanteId);
        List<HistorialFuncionarioDTO> dtos = new ArrayList<>();

        for (Ticket ticket : tickets) {
            dtos.add(TicketMapper.toDTO(ticket));
        }

        return dtos;
    }

    //Comentario
    @Override
    public void agregarComentario(ComentarioDTO comentarioDTO) {
        // 1. Convertimos DTO a Entidad Comentario
        Comentario comentario = ComentarioMapper.toEntity(comentarioDTO);
        comentario.setFecha(LocalDateTime.now());

        // 2. Guardamos usando ticketRepository
        ticketRepository.guardar(comentario, comentarioDTO.getIdTicket());
    }

    @Override
    public List<ComentarioDTO> listarComentarios(int idTicket) {
        List<Comentario> comentarios = ticketRepository.obtenerComentariosPorTicket(idTicket);
        List<ComentarioDTO> dtos = new ArrayList<>();

        for (Comentario c : comentarios) {
            dtos.add(ComentarioMapper.toDTO(c, idTicket));
        }

        return dtos;
    }

    @Override
    public TicketDTO obtenerPorId(int idTicket) {
        // 1. Buscas el Ticket en la BD desde tu repositorio
        Ticket ticket = ticketRepository.obtenerPorId(idTicket);

        if (ticket == null) {
            return null;
        }

        // 2. Mapeas el objeto Ticket a TicketDTO para enviar a la vista
        return TicketMapper.ToDTO(ticket);
    }
}
