package co.edu.sena.mesa.modelo.estado;

import java.util.Locale;
import java.util.Map;
import java.util.function.Supplier;

public final class EstadoTicketFactory {

    private static final Map<String, Supplier<EstadoTicket>> ESTADOS = Map.of(
            "NUEVO", EstadoNuevo::new,
            "ASIGNADO", EstadoAsignado::new,
            "EN_PROCESO", EstadoEnProceso::new,
            "RESUELTO", EstadoResuelto::new,
            "CERRADO", EstadoCerrado::new,
            "CANCELADO", EstadoCancelado::new
    );

    private EstadoTicketFactory() {
    }

    public static EstadoTicket crear(String nombreEstado) {
        String clave = nombreEstado == null
                ? ""
                : nombreEstado.trim().toUpperCase(Locale.ROOT).replace(' ', '_');
        Supplier<EstadoTicket> constructor = ESTADOS.get(clave);
        if (constructor == null) {
            throw new IllegalArgumentException("Estado de ticket no reconocido: " + nombreEstado);
        }
        return constructor.get();
    }
}
