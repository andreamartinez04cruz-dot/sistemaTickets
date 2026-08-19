package co.edu.sena.mesa.servicio.notificacion;

public class NotificadorEnAplicacion implements Notificador {

    @Override
    public void enviar(String destinatario, String asunto, String mensaje) {
        System.out.println("[Notificacion en aplicacion]");
        System.out.println("Destinatario: " + destinatario);
        System.out.println("Asunto: " + asunto);
        System.out.println("Mensaje: " + mensaje);
    }
}
