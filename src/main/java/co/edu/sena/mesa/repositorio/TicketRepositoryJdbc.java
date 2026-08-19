package co.edu.sena.mesa.repositorio;

import co.edu.sena.mesa.config.ConexionBD;
import co.edu.sena.mesa.modelo.Categoria;
import co.edu.sena.mesa.modelo.Comentario;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.modelo.estado.EstadoAsignado;
import co.edu.sena.mesa.modelo.estado.EstadoCancelado;
import co.edu.sena.mesa.modelo.estado.EstadoCerrado;
import co.edu.sena.mesa.modelo.estado.EstadoEnProceso;
import co.edu.sena.mesa.modelo.estado.EstadoNuevo;
import co.edu.sena.mesa.modelo.estado.EstadoResuelto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class TicketRepositoryJdbc implements TicketRepository {

    //  Ejecutar el INSERT en MySQL  Doris
    @Override
    public Ticket guardar(Ticket ticket) {

        String sql = "INSERT INTO ticket "
                + "(titulo, descripcion, idCategoria, idPrioridad, "
                + "idUsuario, estado, fechaCreacion) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = ConexionBD.obtenerConexion(); PreparedStatement statement = conexion.prepareStatement(
                sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, ticket.getTitulo());
            statement.setString(2, ticket.getDescripcion());
            statement.setLong(3, ticket.getCategoria().getId());
            statement.setLong(4, ticket.getPrioridad().getId());
            statement.setLong(5, ticket.getSolicitante().getId());
            statement.setString(6, ticket.getEstadoNombre());
            statement.setTimestamp(
                    7,
                    java.sql.Timestamp.valueOf(
                            ticket.getFechaCreacion()
                    )
            );

            statement.executeUpdate();

            try (ResultSet resultado = statement.getGeneratedKeys()) {
                if (resultado.next()) {
                    ticket.setId(resultado.getInt(1));
                }
            }

            return ticket;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error al registrar el ticket", e
            );
        }
    }

    @Override
    public void TicketFuncionario(Ticket ticket, int idSolicitante) {

        System.out.println("ENTRO A TicketFuncionario");

        String sqlTicket = "INSERT INTO ticket "
                + "(titulo, descripcion, idCategoria, idPrioridad, idUsuario, estado, fechaCreacion, programa, numeroPrograma, instructor, jornada) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexion = ConexionBD.obtenerConexion();
             PreparedStatement ps = conexion.prepareStatement(
                     sqlTicket,
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, ticket.getTitulo());
            ps.setString(2, ticket.getDescripcion());
            ps.setLong(3, ticket.getCategoria().getId());
            ps.setLong(4, ticket.getPrioridad().getId());
            ps.setLong(5, idSolicitante);
            ps.setString(6, ticket.getEstadoNombre());
            ps.setTimestamp(7, java.sql.Timestamp.valueOf(ticket.getFechaCreacion()));
            ps.setString(8, ticket.getPrograma());
            ps.setString(9, ticket.getNumeroPrograma());
            ps.setString(10, ticket.getInstructor());
            ps.setString(11, ticket.getJornada());

            ps.executeUpdate();

            System.out.println("TICKET INSERTADO");

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    long idTicket = rs.getLong(1);
                    System.out.println("ID TICKET GENERADO: " + idTicket);
                    ticket.setId((int) idTicket);
                } else {
                    throw new SQLException("No se pudo obtener el ID del ticket");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al registrar ticket", e);
        }
    }

    public List<Categoria> listarCategorias() {

        String sql = "SELECT * FROM categoria";

        List<Categoria> categorias = new ArrayList<>();

        try (Connection cn = ConexionBD.obtenerConexion(); PreparedStatement ps = cn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Categoria categoria = new Categoria();

                categoria.setId(rs.getInt("id"));
                categoria.setNombre(rs.getString("nombre"));

                categorias.add(categoria);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categorias;
    }

    @Override
    public List<Ticket> buscarSolicitantePorId(int solicitanteId) {

        List<Ticket> tickets = new ArrayList<>();

        String sql = "SELECT t.id, t.titulo, t.descripcion, t.estado, t.fechaCreacion, "
                + "c.nombre AS categoria "
                + "FROM ticket t "
                + "INNER JOIN categoria c ON t.idCategoria = c.id "
                + "WHERE t.idUsuario = ?";

        try (Connection conn = ConexionBD.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, solicitanteId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Ticket ticket = new Ticket();

                    ticket.setId(rs.getInt("id"));
                    ticket.setTitulo(rs.getString("titulo"));
                    ticket.setDescripcion(rs.getString("descripcion"));

                    // Si tu clase Ticket tiene estos atributos/getters,
                    // también es recomendable cargarlos:
                    // ESTADO
                    String estadoBD = rs.getString("estado");

                    if ("NUEVO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoNuevo());

                    } else if ("ASIGNADO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoAsignado());

                    } else if ("EN_PROCESO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoEnProceso());

                    } else if ("RESUELTO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoResuelto());

                    } else if ("CERRADO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoCerrado());

                    } else if ("CANCELADO".equalsIgnoreCase(estadoBD)) {
                        ticket.setEsatdo(new EstadoCancelado());
                    }
                    ticket.setFechaCreacion(
                            rs.getTimestamp("fechaCreacion").toLocalDateTime()
                    );
                    // CATEGORÍA
                    Categoria categoria = new Categoria();
                    categoria.setNombre(rs.getString("categoria"));
                    ticket.setCategoria(categoria);

                    tickets.add(ticket);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return tickets;

    }

    //GUARDAR Y MOSTRAR COMENTARIOS
    @Override
    public void guardar(Comentario comentario, int idTicket) {
        String sqlComentario = "INSERT INTO comentario (idUsuario, texto, fecha) VALUES (?, ?, ?)";
        String sqlUpdateTicket = "UPDATE ticket SET idComentario = ? WHERE id = ?";

        Connection conn = null;
        try {
            conn = ConexionBD.obtenerConexion();
            // Desactivar autocommit para manejar una transacción segura
            conn.setAutoCommit(false);

            // 1. Insertar el comentario y obtener el ID generado
            try (PreparedStatement psComentario = conn.prepareStatement(sqlComentario, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psComentario.setInt(1, comentario.getUsuario().getId());
                psComentario.setString(2, comentario.getTexto());
                psComentario.setTimestamp(3, Timestamp.valueOf(comentario.getFecha()));
                psComentario.executeUpdate();

                // Recuperar el ID autogenerado del comentario
                try (ResultSet rsKeys = psComentario.getGeneratedKeys()) {
                    if (rsKeys.next()) {
                        int idComentarioGenerado = rsKeys.getInt(1);

                        // 2. Actualizar la tabla ticket con el idComentario
                        try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateTicket)) {
                            psUpdate.setInt(1, idComentarioGenerado);
                            psUpdate.setInt(2, idTicket);
                            psUpdate.executeUpdate();
                        }
                    }
                }
            }

            // Confirmar transacción
            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Si algo falla, deshacemos los cambios
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public List<Comentario> obtenerComentariosPorTicket(int idTicket) {
        List<Comentario> comentarios = new ArrayList<>();

        // Si la relación ticket-comentario es por idComentario o idTicket:
        String sql = "SELECT c.id, c.texto, c.fecha, u.id AS id_usuario, u.nombre AS nombre_usuario "
                + "FROM ticket t "
                + "INNER JOIN comentario c ON t.idComentario = c.id "
                + "INNER JOIN usuario u ON c.idUsuario = u.id "
                + "WHERE t.id = ? "
                + "ORDER BY c.fecha ASC";
        try (Connection conn = ConexionBD.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idTicket);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId(rs.getInt("id_usuario"));
                    usuario.setNombre(rs.getString("nombre_usuario"));

                    Comentario comentario = new Comentario();
                    comentario.setId(rs.getInt("id"));
                    comentario.setTexto(rs.getString("texto"));

                    if (rs.getDate("fecha") != null) {
                        comentario.setFecha(rs.getDate("fecha").toLocalDate().atStartOfDay());
                    }
                    comentario.setUsuario(usuario);

                    comentarios.add(comentario);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comentarios;
    }
    //id

    @Override
    public Ticket obtenerPorId(int idTicket) {

        Ticket ticket = null;

        String sql = "SELECT "
                + "t.id, "
                + "t.titulo, "
                + "t.descripcion, "
                + "t.estado, "
                + "t.fechaCreacion, "
                + "c.id AS id_categoria, "
                + "c.nombre AS nombre_categoria, "
                + "p.id AS id_prioridad, "
                + "p.tipoPrioridad AS nombre_prioridad, "
                + "u.id AS id_usuario, "
                + "u.nombre AS nombre_usuario, "
                + "u.correo AS correo_usuario "
                + "FROM ticket t "
                + "LEFT JOIN usuario u ON t.idUsuario = u.id "
                + "LEFT JOIN categoria c ON t.idCategoria = c.id "
                + "LEFT JOIN prioridad p ON t.idPrioridad = p.id "
                + "WHERE t.id = ?";

        try (
                Connection conn = ConexionBD.obtenerConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idTicket);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    ticket = new Ticket();

                    // =========================
                    // DATOS DEL TICKET
                    // =========================
                    ticket.setId(rs.getInt("id"));

                    ticket.setTitulo(
                            rs.getString("titulo")
                    );

                    ticket.setDescripcion(
                            rs.getString("descripcion")
                    );

                    // =========================
                    // CATEGORIA
                    // =========================
                    Categoria categoria = new Categoria();

                    categoria.setId(
                            rs.getInt("id_categoria")
                    );

                    categoria.setNombre(
                            rs.getString("nombre_categoria")
                    );

                    ticket.setCategoria(categoria);

                    // =========================
                    // ESTADO
                    // =========================
                    String estadoBD
                            = rs.getString("estado");

                    if ("NUEVO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoNuevo()
                        );

                    } else if ("ASIGNADO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoAsignado()
                        );

                    } else if ("EN_PROCESO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoEnProceso()
                        );

                    } else if ("RESUELTO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoResuelto()
                        );

                    } else if ("CERRADO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoCerrado()
                        );

                    } else if ("CANCELADO".equalsIgnoreCase(estadoBD)) {

                        ticket.setEsatdo(
                                new EstadoCancelado()
                        );
                    }
                    // =========================
                    // FECHA
                    // =========================

                    if (rs.getTimestamp("fechaCreacion") != null) {

                        ticket.setFechaCreacion(
                                rs.getTimestamp("fechaCreacion")
                                        .toLocalDateTime()
                        );
                    }
                    // =========================
                    // SOLICITANTE
                    // =========================
                    Usuario usuario = new Usuario();

                    usuario.setId(
                            rs.getInt("id_usuario")
                    );

                    usuario.setNombre(
                            rs.getString("nombre_usuario")
                    );

                    usuario.setCorreo(
                            rs.getString("correo_usuario")
                    );

                    ticket.setSolicitante(usuario);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ticket;
    }
}
