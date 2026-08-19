package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.dto.AdminTicketDTO;
import java.util.List;

public interface AdminTicketService {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();
}
