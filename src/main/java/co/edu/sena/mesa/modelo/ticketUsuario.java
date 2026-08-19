package co.edu.sena.mesa.modelo;

public class ticketUsuario {
    private int id;
    private int idTicket;
    private int idUsuario;
    
    public ticketUsuario() {
        
    }

    public ticketUsuario(int id, int idTicket, int idUsuario) {
        this.id = id;
        this.idTicket = idTicket;
        this.idUsuario = idUsuario;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdTicket() {
        return idTicket;
    }

    public void setIdTicket(int idTicket) {
        this.idTicket = idTicket;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    
    
}
