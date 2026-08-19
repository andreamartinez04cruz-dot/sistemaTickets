<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mesaayuda", "root", "Sena2026*")) {
            
            // 1. Resetear ticket 5 a ASIGNADO
            try (PreparedStatement ps1 = cn.prepareStatement("UPDATE ticket SET estado = 'ASIGNADO' WHERE id = 5")) {
                ps1.executeUpdate();
            }
            
            // 2. Resetear ticket 3 a EN PROCESO
            try (PreparedStatement ps2 = cn.prepareStatement("UPDATE ticket SET estado = 'EN PROCESO' WHERE id = 3")) {
                ps2.executeUpdate();
            }
            
            // 3. Resetear ticket 2 a ASIGNADO
            try (PreparedStatement ps3 = cn.prepareStatement("UPDATE ticket SET estado = 'ASIGNADO' WHERE id = 2")) {
                ps3.executeUpdate();
            }
            
            message = "¡Estados de tickets reseteados con éxito! <br/><br/>"
                    + "• Ticket #5 cambiado a ASIGNADO (para que pruebes pasarlo a EN PROCESO o RESUELTO)<br/>"
                    + "• Ticket #3 cambiado a EN PROCESO (para que pruebes pasarlo a RESUELTO)<br/>"
                    + "• Ticket #2 cambiado a ASIGNADO (para que pruebes todo su ciclo de vida desde cero)";
        }
    } catch (Exception e) {
        message = "Hubo un error al resetear los estados: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reseteo de Tickets de Prueba</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen flex items-center justify-center p-6 text-slate-800">
    <div class="max-w-md w-full bg-white rounded-2xl border border-emerald-100 shadow-lg p-8 text-center">
        <div class="w-16 h-16 rounded-full bg-emerald-50 text-emerald-600 flex items-center justify-center mx-auto mb-6">
            <span class="material-symbols-outlined text-4xl" style="font-family: 'Material Symbols Outlined';">restart_alt</span>
        </div>
        <h2 class="text-2xl font-bold text-gray-900 mb-4">Reseteo de Base de Datos</h2>
        <p class="text-sm text-gray-600 leading-relaxed font-medium mb-6">
            <%= message %>
        </p>
        <a href="${pageContext.request.contextPath}/AgenteTickets.jsp" 
           class="inline-block bg-emerald-500 hover:bg-emerald-600 text-white font-semibold px-6 py-3 rounded-xl shadow-sm transition-colors text-sm">
            Volver a Tickets Asignados
        </a>
    </div>
</body>
</html>
