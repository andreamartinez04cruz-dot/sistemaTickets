package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.util.RegistroErrores;

import java.util.Arrays;
import java.util.List;

/**
 * Implementacion del Notificador que reenvia el mismo mensaje a varios
 * canales (aplicacion y correo), de modo que ambos reciban lo mismo.
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
                notificador.enviar(destinatario, asunto, mensaje);
            } catch (Exception e) {
                // Si un canal falla, los demas deben seguir notificando
                RegistroErrores.registrar(
                    "Error notificando por " + notificador.getClass().getSimpleName(), e);
            }
        }
    }
}
