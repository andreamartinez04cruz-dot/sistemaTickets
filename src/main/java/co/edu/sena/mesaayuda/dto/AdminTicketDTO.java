package co.edu.sena.mesaayuda.dto;

public class AdminTicketDTO {

    private int id;
    private String titulo;
    private String descripcion;
    private String nombreAprendiz;
    private String nombreFuncionario;
    private String programa;
    private Integer numeroPrograma;
    private String instructorCargo;
    private String jornada;
    private String categoria;
    private String prioridad;
    private String rol;
    private String estado;
    private String tipoPersona;

    public AdminTicketDTO() {
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

    public String getNombreAprendiz() {
        return nombreAprendiz;
    }

    public void setNombreAprendiz(String nombreAprendiz) {
        this.nombreAprendiz = nombreAprendiz;
    }

    public String getNombreFuncionario() {
        return nombreFuncionario;
    }

    public void setNombreFuncionario(String nombreFuncionario) {
        this.nombreFuncionario = nombreFuncionario;
    }

    public String getPrograma() {
        return programa;
    }

    public void setPrograma(String programa) {
        this.programa = programa;
    }

    public Integer getNumeroPrograma() {
        return numeroPrograma;
    }

    public void setNumeroPrograma(Integer numeroPrograma) {
        this.numeroPrograma = numeroPrograma;
    }

    public String getInstructorCargo() {
        return instructorCargo;
    }

    public void setInstructorCargo(String instructorCargo) {
        this.instructorCargo = instructorCargo;
    }

    public String getJornada() {
        return jornada;
    }

    public void setJornada(String jornada) {
        this.jornada = jornada;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTipoPersona() {
        return tipoPersona;
    }

    public void setTipoPersona(String tipoPersona) {
        this.tipoPersona = tipoPersona;
    }
}
