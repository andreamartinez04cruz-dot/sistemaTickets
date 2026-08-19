package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoNuevo implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        return new EstadoAsignado();
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket NUEVO debe ser asignado antes de iniciar la atención."
        );
    }

    @Override
    public EstadoTicket resolver() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser resuelto."
        );
    }

    @Override
    public EstadoTicket confirmar() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser confirmado."
        );
    }

    @Override
    public EstadoTicket reabrir() {
        throw new IllegalStateException(
                "Un ticket NUEVO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTicket cancelar() {
        return new EstadoCancelado();
    }
}
