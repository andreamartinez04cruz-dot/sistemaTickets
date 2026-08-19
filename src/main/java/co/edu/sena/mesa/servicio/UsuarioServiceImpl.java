package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.modelo.Rol;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.repositorio.UsuarioRepository;

import java.util.List;

public class UsuarioServiceImpl  implements UsuarioService{

    private final UsuarioRepository usuarioRepository;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }
    @Override

    public Usuario iniciarSesion(String correo, String contraseña) {

        Usuario usuario = usuarioRepository.buscarCorreo(correo);

        if (usuario == null) {
            return null;
        }

        if (!usuario.getContraseña().equals(contraseña)) {
            return null;
        }

        List<Rol> roles
                = usuarioRepository.buscarRolesPorUsuario(usuario.getId());

        usuario.setRoles(roles);

        return usuario;
    }
}
