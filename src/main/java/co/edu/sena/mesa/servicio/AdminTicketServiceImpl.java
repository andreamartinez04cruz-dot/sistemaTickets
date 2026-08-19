package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import co.edu.sena.mesa.repositorio.AdminTicketRepository;
import java.util.List;

public class AdminTicketServiceImpl implements AdminTicketService {

    private final AdminTicketRepository adminTicketRepository;

    public AdminTicketServiceImpl(AdminTicketRepository adminTicketRepository) {
        this.adminTicketRepository = adminTicketRepository;
    }

    @Override
    public List<AdminTicketDTO> listarTicketsAprendiz() {
        return adminTicketRepository.listarTicketsAprendiz();
    }

    @Override
    public List<AdminTicketDTO> listarTicketsFuncionario() {
        return adminTicketRepository.listarTicketsFuncionario();
    }
}
