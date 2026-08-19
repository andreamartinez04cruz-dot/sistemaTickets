package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoResuelto implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        throw new IllegalStateException(
                "El ticket ya fue resuelto."
        );
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        throw new IllegalStateException(
                "El ticket ya fue resuelto."
        );
    }

    @Override
    public EstadoTicket resolver() {
        throw new IllegalStateException(
                "El ticket ya está resuelto."
        );
    }

    @Override
    public EstadoTicket confirmar() {
        return new EstadoCerrado();
    }

    @Override
    public EstadoTicket reabrir() {
        return new EstadoEnProceso();
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }
}
