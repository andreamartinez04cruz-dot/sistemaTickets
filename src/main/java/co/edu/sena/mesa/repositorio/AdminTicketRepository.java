package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.util.List;

public interface AdminTicketRepository {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();
}
