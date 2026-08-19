package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.modelo.Usuario;

public interface UsuarioService {
    
    public Usuario iniciarSesion(String correo, String contraseña);   
    
}
