package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.dto.AdminTicketDTO;
import java.util.List;

public interface AdminTicketRepository {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();
}
