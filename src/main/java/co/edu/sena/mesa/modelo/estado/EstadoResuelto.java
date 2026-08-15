package co.edu.sena.mesa.modelo.estado;

public class EstadoResuelto implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        throw new IllegalStateException(
                "El ticket ya fue resuelto."
        );
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        throw new IllegalStateException(
                "El ticket ya fue resuelto."
        );
    }

    @Override
    public EstadoTickets resolver() {
        throw new IllegalStateException(
                "El ticket ya está resuelto."
        );
    }

    @Override
    public EstadoTickets confirmar() {
        return new EstadoCerrado();
    }

    @Override
    public EstadoTickets reabrir() {
        return new EstadoEnProceso();
    }

    @Override
    public EstadoTickets cancelar() {
        return new EstadoCancelado();
    }
}
