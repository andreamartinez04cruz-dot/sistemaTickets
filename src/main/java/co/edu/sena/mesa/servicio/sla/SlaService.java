package co.edu.sena.mesa.servicio.sla;

import co.edu.sena.mesa.servicio.sla.CalcularPrioridad;
import java.util.HashMap;
import java.util.Map;

public class SlaService {

    // El Map es el "almacén" donde guardamos las estrategias
    private final Map<String, CalcularPrioridad> estrategias = new HashMap<>();

    // 1. Método para registrar: sirve para llenar el mapa en el AppContextListener
    public void registrarEstrategia(String clave, CalcularPrioridad estrategia) {
        estrategias.put(clave, estrategia);
    }

    // 2. Método para obtener: es el que usarás en tu lógica de negocio
    public CalcularPrioridad obtenerEstrategia(String clave) {
        CalcularPrioridad estrategia = estrategias.get(clave);
        if (estrategia == null) {
            throw new IllegalArgumentException("No hay estrategia registrada para: " + clave);
        }
        return estrategia;
    }
}
