package co.edu.sena.mesaayuda.servicio.notificacion;

public interface Notificador {

    void enviar(String destinatario, String asunto, String mensaje);
}
