package co.edu.sena.mesa.dto;

import java.util.List;

public class TicketDTO {

    private int id;
    private String titulo;
    private String descripcion;

    // CATEGORIA
    private int idCategoria;
    private String categoriaNombre;

    // PRIORIDAD
    private int idPrioridad;
    private String prioridadNombre;

    // SOLICITANTE
    private int idSolicitante;
    private String solicitanteNombre;

    // ESTADO
    private String estado;

    // FECHA
    private String fechaCreacion;

    // COMENTARIOS
    private List<ComentarioDTO> comentarios;
    

    public TicketDTO() {
    }

    // =========================
    // ID
    // =========================
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // =========================
    // TITULO
    // =========================
    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    // =========================
    // DESCRIPCION
    // =========================
    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    // =========================
    // CATEGORIA
    // =========================
    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getCategoriaNombre() {
        return categoriaNombre;
    }

    public void setCategoriaNombre(String categoriaNombre) {
        this.categoriaNombre = categoriaNombre;
    }

    // =========================
    // PRIORIDAD
    // =========================
    public int getIdPrioridad() {
        return idPrioridad;
    }

    public void setIdPrioridad(int idPrioridad) {
        this.idPrioridad = idPrioridad;
    }

    public String getPrioridadNombre() {
        return prioridadNombre;
    }

    public void setPrioridadNombre(String prioridadNombre) {
        this.prioridadNombre = prioridadNombre;
    }

    // =========================
    // SOLICITANTE
    // =========================
    public int getIdSolicitante() {
        return idSolicitante;
    }

    public void setIdSolicitante(int idSolicitante) {
        this.idSolicitante = idSolicitante;
    }

    public String getSolicitanteNombre() {
        return solicitanteNombre;
    }

    public void setSolicitanteNombre(String solicitanteNombre) {
        this.solicitanteNombre = solicitanteNombre;
    }

    // =========================
    // ESTADO
    // =========================
    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    // =========================
    // FECHA
    // =========================
    public String getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(String fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    // =========================
    // COMENTARIOS
    // =========================
    public List<ComentarioDTO> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<ComentarioDTO> comentarios) {
        this.comentarios = comentarios;
    }
}
