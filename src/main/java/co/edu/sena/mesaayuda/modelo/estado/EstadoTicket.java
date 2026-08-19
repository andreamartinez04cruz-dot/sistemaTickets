package co.edu.sena.mesaayuda.modelo.estado;

public interface EstadoTicket {

    EstadoTicket asignar();

    EstadoTicket iniciarAtencion();

    EstadoTicket resolver();

    EstadoTicket confirmar();

    EstadoTicket reabrir();

    EstadoTicket cancelar();
}
