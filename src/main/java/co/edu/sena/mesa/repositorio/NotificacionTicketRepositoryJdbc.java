package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NotificacionTicketRepositoryJdbc implements NotificacionTicketRepository {

    @Override
    public int finalizarTicket(int idTicket, String rol, int idUsuario) {
        String sql;
        boolean requiereUsuario = false;

        if ("ADMIN".equals(rol)) {
            sql = "UPDATE ticket SET estado = 'CERRADO' WHERE id = ? "
                    + "AND REPLACE(UPPER(COALESCE(estado, '')), ' ', '_') = 'RESUELTO'";
        } else if ("AGENTE".equals(rol)) {
            sql = "UPDATE ticket t INNER JOIN ticketagente ta ON ta.idTicket = t.id "
                    + "SET t.estado = 'CERRADO' WHERE t.id = ? AND ta.idUsuario = ? "
                    + "AND REPLACE(UPPER(COALESCE(t.estado, '')), ' ', '_') = 'RESUELTO'";
            requiereUsuario = true;
        } else {
            sql = "UPDATE ticket SET estado = 'CERRADO' WHERE id = ? AND idUsuario = ? "
                    + "AND REPLACE(UPPER(COALESCE(estado, '')), ' ', '_') = 'RESUELTO'";
            requiereUsuario = true;
        }

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idTicket);
            if (requiereUsuario) {
                statement.setInt(2, idUsuario);
            }
            return statement.executeUpdate();
        } catch (Exception exception) {
            exception.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Map<String, Object>> listarNotificaciones(String rol, int idUsuario) {
        if ("AGENTE".equals(rol)) {
            return listarNotificacionesAgente(idUsuario);
        }
        if ("ADMIN".equals(rol)) {
            return listarNotificacionesAdministrador();
        }
        return listarNotificacionesSolicitante(idUsuario);
    }

    private List<Map<String, Object>> listarNotificacionesAgente(int idUsuario) {
        String sql = "SELECT t.id, t.titulo, t.estado FROM ticketagente ta "
                + "JOIN ticket t ON t.id = ta.idTicket WHERE ta.idUsuario = ? "
                + "ORDER BY ta.fechaAsignacion DESC";
        List<Map<String, Object>> notificaciones = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Map<String, Object> notificacion = new HashMap<>();
                    int idTicket = resultSet.getInt("id");
                    String titulo = resultSet.getString("titulo");
                    notificacion.put("id", idTicket);
                    notificacion.put("titulo", titulo);
                    notificacion.put("estado", resultSet.getString("estado"));
                    notificacion.put("tipoNotificacion", "Asignación de ticket");
                    notificacion.put("mensaje", "Se te asignó el ticket #" + idTicket + " - " + titulo + ".");
                    notificaciones.add(notificacion);
                }
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return notificaciones;
    }

    private List<Map<String, Object>> listarNotificacionesAdministrador() {
        String sql = "SELECT t.id, t.titulo, t.estado, c.nombre AS categoria, "
                + "u.nombre AS agente, ta.fechaAsignacion FROM ticketagente ta "
                + "JOIN ticket t ON t.id = ta.idTicket JOIN usuario u ON u.id = ta.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria ORDER BY ta.fechaAsignacion DESC";
        List<Map<String, Object>> notificaciones = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Map<String, Object> notificacion = new HashMap<>();
                int idTicket = resultSet.getInt("id");
                String titulo = resultSet.getString("titulo");
                notificacion.put("id", idTicket);
                notificacion.put("titulo", titulo);
                notificacion.put("estado", resultSet.getString("estado"));
                notificacion.put("tipoNotificacion", "Ticket asignado");
                notificacion.put("mensaje", "El ticket #" + idTicket + " - " + titulo + " ("
                        + resultSet.getString("categoria") + ") fue asignado a "
                        + resultSet.getString("agente") + ".");
                notificaciones.add(notificacion);
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return notificaciones;
    }

    private List<Map<String, Object>> listarNotificacionesSolicitante(int idUsuario) {
        String sql = "SELECT id, titulo, estado FROM ticket WHERE idUsuario = ? ORDER BY id DESC";
        List<Map<String, Object>> notificaciones = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idUsuario);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Map<String, Object> notificacion = new HashMap<>();
                    int idTicket = resultSet.getInt("id");
                    String titulo = resultSet.getString("titulo");
                    String estado = resultSet.getString("estado");
                    notificacion.put("id", idTicket);
                    notificacion.put("titulo", titulo);
                    notificacion.put("estado", estado);
                    notificacion.put("tipoNotificacion", "Cambio de estado");
                    notificacion.put("mensaje", "El ticket #" + idTicket + " - " + titulo
                            + " está en estado " + estado + ".");
                    notificaciones.add(notificacion);
                }
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return notificaciones;
    }
}
