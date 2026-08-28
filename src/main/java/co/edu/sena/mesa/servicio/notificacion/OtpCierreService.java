package co.edu.sena.mesa.servicio.notificacion;

public interface OtpCierreService {

    /** Genera un codigo de un solo uso y lo envia al correo del solicitante. */
    void generarYEnviar(int idTicket);

    /** Verifica el codigo; si es valido lo consume para que no pueda reutilizarse. */
    boolean validar(int idTicket, String codigo);
}
