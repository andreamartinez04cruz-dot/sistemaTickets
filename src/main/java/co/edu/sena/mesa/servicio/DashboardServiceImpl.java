package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesa.repositorio.DashboardRepository;

public class DashboardServiceImpl implements DashboardService {

    private final DashboardRepository dashboardRepository;

    public DashboardServiceImpl(DashboardRepository dashboardRepository) {
        this.dashboardRepository = dashboardRepository;
    }

    @Override
    public DashboardEstadisticasDTO obtenerEstadisticasAdministrador() {
        DashboardEstadisticasDTO estadisticas = dashboardRepository.obtenerEstadisticasAdministrador();
        estadisticas.setTicketsPorEstado(dashboardRepository.listarTicketsPorEstado());
        estadisticas.setTicketsPorAgente(dashboardRepository.listarTicketsPorAgente());
        return estadisticas;
    }
}
