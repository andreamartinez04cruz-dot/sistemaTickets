package co.edu.sena.mesa.servicio.sla;

public class SlaMediaStrategy implements CalcularPrioridad {
    @Override
    public String determinarPrioridad() {
        return "MEDIA";
    }

    @Override
    public int calcularHorasMaximas() {
        return 24; // 1 día
    }
    public int obtenerIdPrioridad () {
        return 2;
    }
}