package co.edu.sena.mesa.dto;

public class EstadoConteoDTO {

    private String estado;
    private int cantidad;

    public EstadoConteoDTO() {
    }

    public EstadoConteoDTO(String estado, int cantidad) {
        this.estado = estado;
        this.cantidad = cantidad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
