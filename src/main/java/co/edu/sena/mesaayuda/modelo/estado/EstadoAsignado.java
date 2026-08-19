package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoAsignado implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        throw new IllegalStateException(
                "El ticket ya está asignado."
        );
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        return (EstadoTicket) new EstadoEnProceso();
    }

    @Override
    public EstadoTicket resolver() {
        throw new IllegalStateException(
                "El agente debe iniciar la atención antes de resolver el ticket."
        );
    }

    @Override
    public EstadoTicket confirmar() {
        throw new IllegalStateException(
                "El ticket todavía no está resuelto."
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
