package co.edu.sena.mesaayuda.servicio.sla;

public class SlaAltaStrategy implements CalcularPrioridad {
    @Override
    public String determinarPrioridad() {
        return "ALTA";
    }

    @Override
    public int calcularHorasMaximas() {
        return 8; // 8 horas
    }
}