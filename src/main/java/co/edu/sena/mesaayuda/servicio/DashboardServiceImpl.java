package co.edu.sena.mesaayuda.servicio;

import co.edu.sena.mesaayuda.dto.DashboardEstadisticasDTO;
import co.edu.sena.mesaayuda.repositorio.DashboardRepository;

public class DashboardServiceImpl implements DashboardService {

    private final DashboardRepository dashboardRepository;

    public DashboardServiceImpl(DashboardRepository dashboardRepository) {
        this.dashboardRepository = dashboardRepository;
    }

    @Override
    public DashboardEstadisticasDTO obtenerEstadisticasAdministrador() {
        return dashboardRepository.obtenerEstadisticasAdministrador();
    }
}
