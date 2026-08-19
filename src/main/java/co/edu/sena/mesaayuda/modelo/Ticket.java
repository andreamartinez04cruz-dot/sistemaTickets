package co.edu.sena.mesaayuda.modelo;

import java.time.LocalDateTime;
import co.edu.sena.mesaayuda.modelo.estado.EstadoTicket;
import co.edu.sena.mesaayuda.modelo.estado.EstadoNuevo;
import co.edu.sena.mesaayuda.modelo.estado.EstadoAsignado;
import co.edu.sena.mesaayuda.modelo.estado.EstadoEnProceso;
import co.edu.sena.mesaayuda.modelo.estado.EstadoResuelto;
import co.edu.sena.mesaayuda.modelo.estado.EstadoCerrado;
import co.edu.sena.mesaayuda.modelo.estado.EstadoCancelado;

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
