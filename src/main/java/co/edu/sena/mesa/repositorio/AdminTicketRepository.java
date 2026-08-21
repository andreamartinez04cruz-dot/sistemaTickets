package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.util.List;
import java.util.Map;

public interface AdminTicketRepository {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();

    void asegurarTablaAsignacion();

    void reasignarTicket(int idTicket, int idAgente);

    List<Map<String, Object>> listarTicketsParaReasignar();

    List<Map<String, Object>> listarAgentes(Integer idTicketExcluir);

    List<Map<String, Object>> listarGestores();

    void cancelarTicket(int idTicket);

    String obtenerEstadoActual(int idTicket);

    boolean actualizarEstado(int idTicket, String estado);

    String obtenerCorreoSolicitante(int idTicket);

    void restablecerEstadosTicketsPrueba();
}
