package co.edu.sena.mesa.servicio.sla;


public class SlaBajaStrategy implements CalcularPrioridad{
    @Override
    public String determinarPrioridad() {
        return "BAJA";
    }

    @Override
    public int calcularHorasMaximas() {
        return 72; // 3 días de SLA
    }
    
}
