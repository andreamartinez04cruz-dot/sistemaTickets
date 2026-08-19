package co.edu.sena.mesa.web;

import co.edu.sena.mesa.config.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/admin/usuarios", "/admin/usuariosList"})
public class AdminUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/iniciosesion.jsp");
            return;
        }

        List<Map<String, Object>> gestores = new ArrayList<>();
        String sql = "SELECT u.id, CONCAT(u.nombre, ' ', u.apellido) AS nombre, u.correo, r.tipoRol AS rol "
                + "FROM usuario u "
                + "INNER JOIN rolusuario ru ON ru.idUsuario = u.id "
                + "INNER JOIN rol r ON r.id = ru.idRol "
                + "WHERE LOWER(r.tipoRol) LIKE '%agente%' "
                + "ORDER BY r.tipoRol ASC, u.nombre ASC";

        try (Connection cn = ConexionBD.obtenerConexion();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> gestor = new HashMap<>();
                gestor.put("id", rs.getInt("id"));
                gestor.put("nombre", rs.getString("nombre"));
                gestor.put("correo", rs.getString("correo"));
                gestor.put("rol", rs.getString("rol"));
                gestores.add(gestor);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("gestores", gestores);
        request.getRequestDispatcher("/usuarios.jsp").forward(request, response);
    }
}
