package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import java.util.List;
import java.util.Map;

public interface DashboardRepository {

    DashboardEstadisticasDTO obtenerEstadisticasAdministrador();

    List<Map<String, Object>> listarTicketsPorEstado();

    List<Map<String, Object>> listarTicketsPorAgente();
}
