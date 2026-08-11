package co.edu.sena.mesa.modelo;

public class RolUsuario {
    private int id;
    private Usuario usuario;
    private Rol rol;

    public RolUsuario() {
    }

    public RolUsuario(int id, Usuario usuario, Rol rol) {
        this.id = id;
        this.usuario = usuario;
        this.rol = rol;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
    
    
    
}
