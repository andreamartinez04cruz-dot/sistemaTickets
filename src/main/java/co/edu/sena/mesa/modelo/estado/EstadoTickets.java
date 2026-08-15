package co.edu.sena.mesa.modelo.estado;

public interface EstadoTickets {

    EstadoTickets asignar();

    EstadoTickets iniciarAtencion();

    EstadoTickets resolver();

    EstadoTickets confirmar();

    EstadoTickets reabrir();

    EstadoTickets cancelar();
}
