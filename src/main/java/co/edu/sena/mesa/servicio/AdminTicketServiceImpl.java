package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import co.edu.sena.mesa.repositorio.AdminTicketRepository;
import co.edu.sena.mesa.modelo.estado.EstadoTicketFactory;
import java.util.List;
import java.util.Map;

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

    @Override
    public void asegurarTablaAsignacion() {
        adminTicketRepository.asegurarTablaAsignacion();
    }

    @Override
    public void reasignarTicket(int idTicket, int idAgente) {
        adminTicketRepository.reasignarTicket(idTicket, idAgente);
    }

    @Override
    public List<Map<String, Object>> listarTicketsParaReasignar() {
        return adminTicketRepository.listarTicketsParaReasignar();
    }

    @Override
    public List<Map<String, Object>> listarAgentes(Integer idTicketExcluir) {
        return adminTicketRepository.listarAgentes(idTicketExcluir);
    }

    @Override
    public List<Map<String, Object>> listarGestores() {
        return adminTicketRepository.listarGestores();
    }

    @Override
    public void cancelarTicket(int idTicket) {
        String estadoActual = adminTicketRepository.obtenerEstadoActual(idTicket);
        if (estadoActual == null) {
            return;
        }
        String estadoCancelado = EstadoTicketFactory.crear(estadoActual)
                .cancelar()
                .getNombreEstado();
        adminTicketRepository.actualizarEstado(idTicket, estadoCancelado);
    }

    @Override
    public String obtenerCorreoSolicitante(int idTicket) {
        return adminTicketRepository.obtenerCorreoSolicitante(idTicket);
    }

    @Override
    public void restablecerEstadosTicketsPrueba() {
        adminTicketRepository.restablecerEstadosTicketsPrueba();
    }
}
