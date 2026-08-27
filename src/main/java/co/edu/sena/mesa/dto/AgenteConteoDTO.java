package co.edu.sena.mesa.dto;

public class AgenteConteoDTO {

    private String nombreAgente;
    private int cantidad;

    public AgenteConteoDTO() {
    }

    public AgenteConteoDTO(String nombreAgente, int cantidad) {
        this.nombreAgente = nombreAgente;
        this.cantidad = cantidad;
    }

    public String getNombreAgente() {
        return nombreAgente;
    }

    public void setNombreAgente(String nombreAgente) {
        this.nombreAgente = nombreAgente;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
}
