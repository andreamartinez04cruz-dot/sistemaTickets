package co.edu.sena.mesaayuda.modelo;

import java.util.List;

public class Usuario {

    private int id;
    private String nombre;
    private String correo;
    private String contraseña;
    private List<Rol> roles;

    // 1. Constructor vacío (se removió el throw UnsupportedOperationException)
    public Usuario() {
    }

    // 2. Constructor parametrizado
    public Usuario(int id, String nombre, String correo, String contraseña) {
        this.id = id;
        this.nombre = nombre;
        this.correo = correo;
        this.contraseña = contraseña;
    }

    // --- GETTERS Y SETTERS ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Sobrecarga para aceptar Long si tu JDBC o Mapper le pasa un Long
    public void setId(Long idSolicitante) {
        if (idSolicitante != null) {
            this.id = idSolicitante.intValue();
        }
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public List<Rol> getRoles() {
        return roles;
    }

    public void setRoles(List<Rol> roles) {
        this.roles = roles;
    }
}
