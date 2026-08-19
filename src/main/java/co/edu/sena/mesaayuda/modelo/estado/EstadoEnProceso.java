package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoEnProceso implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        throw new IllegalStateException(
                "El ticket ya está en proceso."
        );
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        throw new IllegalStateException(
                "El ticket ya está en proceso."
        );
    }

    @Override
    public EstadoTicket resolver() {
        return new EstadoResuelto();
    }

    @Override
    public EstadoTicket confirmar() {
        throw new IllegalStateException(
                "El ticket debe estar resuelto antes de ser confirmado."
        );
    }

    @Override
    public EstadoTicket reabrir() {
        throw new IllegalStateException(
                "El ticket todavía no está resuelto."
        );
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }
}
