package co.edu.sena.mesa.modelo.estado;

public class EstadoEnProceso implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        throw new IllegalStateException(
                "El ticket ya está en proceso."
        );
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        throw new IllegalStateException(
                "El ticket ya está en proceso."
        );
    }

    @Override
    public EstadoTickets resolver() {
        return new EstadoResuelto();
    }

    @Override
    public EstadoTickets confirmar() {
        throw new IllegalStateException(
                "El ticket debe estar resuelto antes de ser confirmado."
        );
    }

    @Override
    public EstadoTickets reabrir() {
        throw new IllegalStateException(
                "El ticket todavía no está resuelto."
        );
    }

    @Override
    public EstadoTickets cancelar() {
        return new EstadoCancelado();
    }
}
