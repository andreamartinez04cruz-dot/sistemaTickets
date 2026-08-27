package co.edu.sena.mesa.servicio.notificacion;

import java.util.List;

// Notificador que reenvía el aviso a varias implementaciones (ej. aplicación + correo)
public class NotificadorCompuesto implements Notificador {

    private final List<Notificador> notificadores;

    public NotificadorCompuesto(List<Notificador> notificadores) {
        this.notificadores = notificadores;
    }

    @Override
    public void enviar(String destinatario, String asunto, String mensaje) {
        for (Notificador notificador : notificadores) {
            notificador.enviar(destinatario, asunto, mensaje);
        }
    }
}
