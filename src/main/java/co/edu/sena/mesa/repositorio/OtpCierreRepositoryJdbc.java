package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.util.RegistroErrores;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OtpCierreRepositoryJdbc implements OtpCierreRepository {

    @Override
    public void asegurarTabla() {
        String sql = "CREATE TABLE IF NOT EXISTS ticketotp ("
                + "id INT AUTO_INCREMENT PRIMARY KEY, "
                + "idTicket INT NOT NULL, "
                + "codigo VARCHAR(10) NOT NULL, "
                + "fechaExpiracion DATETIME NOT NULL, "
                + "usado TINYINT(1) NOT NULL DEFAULT 0, "
                + "INDEX idx_ticketotp_ticket (idTicket)"
                + ")";

        try (Connection conexion = ConexionBD.obtenerConexion();
                Statement statement = conexion.createStatement()) {
            statement.executeUpdate(sql);
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error creando la tabla ticketotp", exception);
        }
    }

    @Override
    public void guardar(int idTicket, String codigo, int minutosVigencia) {
        String anular = "UPDATE ticketotp SET usado = 1 WHERE idTicket = ? AND usado = 0";
        String insertar = "INSERT INTO ticketotp (idTicket, codigo, fechaExpiracion) "
                + "VALUES (?, ?, DATE_ADD(NOW(), INTERVAL ? MINUTE))";

        try (Connection conexion = ConexionBD.obtenerConexion()) {
            // Un ticket solo puede tener un codigo vigente a la vez
            try (PreparedStatement statement = conexion.prepareStatement(anular)) {
                statement.setInt(1, idTicket);
                statement.executeUpdate();
            }
            try (PreparedStatement statement = conexion.prepareStatement(insertar)) {
                statement.setInt(1, idTicket);
                statement.setString(2, codigo);
                statement.setInt(3, minutosVigencia);
                statement.executeUpdate();
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error guardando el codigo de cierre del ticket " + idTicket, exception);
        }
    }

    @Override
    public boolean validarYConsumir(int idTicket, String codigo) {
        if (codigo == null || codigo.trim().isEmpty()) {
            return false;
        }

        String buscar = "SELECT id FROM ticketotp WHERE idTicket = ? AND codigo = ? "
                + "AND usado = 0 AND fechaExpiracion > NOW() ORDER BY id DESC LIMIT 1";
        String consumir = "UPDATE ticketotp SET usado = 1 WHERE id = ?";

        try (Connection conexion = ConexionBD.obtenerConexion()) {
            int idCodigo;
            try (PreparedStatement statement = conexion.prepareStatement(buscar)) {
                statement.setInt(1, idTicket);
                statement.setString(2, codigo.trim());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (!resultSet.next()) {
                        return false;
                    }
                    idCodigo = resultSet.getInt("id");
                }
            }
            try (PreparedStatement statement = conexion.prepareStatement(consumir)) {
                statement.setInt(1, idCodigo);
                return statement.executeUpdate() > 0;
            }
        } catch (SQLException exception) {
            RegistroErrores.registrar("Error validando el codigo de cierre del ticket " + idTicket, exception);
            return false;
        }
    }
}
