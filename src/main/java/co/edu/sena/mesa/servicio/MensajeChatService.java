package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.ChatDTO;
import co.edu.sena.mesa.modelo.MensajeChat;
import java.util.List;

public interface MensajeChatService {

    public boolean RegistrarYEnviarMensaje(MensajeChat mensaje);

    public List<ChatDTO> ObtenerHistorialDeChats(int idTicket);

}
