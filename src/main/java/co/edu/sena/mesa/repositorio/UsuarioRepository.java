package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.modelo.Rol;
import co.edu.sena.mesa.modelo.Usuario;
import java.util.List;

public interface UsuarioRepository {
    
    //Inicio de sesion 
    Usuario buscarCorreo (String correo);
    List<Rol> buscarRolesPorUsuario(int idUsuario);
    
}
