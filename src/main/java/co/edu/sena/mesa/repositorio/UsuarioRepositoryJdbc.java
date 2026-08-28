package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.util.RegistroErrores;
import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.modelo.Rol;
import co.edu.sena.mesa.modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UsuarioRepositoryJdbc implements UsuarioRepository {

    @Override
    public Usuario buscarCorreo(String correo) {

        String sql = "SELECT * FROM usuario WHERE correo = ?";

        try (Connection conexion = ConexionBD.obtenerConexion(); PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setString(1, correo);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    return new Usuario(
                            rs.getInt("id"),
                            rs.getString("nombre"),
                            rs.getString("correo"),
                            rs.getString("contraseña")
                    );
                }
            }

        } catch (Exception e) {
            RegistroErrores.registrar("Error al consultar usuario", e);
        }

        return null;
    }

    @Override
    public List<Rol> buscarRolesPorUsuario(int idUsuario) {

        String sql = "SELECT r.id, r.tipoRol"
                + " FROM rolusuario ur "
                + " INNER JOIN rol r ON ur.idRol = r.id " 
                +"  WHERE ur.idUsuario = ?";

        List<Rol> roles = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion(); PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Rol rol = new Rol(
                            rs.getInt("id"),
                            rs.getString("tipoRol")
                    );

                    roles.add(rol);
                }
            }

        } catch (Exception e) {
            RegistroErrores.registrar("Error al consultar roles del usuario", e);
        }

        return roles;
    }
}
