package co.edu.sena.mesa.modelo.estado;

public class EstadoAsignado implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        throw new IllegalStateException(
                "El ticket ya está asignado."
        );
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        return (EstadoTickets) new EstadoEnProceso();
    }

    @Override
    public EstadoTickets resolver() {
        throw new IllegalStateException(
                "El agente debe iniciar la atención antes de resolver el ticket."
        );
    }

    @Override
    public EstadoTickets confirmar() {
        throw new IllegalStateException(
                "El ticket todavía no está resuelto."
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
