package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.modelo.Usuario;
import java.util.List;

public interface AsignacionRepository {

    List<Usuario> listarAgentesDisponibles();

    void asignarTicket(int idTicket, int idAgente, String estado);
}
