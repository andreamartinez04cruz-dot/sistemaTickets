package co.edu.sena.mesaayuda.mapper;

import co.edu.sena.mesaayuda.dto.ComentarioDTO;
import co.edu.sena.mesaayuda.modelo.Comentario;
import co.edu.sena.mesaayuda.modelo.Usuario;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class ComentarioMapper {

    private static final DateTimeFormatter FORMATO_FECHA
            = DateTimeFormatter.ofPattern("MMM dd, hh:mm a", new Locale("es", "ES"));

    public static ComentarioDTO toDTO(Comentario comentario, int idTicket) {
        if (comentario == null) {
            return null;
        }

        ComentarioDTO dto = new ComentarioDTO();
        dto.setId(comentario.getId());
        dto.setIdTicket(idTicket);
        dto.setTexto(comentario.getTexto());

        if (comentario.getUsuario() != null) {
            dto.setIdUsuario(comentario.getUsuario().getId());
            dto.setNombreUsuario(comentario.getUsuario().getNombre());
        }

        if (comentario.getFecha() != null) {
            dto.setFechaFormateada(comentario.getFecha().format(FORMATO_FECHA));
        }

        return dto;
    }

    public static Comentario toEntity(ComentarioDTO dto) {
        if (dto == null) {
            return null;
        }

        Usuario usuario = new Usuario();
        usuario.setId(dto.getIdUsuario());

        Comentario comentario = new Comentario();
        comentario.setId(dto.getId());
        comentario.setUsuario(usuario);
        comentario.setTexto(dto.getTexto());

        return comentario;
    }
}
