package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.util.List;

public interface AdminTicketService {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();
}
