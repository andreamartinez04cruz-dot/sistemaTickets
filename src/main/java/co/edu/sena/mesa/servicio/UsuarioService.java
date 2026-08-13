package co.edu.sena.mesa.servicio;

import co.edu.sena.mesa.modelo.Rol;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.repositorio.UsuarioRepository;

import java.util.List;

public class UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

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
