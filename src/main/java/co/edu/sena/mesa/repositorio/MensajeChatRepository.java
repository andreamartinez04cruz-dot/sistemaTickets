package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.modelo.MensajeChat;
import java.util.List;

public interface MensajeChatRepository {

    public boolean NuevoMensaje(MensajeChat mensajeChat);

    public List<MensajeChat> ListarMensaje(int idTicket);
}
