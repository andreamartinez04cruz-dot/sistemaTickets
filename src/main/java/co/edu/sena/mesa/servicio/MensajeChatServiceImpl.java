package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.ChatDTO;
import co.edu.sena.mesa.mapper.ChatMapper;
import co.edu.sena.mesa.modelo.MensajeChat;
import co.edu.sena.mesa.repositorio.MensajeChatRepository;
import java.util.List;

public class MensajeChatServiceImpl implements MensajeChatService {

    private final MensajeChatRepository mensajeRepo;

    public MensajeChatServiceImpl(MensajeChatRepository mensajeRepo) {
        this.mensajeRepo = mensajeRepo;
    }

    @Override
    public boolean RegistrarYEnviarMensaje(MensajeChat mensaje) {
        // Lógica de negocio / validaciones previas
        if (mensaje.getMensaje() == null || mensaje.getMensaje().trim().isEmpty()) {
            return false;
        }
        return mensajeRepo.NuevoMensaje(mensaje);
    }

    @Override
    public List<ChatDTO> ObtenerHistorialDeChats(int idTicket) {
        List<MensajeChat> lista = mensajeRepo.ListarMensaje(idTicket);
        // Mapeamos de entidad a DTO usando el Mapper
        return lista.stream().map(ChatMapper::toDTO).toList();

    }

}
