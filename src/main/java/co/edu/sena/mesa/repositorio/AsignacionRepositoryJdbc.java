package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AsignacionRepositoryJdbc implements AsignacionRepository {

    @Override
    public List<Usuario> listarAgentesDisponibles() {
        String sql = "SELECT DISTINCT u.id, u.nombre, u.correo FROM usuario u "
            + "INNER JOIN rolusuario ru ON ru.idUsuario = u.id "
            + "INNER JOIN rol r ON r.id = ru.idRol "
                + "WHERE LOWER(TRIM(r.tipoRol)) IN ('agente', 'support_agent') "
                + "ORDER BY u.id";
        List<Usuario> agentes = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Usuario agente = new Usuario();
                agente.setId(resultSet.getInt("id"));
                agente.setNombre(resultSet.getString("nombre"));
                agente.setCorreo(resultSet.getString("correo"));
                agentes.add(agente);
            }
        } catch (Exception exception) {
            throw new RuntimeException("Error al listar agentes disponibles", exception);
        }
        return agentes;
    }

    @Override
    public void asignarTicket(int idTicket, int idAgente, String estado) {
        String insertarAsignacion = "INSERT INTO ticketagente (idTicket, idUsuario) VALUES (?, ?) "
                + "ON DUPLICATE KEY UPDATE idUsuario = VALUES(idUsuario), "
                + "fechaAsignacion = CURRENT_TIMESTAMP";
        String actualizarEstado = "UPDATE ticket SET estado = ? WHERE id = ? "
            + "AND REPLACE(UPPER(COALESCE(estado, '')), ' ', '_') = 'NUEVO'";

        try (Connection conexion = ConexionBD.obtenerConexion()) {
            try (PreparedStatement statement = conexion.prepareStatement(insertarAsignacion)) {
                statement.setInt(1, idTicket);
                statement.setInt(2, idAgente);
                statement.executeUpdate();
            }
            try (PreparedStatement statement = conexion.prepareStatement(actualizarEstado)) {
                statement.setString(1, estado);
                statement.setInt(2, idTicket);
                statement.executeUpdate();
            }
        } catch (Exception exception) {
            throw new RuntimeException("Error al asignar el ticket", exception);
        }
    }
}
