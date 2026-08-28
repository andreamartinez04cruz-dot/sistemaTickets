package co.edu.sena.mesa.modelo;

import java.time.LocalDateTime;

public class MensajeChat {

    private int id;
    private Ticket ticket;
    private Usuario usuario;
    private String mensaje;
    private LocalDateTime fechaEnvio;

    public MensajeChat() {

    }

    public MensajeChat(int id, Ticket ticket, Usuario usuario, String mensaje, LocalDateTime fechaEnvio) {
        this.id = id;
        this.ticket = ticket;
        this.usuario = usuario;
        this.mensaje = mensaje;
        this.fechaEnvio = fechaEnvio;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public LocalDateTime getFechaEnvio() {
        return fechaEnvio;
    }

    public void setFechaEnvio(LocalDateTime fechaEnvio) {
        this.fechaEnvio = fechaEnvio;
    }

}
