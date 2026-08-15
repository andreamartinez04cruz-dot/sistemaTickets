package co.edu.sena.mesa.modelo.estado;

public class EstadoCancelado implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser asignado."
        );
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede iniciar atención."
        );
    }

    @Override
    public EstadoTickets resolver() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser resuelto."
        );
    }

    @Override
    public EstadoTickets confirmar() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser confirmado."
        );
    }

    @Override
    public EstadoTickets reabrir() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTickets cancelar() {
        throw new IllegalStateException(
                "El ticket ya está cancelado."
        );
    }
}