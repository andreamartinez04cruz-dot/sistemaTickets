<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <%= request.getAttribute("message") %>
        </p>
        <a href="${pageContext.request.contextPath}/agente/tickets"
           class="inline-block bg-emerald-500 hover:bg-emerald-600 text-white font-semibold px-6 py-3 rounded-xl shadow-sm transition-colors text-sm">
            Volver a Tickets Asignados
        </a>
    </div>
</body>
</html>
