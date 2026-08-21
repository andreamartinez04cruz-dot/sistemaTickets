package co.edu.sena.mesa.mapper;

import co.edu.sena.mesa.dto.AdminTicketDTO;
import java.sql.ResultSet;
import java.sql.SQLException;

public final class AdminTicketMapper {

    private AdminTicketMapper() {
    }

    public static AdminTicketDTO toDTO(ResultSet resultSet, boolean esAprendiz) throws SQLException {
        AdminTicketDTO dto = new AdminTicketDTO();
        dto.setId(resultSet.getInt("id"));
        dto.setTitulo(resultSet.getString("titulo"));
        dto.setDescripcion(resultSet.getString("descripcion"));
        dto.setCategoria(resultSet.getString("categoria"));
        dto.setPrioridad(resultSet.getString("prioridad"));
        dto.setEstado(resultSet.getString("estado"));
        dto.setTipoPersona(resultSet.getString("tipo_persona"));
        dto.setJornada(resultSet.getString("jornada"));

        if (esAprendiz) {
            dto.setNombreAprendiz(resultSet.getString("nombre_aprendiz"));
            dto.setPrograma(resultSet.getString("programa"));
            dto.setNumeroPrograma(resultSet.getObject("numero_programa") != null
                    ? resultSet.getInt("numero_programa") : null);
            dto.setInstructorCargo(formatearInstructor(
                    resultSet.getString("nombre_instructor"),
                    resultSet.getString("apellido_instructor")));
        } else {
            dto.setNombreFuncionario(resultSet.getString("nombre_funcionario"));
            dto.setRol(resultSet.getString("rol"));
        }

        return dto;
    }

    private static String formatearInstructor(String nombre, String apellido) {
        String nombreSeguro = nombre == null ? "" : nombre;
        String apellidoSeguro = apellido == null || apellido.isEmpty() ? "" : " " + apellido;
        return nombreSeguro + apellidoSeguro;
    }
}
