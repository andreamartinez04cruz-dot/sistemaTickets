
package co.edu.sena.mesa.servicio.sla;

public interface CalcularPrioridad {
    // Retorna la prioridad calculada 
    String determinarPrioridad();
    
    // Retorna el tiempo máximo de atención en horas según el SLA
    int calcularHorasMaximas();
    int obtenerIdPrioridad();
    
}
