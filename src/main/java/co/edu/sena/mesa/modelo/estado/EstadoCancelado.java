package co.edu.sena.mesa.modelo.estado;

public class EstadoCancelado implements EstadoTicket {

    @Override
    public String getNombreEstado() {
        return "CANCELADO";
    }

    @Override
    public EstadoTicket asignar() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser asignado."
        );
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede iniciar atención."
        );
    }

    @Override
    public EstadoTicket resolver() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser resuelto."
        );
    }

    @Override
    public EstadoTicket confirmar() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser confirmado."
        );
    }

    @Override
    public EstadoTicket reabrir() {
        throw new IllegalStateException(
                "Un ticket CANCELADO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTicket cancelar() {
        throw new IllegalStateException(
                "El ticket ya está cancelado."
        );
    }
}
