package co.edu.sena.mesa.repositorio;

public interface OtpCierreRepository {

    void asegurarTabla();

    void guardar(int idTicket, String codigo, int minutosVigencia);

    /** Marca el codigo como usado y devuelve true solo si era valido y no habia expirado. */
    boolean validarYConsumir(int idTicket, String codigo);
}
