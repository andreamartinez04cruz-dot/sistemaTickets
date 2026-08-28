package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.util.RegistroErrores;
import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.AgenteTicketDTO;
import co.edu.sena.mesa.dto.DestinatarioNotificacionDTO;
import co.edu.sena.mesa.mapper.AgenteTicketMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AgenteTicketRepositoryJdbc implements AgenteTicketRepository {

    @Override
    public boolean estaAsignado(int idTicket, int idAgente) {
        String sql = "SELECT 1 FROM ticketagente WHERE idTicket = ? AND idUsuario = ?";

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idTicket);
            statement.setInt(2, idAgente);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error validando asignación del agente", exception);
            return false;
        }
    }

    @Override
    public String obtenerEstadoActual(int idTicket, int idAgente) {
        String sql = "SELECT t.estado FROM ticket t "
                + "INNER JOIN ticketagente ta ON ta.idTicket = t.id "
                + "WHERE t.id = ? AND ta.idUsuario = ?";

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idTicket);
            statement.setInt(2, idAgente);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? resultSet.getString("estado") : null;
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error consultando estado del ticket", exception);
            return null;
        }
    }

    @Override
    public int actualizarEstado(int idTicket, int idAgente, String estado) {
        String sql = "UPDATE ticket SET estado = ? WHERE id = ? "
                + "AND id IN (SELECT idTicket FROM ticketagente WHERE idUsuario = ?)";

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setString(1, estado);
            statement.setInt(2, idTicket);
            statement.setInt(3, idAgente);
            return statement.executeUpdate();
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error actualizando estado del ticket", exception);
            return 0;
        }
    }

    @Override
    public String obtenerCorreoSolicitante(int idTicket) {
        String sql = "SELECT u.correo FROM ticket t JOIN usuario u ON u.id = t.idUsuario WHERE t.id = ?";

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idTicket);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next() ? resultSet.getString("correo") : null;
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error consultando correo del solicitante", exception);
            return null;
        }
    }

    @Override
    public List<DestinatarioNotificacionDTO> obtenerDestinatariosNotificacion(int idTicket) {
        List<DestinatarioNotificacionDTO> destinatarios = new ArrayList<>();

        String sqlSolicitante = "SELECT u.correo, t.titulo, t.estado "
                + "FROM ticket t JOIN usuario u ON u.id = t.idUsuario WHERE t.id = ?";

        String sqlAgentes = "SELECT u.correo, t.titulo, t.estado "
                + "FROM ticketagente ta JOIN ticket t ON t.id = ta.idTicket "
                + "JOIN usuario u ON u.id = ta.idUsuario WHERE ta.idTicket = ?";

        String sqlAdmins = "SELECT DISTINCT u.correo, t.titulo, t.estado, "
                + "COALESCE(c.nombre, 'Sin categoria') AS categoria, "
                + "COALESCE(ag.nombre, 'sin agente') AS agente "
                + "FROM ticket t "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN ticketagente ta ON ta.idTicket = t.id "
                + "LEFT JOIN usuario ag ON ag.id = ta.idUsuario "
                + "JOIN rolusuario ru ON ru.idRol = "
                + "(SELECT r.id FROM rol r WHERE UPPER(r.tipoRol) = 'ADMINISTRADOR' LIMIT 1) "
                + "JOIN usuario u ON u.id = ru.idUsuario "
                + "WHERE t.id = ?";

        agregar(destinatarios, sqlSolicitante, idTicket, "SOLICITANTE", false);
        agregar(destinatarios, sqlAgentes, idTicket, "AGENTE", false);
        agregar(destinatarios, sqlAdmins, idTicket, "ADMIN", true);

        return destinatarios;
    }

    private void agregar(List<DestinatarioNotificacionDTO> destino, String sql, int idTicket,
            String rol, boolean conDetalleAdmin) {
        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idTicket);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String correo = resultSet.getString("correo");
                    if (correo == null || correo.trim().isEmpty()) {
                        continue;
                    }
                    destino.add(new DestinatarioNotificacionDTO(
                        correo.trim(),
                        rol,
                        resultSet.getString("titulo"),
                        resultSet.getString("estado"),
                        conDetalleAdmin ? resultSet.getString("categoria") : null,
                        conDetalleAdmin ? resultSet.getString("agente") : null));
                }
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error consultando destinatarios (" + rol + ")", exception);
        }
    }

    @Override
    public List<AgenteTicketDTO> listarTicketsAsignados(int idAgente) {
        String sql = "SELECT t.id, t.titulo, t.estado, c.nombre AS categoria, pr.tipoPrioridad AS prioridad, "
            + "CASE "
            + "WHEN UPPER(COALESCE(pr.tipoPrioridad, '')) LIKE '%CRIT%' THEN 4 "
            + "WHEN UPPER(COALESCE(pr.tipoPrioridad, '')) LIKE '%ALTA%' THEN 8 "
            + "WHEN UPPER(COALESCE(pr.tipoPrioridad, '')) LIKE '%MEDIA%' THEN 24 "
            + "WHEN UPPER(COALESCE(pr.tipoPrioridad, '')) LIKE '%BAJA%' THEN 72 ELSE 0 END AS horas_atencion, "
                + "u.nombre AS solicitante "
                + "FROM ticketagente ta "
                + "JOIN ticket t ON t.id = ta.idTicket "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
                + "WHERE ta.idUsuario = ? "
                + "ORDER BY t.id DESC";

        List<AgenteTicketDTO> tickets = new ArrayList<>();

        try (Connection conexion = ConexionBD.obtenerConexion();
                PreparedStatement statement = conexion.prepareStatement(sql)) {
            statement.setInt(1, idAgente);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    tickets.add(AgenteTicketMapper.toDTO(resultSet));
                }
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error listando tickets asignados", exception);
        }

        return tickets;
    }
}
