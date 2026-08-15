package co.edu.sena.mesaayuda.servicio.sla;

public class SlaFactory {

    public static CalcularPrioridad obtenerEstrategia(int idCategoria) {
      

        // Evaluamos según los nombres exactos de tus categorías
        switch (idCategoria) {
            case 1: // Supongamos que 1 es Redes y Conectividad
            case 2: // Supongamos que 2 es Acceso a Sistemas
                return new SlaCriticaStrategy();

            case 3:
            case 4:
                return new SlaAltaStrategy();

            case 5:
            case 6:
                return new SlaMediaStrategy();

            default:
                return new SlaBajaStrategy(); // Por defecto para las demás // Prioridad baja
        }
    }
}
