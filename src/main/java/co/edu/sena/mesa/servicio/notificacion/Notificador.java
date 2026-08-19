package co.edu.sena.mesa.servicio.notificacion;

public interface Notificador {

    void enviar(String destinatario, String asunto, String mensaje);
}
