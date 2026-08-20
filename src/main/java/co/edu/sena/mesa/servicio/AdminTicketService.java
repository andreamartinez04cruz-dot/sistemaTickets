package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.util.List;
import java.util.Map;

public interface AdminTicketService {

    List<AdminTicketDTO> listarTicketsAprendiz();

    List<AdminTicketDTO> listarTicketsFuncionario();

    void asegurarTablaAsignacion();

    void reasignarTicket(int idTicket, int idAgente);

    List<Map<String, Object>> listarTicketsParaReasignar();

    List<Map<String, Object>> listarAgentes(Integer idTicketExcluir);

    List<Map<String, Object>> listarGestores();

    void cancelarTicket(int idTicket);

    String obtenerCorreoSolicitante(int idTicket);

    void restablecerEstadosTicketsPrueba();
}
