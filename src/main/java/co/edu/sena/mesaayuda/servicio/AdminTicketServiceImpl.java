package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.dto.AdminTicketDTO;
import co.edu.sena.mesaayuda.repositorio.AdminTicketRepository;
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
