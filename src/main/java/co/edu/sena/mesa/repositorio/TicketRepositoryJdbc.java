package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.modelo.Ticket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TicketRepositoryJdbc implements TicketRepository {

    
    //  Ejecutar el INSERT en MySQL  Doris
    @Override
    public Ticket guardar(Ticket ticket) {

        String sql = "INSERT INTO ticket "
                + "(titulo, descripcion, idCategoria, idPrioridad, "
                + "idSolicitante, estado, fechaCreacion) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = ConexionBD.obtenerConexion(); PreparedStatement statement = conexion.prepareStatement(
                sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, ticket.getTitulo());
            statement.setString(2, ticket.getDescripcion());
            statement.setLong(3, ticket.getCategoria().getId());
            statement.setLong(4, ticket.getPrioridad().getId());
            statement.setLong(5, ticket.getSolicitante().getId());
            statement.setString(6, ticket.getEstado());
            statement.setTimestamp(
                    7,
                    java.sql.Timestamp.valueOf(
                            ticket.getFechaCreacion()
                    )
            );

            statement.executeUpdate();

            try (ResultSet resultado = statement.getGeneratedKeys()) {
                if (resultado.next()) {
                    ticket.setId(resultado.getLong(1));
                }
            }

            return ticket;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error al registrar el ticket", e
            );
        }
    }
}
