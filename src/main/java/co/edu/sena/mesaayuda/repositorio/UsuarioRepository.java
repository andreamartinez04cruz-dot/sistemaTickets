package co.edu.sena.mesaayuda.repositorio;

import co.edu.sena.mesaayuda.modelo.Rol;
import co.edu.sena.mesaayuda.modelo.Usuario;
import java.util.List;

public interface UsuarioRepository {
    
    //Inicio de sesion 
    Usuario buscarCorreo (String correo);
    List<Rol> buscarRolesPorUsuario(int idUsuario);
    
}
