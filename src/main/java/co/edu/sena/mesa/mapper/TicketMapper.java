package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.ComentarioDTO;
import co.edu.sena.mesa.dto.HistorialFuncionarioDTO;
import co.edu.sena.mesa.dto.TicketDTO;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Prioridad;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.modelo.estado.EstadoNuevo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

public class TicketMapper {

    // =========================================================
    // DTO -> ENTIDAD
    // =========================================================
    public Ticket toEntity(
            TicketDTO dto,
            Categoria categoria,
            Prioridad prioridad,
            Usuario solicitante) {

        Ticket ticket = new Ticket();

        ticket.setTitulo(dto.getTitulo());
        ticket.setDescripcion(dto.getDescripcion());

        ticket.setCategoria(categoria);
        ticket.setPrioridad(prioridad);
        ticket.setSolicitante(solicitante);

        // Estado inicial
        ticket.setEsatdo(new EstadoNuevo());

        // Fecha de creación
        ticket.setFechaCreacion(LocalDateTime.now());

        ticket.setPrograma(dto.getPrograma());
        ticket.setNumeroPrograma(dto.getNumeroPrograma());
        ticket.setInstructor(dto.getInstructor());
        ticket.setJornada(dto.getJornada());

        return ticket;
    }

    // =========================================================
    // FORMATO DE FECHA
    // =========================================================
    private static final DateTimeFormatter FORMATO_FECHA
            = DateTimeFormatter.ofPattern(
                    "dd/MM/yyyy hh:mm a",
                    new Locale("es", "CO")
            );

    // =========================================================
    // TICKET -> HISTORIAL FUNCIONARIO
    // =========================================================
    public static HistorialFuncionarioDTO toDTO(Ticket ticket) {

        if (ticket == null) {
            return null;
        }

        HistorialFuncionarioDTO dto
                = new HistorialFuncionarioDTO();

        dto.setId(ticket.getId());

        dto.setTitulo(
                ticket.getTitulo()
        );

        dto.setDescripcion(
                ticket.getDescripcion()
        );

        // -------------------------
        // CATEGORIA
        // -------------------------
        dto.setCategoriaNombre(
                ticket.getCategoria() != null
                ? ticket.getCategoria().getNombre()
                : "Sin Categoría"
        );

        // -------------------------
        // PRIORIDAD
        // -------------------------
        dto.setPrioridadNombre(
                ticket.getPrioridad() != null
                ? ticket.getPrioridad().getNombre()
                : "Sin Prioridad"
        );
        dto.setHorasAtencion(calcularHorasAtencion(ticket.getPrioridad()));

        // -------------------------
        // ESTADO
        // -------------------------
        dto.setEstadoNombre(
                ticket.getEstadoNombre() != null
                ? ticket.getEstadoNombre()
                : "SIN ESTADO"
        );

        // -------------------------
        // FECHA
        // -------------------------
        dto.setFechaCreacion(
                ticket.getFechaCreacion() != null
                ? ticket.getFechaCreacion().format(FORMATO_FECHA)
                : ""
        );

        return dto;
    }

        private static int calcularHorasAtencion(Prioridad prioridad) {
                if (prioridad == null || prioridad.getNombre() == null) {
                        return 0;
                }

                String nombre = prioridad.getNombre().toUpperCase(Locale.ROOT);
                if (nombre.contains("CRIT")) {
                        return 4;
                }
                if (nombre.contains("ALTA")) {
                        return 8;
                }
                if (nombre.contains("MEDIA")) {
                        return 24;
                }
                if (nombre.contains("BAJA")) {
                        return 72;
        }
                return 0;
        }

    // =========================================================
    // TICKET -> TICKET DTO
    // =========================================================
    public static TicketDTO ToDTO(Ticket ticket) {

        return toDTO(ticket, null);
    }

    // =========================================================
    // TICKET + COMENTARIOS -> TICKET DTO
    // =========================================================
    public static TicketDTO toDTO(
            Ticket ticket,
            List<ComentarioDTO> comentarios) {

        if (ticket == null) {
            return null;
        }

        TicketDTO dto = new TicketDTO();

        // =====================================================
        // DATOS BÁSICOS
        // =====================================================
        dto.setId(
                ticket.getId()
        );

        dto.setTitulo(
                ticket.getTitulo()
        );

        dto.setDescripcion(
                ticket.getDescripcion()
        );

        dto.setPrograma(ticket.getPrograma());
        dto.setNumeroPrograma(ticket.getNumeroPrograma());
        dto.setInstructor(ticket.getInstructor());
        dto.setJornada(ticket.getJornada());

        // =====================================================
        // SOLICITANTE
        // =====================================================
        if (ticket.getSolicitante() != null) {

            Usuario usuario
                    = ticket.getSolicitante();

            // ID
            dto.setIdSolicitante(
                    usuario.getId()
            );

            // NOMBRE
            dto.setSolicitanteNombre(
                    usuario.getNombre() != null
                    ? usuario.getNombre()
                    : "Sin nombre"
            );

        } else {

            dto.setSolicitanteNombre(
                    "Sin solicitante"
            );
        }

        // =====================================================
        // CATEGORIA
        // =====================================================
        if (ticket.getCategoria() != null) {

            Categoria categoria
                    = ticket.getCategoria();

            // ID
            dto.setIdCategoria(
                    categoria.getId()
            );

            // NOMBRE
            dto.setCategoriaNombre(
                    categoria.getNombre() != null
                    ? categoria.getNombre()
                    : "Sin categoría"
            );

        } else {

            dto.setCategoriaNombre(
                    "Sin categoría"
            );
        }

        // =====================================================
        // PRIORIDAD
        // =====================================================
        if (ticket.getPrioridad() != null) {

            Prioridad prioridad
                    = ticket.getPrioridad();

            // ID
            dto.setIdPrioridad(
                    prioridad.getId()
            );

            // NOMBRE
            dto.setPrioridadNombre(
                    prioridad.getNombre() != null
                    ? prioridad.getNombre()
                    : "Sin prioridad"
            );

        } else {

            dto.setPrioridadNombre(
                    "Sin prioridad"
            );
        }

        // =====================================================
        // ESTADO
        // =====================================================
        dto.setEstado(
                ticket.getEstadoNombre() != null
                ? ticket.getEstadoNombre()
                : "SIN ESTADO"
        );

        // =====================================================
        // FECHA DE CREACION
        // =====================================================
        if (ticket.getFechaCreacion() != null) {

            dto.setFechaCreacion(
                    ticket.getFechaCreacion()
                            .format(FORMATO_FECHA)
            );

        } else {

            dto.setFechaCreacion("");
        }

        // =====================================================
        // COMENTARIOS
        // =====================================================
        dto.setComentarios(
                comentarios
        );

        return dto;
    }
}
