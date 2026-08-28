package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.ChatDTO;
import co.edu.sena.mesa.modelo.MensajeChat;

public class ChatMapper {

    public static ChatDTO toDTO(MensajeChat entidad) {
        if (entidad == null) {
            return null;
        }
        ChatDTO dto = new ChatDTO();
        dto.setId(entidad.getId());
        dto.setIdTicket(entidad.getTicket().getId());
        if (entidad.getUsuario() != null) {
            dto.setIdUsuario(entidad.getUsuario().getId());
            dto.setNombreUsuario(entidad.getUsuario().getNombre());

            // Si la lista de roles no está vacía, tomamos el rol principal o los evaluamos
            if (entidad.getUsuario().getRoles() != null && !entidad.getUsuario().getRoles().isEmpty()) {
                // Ejemplo: Asignamos el nombre del primer rol (ej. "APRENDIZ" o "AGENTE")
                dto.setRolUsuario(entidad.getUsuario().getRoles().get(0).getTiporol());
            }
        }
        dto.setMensaje(entidad.getMensaje());
        dto.setFechaEnvio(entidad.getFechaEnvio().toString());
        return dto;
    }

}
