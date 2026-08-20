<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, co.edu.sena.mesa.modelo.Categoria" %>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
%>
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
        <% for (Categoria categoria : categorias) { %>
            <tr>
                <td><%= categoria.getId() %></td>
                <td><%= categoria.getNombre() %></td>
            </tr>
        <% } %>
    </table>
</body>
</html>
