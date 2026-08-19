package co.edu.sena.mesaayuda.dto;

public class HistorialFuncionarioDTO {

    private int id;
    private String titulo;
    private String descripcion;
    private String categoriaNombre;
    private String prioridadNombre;
    private String estadoNombre;
    private String fechaCreacion;

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCategoriaNombre() {
        return categoriaNombre;
    }

    public void setCategoriaNombre(String categoriaNombre) {
        this.categoriaNombre = categoriaNombre;
    }

    public String getPrioridadNombre() {
        return prioridadNombre;
    }

    public void setPrioridadNombre(String prioridadNombre) {
        this.prioridadNombre = prioridadNombre;
    }

    public String getEstadoNombre() {
        return estadoNombre;
    }

    public void setEstadoNombre(String estadoNombre) {
        this.estadoNombre = estadoNombre;
    }

    public String getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(String fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}
