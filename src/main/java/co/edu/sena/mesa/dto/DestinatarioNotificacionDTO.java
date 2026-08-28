package co.edu.sena.mesa.dto;

/** Datos necesarios para armar la notificacion que le corresponde a cada rol. */
public class DestinatarioNotificacionDTO {

    private final String correo;
    private final String rol;
    private final String titulo;
    private final String estado;
    private final String categoria;
    private final String agente;

    public DestinatarioNotificacionDTO(String correo, String rol, String titulo,
            String estado, String categoria, String agente) {
        this.correo = correo;
        this.rol = rol;
        this.titulo = titulo;
        this.estado = estado;
        this.categoria = categoria;
        this.agente = agente;
    }

    public String getCorreo() {
        return correo;
    }

    public String getRol() {
        return rol;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getEstado() {
        return estado;
    }

    public String getCategoria() {
        return categoria;
    }

    public String getAgente() {
        return agente;
    }
}
