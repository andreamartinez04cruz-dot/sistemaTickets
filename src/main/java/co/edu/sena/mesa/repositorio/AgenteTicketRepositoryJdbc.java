package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.AgenteTicketDTO;
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
            exception.printStackTrace();
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
            exception.printStackTrace();
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
            exception.printStackTrace();
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
            exception.printStackTrace();
            return null;
        }
    }

    @Override
    public List<AgenteTicketDTO> listarTicketsAsignados(int idAgente) {
        String sql = "SELECT t.id, t.titulo, t.estado, c.nombre AS categoria, pr.tipoPrioridad AS prioridad, "
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
                    AgenteTicketDTO ticket = new AgenteTicketDTO();
                    ticket.setId(resultSet.getInt("id"));
                    ticket.setTitulo(resultSet.getString("titulo"));
                    ticket.setEstado(resultSet.getString("estado"));
                    ticket.setCategoria(resultSet.getString("categoria"));
                    ticket.setPrioridad(resultSet.getString("prioridad"));
                    ticket.setSolicitante(resultSet.getString("solicitante"));
                    tickets.add(ticket);
                }
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }

        return tickets;
    }
}
