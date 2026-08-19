package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminTicketRepositoryJdbc implements AdminTicketRepository {

    @Override
    public List<AdminTicketDTO> listarTicketsAprendiz() {
        List<AdminTicketDTO> lista = new ArrayList<>();

        String sql = "SELECT t.id, t.titulo, t.descripcion, CONCAT(u.nombre, ' ', u.apellido) AS nombre_aprendiz, "
            + "t.programa AS programa, t.numeroPrograma AS numero_programa, "
            + "t.instructor AS nombre_instructor, '' AS apellido_instructor, "
            + "c.nombre AS categoria, pr.tipoPrioridad AS prioridad, t.estado, "
            + "'APRENDIZ' AS tipo_persona, 'No definida' AS jornada "
            + "FROM ticket t "
            + "JOIN usuario u ON u.id = t.idUsuario "
            + "LEFT JOIN categoria c ON c.id = t.idCategoria "
            + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
            + "WHERE EXISTS (SELECT 1 FROM rolusuario ru "
            + "INNER JOIN rol r ON r.id = ru.idRol "
            + "WHERE ru.idUsuario = u.id "
            + "AND LOWER(TRIM(r.tipoRol)) LIKE '%aprendiz%') "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminTicketDTO dto = new AdminTicketDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitulo(rs.getString("titulo"));
                dto.setDescripcion(rs.getString("descripcion"));
                dto.setNombreAprendiz(rs.getString("nombre_aprendiz"));
                dto.setPrograma(rs.getString("programa"));
                dto.setNumeroPrograma(rs.getObject("numero_programa") != null ? rs.getInt("numero_programa") : null);

                String nombreInstructor = rs.getString("nombre_instructor");
                String apellidoInstructor = rs.getString("apellido_instructor");
                dto.setInstructorCargo((nombreInstructor != null ? nombreInstructor : "") + (apellidoInstructor != null && !apellidoInstructor.isEmpty() ? " " + apellidoInstructor : ""));

                dto.setCategoria(rs.getString("categoria"));
                dto.setPrioridad(rs.getString("prioridad"));
                dto.setEstado(rs.getString("estado"));
                dto.setTipoPersona(rs.getString("tipo_persona"));
                dto.setJornada("No definida");
                lista.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public List<AdminTicketDTO> listarTicketsFuncionario() {
        List<AdminTicketDTO> lista = new ArrayList<>();

        String sql = "SELECT DISTINCT t.id, t.titulo, t.descripcion, CONCAT(u.nombre, ' ', u.apellido) AS nombre_funcionario, COALESCE(r.tipoRol, 'SIN ROL') AS rol, "
                + "c.nombre AS categoria, pr.tipoPrioridad AS prioridad, t.estado, "
                + "'FUNCIONARIO' AS tipo_persona, 'No definida' AS jornada "
                + "FROM ticket t "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "LEFT JOIN rol r ON r.id = ru.idRol "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
                + "WHERE NOT EXISTS (SELECT 1 FROM rolusuario ruAprendiz "
                + "INNER JOIN rol rAprendiz ON rAprendiz.id = ruAprendiz.idRol "
                + "WHERE ruAprendiz.idUsuario = u.id "
                + "AND LOWER(TRIM(rAprendiz.tipoRol)) LIKE '%aprendiz%') "
                + "ORDER BY t.id DESC";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminTicketDTO dto = new AdminTicketDTO();
                dto.setId(rs.getInt("id"));
                dto.setTitulo(rs.getString("titulo"));
                dto.setDescripcion(rs.getString("descripcion"));
                dto.setNombreFuncionario(rs.getString("nombre_funcionario"));
                dto.setRol(rs.getString("rol"));
                dto.setCategoria(rs.getString("categoria"));
                dto.setPrioridad(rs.getString("prioridad"));
                dto.setEstado(rs.getString("estado"));
                dto.setTipoPersona(rs.getString("tipo_persona"));
                dto.setJornada(rs.getString("jornada") != null ? rs.getString("jornada") : "Noche");
                lista.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
}
