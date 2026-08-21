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
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.modelo.estado.EstadoTicketFactory;
import co.edu.sena.mesa.repositorio.TicketRepository;
import co.edu.sena.mesa.servicio.asignacion.AsignacionService;
import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import co.edu.sena.mesa.servicio.sla.SlaService;
import co.edu.sena.mesa.servicio.solicitante.SolicitanteTicketService;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Set;
import java.util.List;

public class TicketServiceImpl implements TicketService, SolicitanteTicketService {

    private static final Set<String> ESTADOS_NO_CANCELABLES_POR_SOLICITANTE = Set.of(
            "RESUELTO", "CERRADO", "CANCELADO");

    // Servicio de Doris
    private final TicketRepository ticketRepository;
    private final AsignacionService asignacionService;

    public TicketServiceImpl(
            TicketRepository ticketRepository,
            AsignacionService asignacionService) {
        this.ticketRepository = ticketRepository;
        this.asignacionService = asignacionService;
    }

    @Override
    public Ticket registrarTicket(Ticket ticket) {
        Ticket ticketGuardado = ticketRepository.guardar(ticket);
        asignacionService.asignarTicket(ticketGuardado);
        return ticketGuardado;
    }

    // ------------------------------------------------
    // Servicio para registro con DTO - Andrea
    // ------------------------------------------------private final TicketMapper ticketMapper = new TicketMapper();
    private final TicketMapper ticketMapper = new TicketMapper();

    public void RegistrarTicket(
            TicketDTO dto,
            Categoria categoria,
            Usuario solicitante,
            SlaService slaService){

        // 1. Aplicar el Patrón Strategy usando el SlaService (Cero if/else)
        CalcularPrioridad estrategiaSla = slaService.obtenerEstrategia(String.valueOf(categoria.getId()));
        String prioridadCalculada = estrategiaSla.determinarPrioridad();
        int idPrioridad = estrategiaSla.obtenerIdPrioridad();

        // 2. Completar los datos faltantes en el DTO
        dto.setIdPrioridad(idPrioridad);
        dto.setPrioridadNombre(prioridadCalculada);

        // 3. Crear la entidad Prioridad con los datos calculados por la estrategia
        Prioridad prioridad = new Prioridad();
        prioridad.setId(idPrioridad);
        prioridad.setNombre(prioridadCalculada);

        // 4. Mapear a la entidad de base de datos
        Ticket ticket = ticketMapper.toEntity(dto, categoria, prioridad, solicitante);

        // 5. Guardar mediante el repositorio
        ticketRepository.TicketFuncionario(ticket, solicitante.getId());
        asignacionService.asignarTicket(ticket);
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

    //Mostrar la prioridad del ticket

    @Override
    public boolean cancelarTicketSolicitante(int idTicket, int idSolicitante) {
        String estadoActual = ticketRepository.obtenerEstadoActual(idTicket, idSolicitante);
        if (estadoActual == null) {
            return false;
        }
        if (ESTADOS_NO_CANCELABLES_POR_SOLICITANTE.contains(estadoActual.toUpperCase())) {
            return false;
        }
        EstadoTicket estadoCancelado = EstadoTicketFactory.crear(estadoActual).cancelar();
        return ticketRepository.actualizarEstado(
                idTicket,
                idSolicitante,
                estadoCancelado.getNombreEstado());
    }
}
