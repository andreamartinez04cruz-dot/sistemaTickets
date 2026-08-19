package co.edu.sena.mesa.servicio.asignacion;

import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import java.util.List;


public interface AsignacionStrategy {

	Usuario asignar(Ticket ticket, List<Usuario> agentes);
}
