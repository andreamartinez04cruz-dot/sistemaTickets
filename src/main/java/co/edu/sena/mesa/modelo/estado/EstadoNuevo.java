package co.edu.sena.mesa.modelo.estado;

public class EstadoNuevo implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        return new EstadoAsignado();
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket NUEVO debe ser asignado antes de iniciar la atención."
        );
    }

    @Override
    public EstadoTickets resolver() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser resuelto."
        );
    }

    @Override
    public EstadoTickets confirmar() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser confirmado."
        );
    }

    @Override
    public EstadoTickets reabrir() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTickets cancelar() {
        return new EstadoCancelado();
    }
}
