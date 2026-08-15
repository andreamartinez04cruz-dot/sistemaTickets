package co.edu.sena.mesa.modelo;

import java.time.LocalDateTime;
import co.edu.sena.mesa.modelo.estado.EstadoTickets;
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
    private EstadoTickets estado;

    public Ticket() {
    }

    public Ticket(int id, String titulo, String descripcion, Categoria categoria, Prioridad prioridad, Usuario solicitante, LocalDateTime fechaCreacion, EstadoTickets esatdo) {
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

    public EstadoTickets getEsatdo() {
        return estado;
    }

    public void setEsatdo(EstadoTickets esatdo) {
        this.estado = esatdo;
    }

    public String getEstadoNombre() {

        if (estado instanceof EstadoNuevo) {
            return "NUEVO";

        } else if (estado instanceof EstadoAsignado) {
            return "ASIGNADO";

        } else if (estado instanceof EstadoEnProceso) {
            return "EN_PROCESO";

        } else if (estado instanceof EstadoResuelto) {
            return "RESUELTO";

        } else if (estado instanceof EstadoCerrado) {
            return "CERRADO";

        } else if (estado instanceof EstadoCancelado) {
            return "CANCELADO";
        }

        return null;
    }

}
