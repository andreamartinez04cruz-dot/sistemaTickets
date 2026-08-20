package co.edu.sena.mesa.modelo;

import java.time.LocalDateTime;
import co.edu.sena.mesa.modelo.estado.EstadoTicket;
import co.edu.sena.mesa.modelo.estado.EstadoNuevo;
import co.edu.sena.mesa.modelo.estado.EstadoAsignado;
import co.edu.sena.mesa.modelo.estado.EstadoEnProceso;
import co.edu.sena.mesa.modelo.estado.EstadoResuelto;
import co.edu.sena.mesa.modelo.estado.EstadoCerrado;
import co.edu.sena.mesa.modelo.estado.EstadoCancelado;

public class Ticket {

    private int id;
    private String titulo;
    private String descripcion;
    private Categoria categoria;
    private Prioridad prioridad;
    private Usuario solicitante;
    private LocalDateTime fechaCreacion;
    private EstadoTicket estado;
    private String programa;
    private String numeroPrograma;
    private String instructor;
    private String jornada;

    public Ticket() {
    }

    public Ticket(int id, String titulo, String descripcion, Categoria categoria, Prioridad prioridad, Usuario solicitante, LocalDateTime fechaCreacion, EstadoTicket esatdo) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.prioridad = prioridad;
        this.solicitante = solicitante;
        this.fechaCreacion = fechaCreacion;
        this.estado = esatdo;
    }

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

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public Prioridad getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(Prioridad prioridad) {
        this.prioridad = prioridad;
    }

    public Usuario getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(Usuario solicitante) {
        this.solicitante = solicitante;
    }

    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public EstadoTicket getEsatdo() {
        return estado;
    }

    public void setEsatdo(EstadoTicket esatdo) {
        this.estado = esatdo;
    }

    public String getEstadoNombre() {
        return estado != null ? estado.getNombreEstado() : null;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public String getNumeroPrograma() {
        return numeroPrograma;
    }

    public void setNumeroPrograma(String numeroPrograma) {
        this.numeroPrograma = numeroPrograma;
    }

    public String getInstructor() {
        return instructor;
    }

    public void setInstructor(String instructor) {
        this.instructor = instructor;
    }

    public String getJornada() {
        return jornada;
    }

    public void setJornada(String jornada) {
        this.jornada = jornada;
    }
}
