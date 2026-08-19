package co.edu.sena.mesaayuda.servicio.asignacion;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class AsignacionRoundRobinStrategy implements AsignacionStrategy {

    private final AtomicInteger siguienteAgente = new AtomicInteger();

    @Override
    public Usuario asignar(Ticket ticket, List<Usuario> agentes) {
        if (agentes == null || agentes.isEmpty()) {
            return null;
        }

        int indice = Math.floorMod(siguienteAgente.getAndIncrement(), agentes.size());
        return agentes.get(indice);
    }
}