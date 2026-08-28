package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.util.RegistroErrores;

import java.util.Arrays;
import java.util.List;

/**
 * Implementación del Notificador que reenvía el mismo mensaje a varios canales,
 * por ejemplo aplicación y correo.
 */
public class NotificadorCompuesto implements Notificador {

    private final List<Notificador> notificadores;

    public NotificadorCompuesto(Notificador... notificadores) {
        this.notificadores = Arrays.asList(notificadores);
    }

    @Override
    public void enviar(String destinatario, String asunto, String mensaje) {

        for (Notificador notificador : notificadores) {
            try {
                notificador.enviar(
                        destinatario,
                        asunto,
                        mensaje);
            } catch (Exception e) {
                // Si un canal falla, los demás deben seguir notificando
                RegistroErrores.registrar(
                        "Error notificando por "
                        + notificador.getClass().getSimpleName(),
                        e);
            }
        }
    }
}
