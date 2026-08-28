package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.modelo.MensajeChat;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MensajeChatRepositoryJdbc implements MensajeChatRepository {

    //Guardar conversacion
    @Override
    public boolean NuevoMensaje(MensajeChat mensaje) {
        String sql = "INSERT INTO mensaje_chat (idTicket, idUsuario, mensaje, fechaEnvio) "
                + "  Values( ?, ?, ?, ?)";

        try (Connection conn = ConexionBD.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, mensaje.getTicket().getId());
            ps.setInt(2, mensaje.getUsuario().getId());
            ps.setString(3, mensaje.getMensaje());

            // Si la fecha viene nula, asignamos la fecha y hora actual del sistema
            LocalDateTime fecha = mensaje.getFechaEnvio() != null
                    ? mensaje.getFechaEnvio() : LocalDateTime.now();
            ps.setTimestamp(4, Timestamp.valueOf(fecha));

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            System.err.println("Error al guardar el mensaje en la BD: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

    }

    //Listar mensajes
    public List<MensajeChat> ListarMensaje(int idTicket) {
        List<MensajeChat> lista = new ArrayList<>();
        String sql = "SELECT mc.id, mc.idTicket, mc.idUsuario, u.nombre, mc.mensaje, mc.fechaEnvio "
                + "FROM mensaje_chat mc JOIN usuario u ON u.id = mc.idUsuario "
                + "WHERE mc.idTicket = ? ORDER BY mc.fechaEnvio ASC";

        try (Connection conn = ConexionBD.obtenerConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idTicket);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    MensajeChat mensaje = new MensajeChat();
                    mensaje.setId(rs.getInt("id"));

                    // Como tu modelo usa objetos, instanciamos contenedores básicos con los IDs
                    // (O puedes hacer un JOIN con las tablas Ticket y Usuario si necesitas más datos)
                    Ticket t = new Ticket();
                    t.setId(rs.getInt("idTicket"));
                    mensaje.setTicket(t);

                    Usuario u = new Usuario();
                    u.setId(rs.getInt("idUsuario"));
                    u.setNombre(rs.getString("nombre"));
                    mensaje.setUsuario(u);

                    mensaje.setMensaje(rs.getString("mensaje"));

                    // Convertimos el Timestamp de la BD a LocalDate (o LocalDateTime si decides cambiarlo en tu modelo)
                    Timestamp timestamp = rs.getTimestamp("fechaEnvio");
                    if (timestamp != null) {
                        mensaje.setFechaEnvio(timestamp.toLocalDateTime());
                    }

                    lista.add(mensaje);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al listar los mensajes: " + e.getMessage());
            e.printStackTrace();
        }

        return lista;
    }

}
