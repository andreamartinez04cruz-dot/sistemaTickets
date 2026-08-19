package co.edu.sena.mesaayuda.modelo.estado;

public class EstadoCerrado implements EstadoTicket {

    @Override
    public EstadoTicket asignar() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTicket iniciarAtencion() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTicket resolver() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser modificado."
        );
    }

    @Override
    public EstadoTicket confirmar() {
        throw new IllegalStateException(
                "El ticket ya está cerrado."
        );
    }

    @Override
    public EstadoTicket reabrir() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser reabierto."
        );
    }

    @Override
    public EstadoTicket cancelar() {
        throw new IllegalStateException(
                "Un ticket CERRADO no puede ser cancelado."
        );
    }
}
