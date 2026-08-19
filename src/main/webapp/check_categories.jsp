<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Categorías en BD</title>
</head>
<body>
    <h2>Lista de Categorías</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mesaayuda", "root", "Sena2026*")) {
                    try (PreparedStatement ps = cn.prepareStatement("SELECT id, nombre FROM categoria")) {
                        try (ResultSet rs = ps.executeQuery()) {
                            while(rs.next()) {
                                %>
                                <tr>
                                    <td><%= rs.getInt("id") %></td>
                                    <td><%= rs.getString("nombre") %></td>
                                </tr>
                                <%
                            }
                        }
                    }
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
