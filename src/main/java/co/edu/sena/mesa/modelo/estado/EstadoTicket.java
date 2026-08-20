package co.edu.sena.mesa.modelo.estado;

public interface EstadoTicket {

    String getNombreEstado();

    EstadoTicket asignar();

    EstadoTicket iniciarAtencion();

    EstadoTicket resolver();

    EstadoTicket confirmar();

    EstadoTicket reabrir();

    EstadoTicket cancelar();
}
