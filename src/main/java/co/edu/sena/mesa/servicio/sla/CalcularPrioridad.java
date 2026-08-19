
package co.edu.sena.mesa.servicio.sla;

public interface CalcularPrioridad {
    // Retorna la prioridad calculada (ej. "BAJA", "MEDIA", "ALTA", "CRITICA")
    String determinarPrioridad();
    
    // Retorna el tiempo máximo de atención en horas según el SLA
    int calcularHorasMaximas();
    
}
