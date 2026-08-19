package co.edu.sena.mesa.dto;

public class ComentarioDTO {

    private int id;
    private int idTicket;
    private int idUsuario;
    private String nombreUsuario;
    private String texto;
    private String fechaFormateada; // Formato amigable para el JSP (ej: "14 Aug, 03:00 PM")

    public ComentarioDTO() {
    }

    // --- GETTERS Y SETTERS PRINCIPALES ---
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

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getFechaFormateada() {
        return fechaFormateada;
    }

    public void setFechaFormateada(String fechaFormateada) {
        this.fechaFormateada = fechaFormateada;
    }

    // --- GETTERS DE COMPATIBILIDAD PARA EL JSP ---
    public String getNombreAutor() {
        return nombreUsuario;
    }

    public String getFecha() {
        return fechaFormateada;
    }
}
