package co.edu.sena.mesa.modelo.estado;

public class EstadoCerrado implements EstadoTickets {

    @Override
    public EstadoTickets asignar() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTickets iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTickets resolver() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTickets confirmar() {
        throw new IllegalStateException(
                "El ticket ya está cerrado."
        );
    }

    @Override
    public EstadoTickets reabrir() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTickets cancelar() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser cancelado."
        );
    }
}
