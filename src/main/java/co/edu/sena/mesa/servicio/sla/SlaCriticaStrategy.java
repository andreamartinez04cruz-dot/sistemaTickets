package co.edu.sena.mesa.servicio.sla;

public class SlaCriticaStrategy implements CalcularPrioridad {
    @Override
    public String determinarPrioridad() {
        return "CRITICA";
    }

    @Override
    public int calcularHorasMaximas() {
        return 4; // 4 horas
    }
}