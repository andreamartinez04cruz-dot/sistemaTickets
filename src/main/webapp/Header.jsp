<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Header superior estandarizado institucional - Mejorado -->
<header class="w-full flex justify-between items-center px-8 h-16 bg-gradient-to-r from-white via-white to-emerald-50 shadow-md border-b-2 border-emerald-200 sticky top-0 z-30">
    <div class="flex items-center gap-3">
        <div class="w-10 h-10 rounded-lg bg-gradient-to-br from-[#073a1e] to-[#1b5e20] p-2 flex items-center justify-center shadow-lg">
            <span class="material-symbols-outlined text-white text-lg font-bold">support_agent</span>
        </div>
        <h1 class="text-xl font-bold bg-gradient-to-r from-[#073a1e] to-[#1b5e20] bg-clip-text text-transparent flex items-center gap-2">
            SENA - Mesa de Ayuda
        </h1>
    </div>
    <div class="flex items-center gap-4">
        <a href="${pageContext.request.contextPath}/Notificaciones.jsp" class="p-2.5 text-[#073a1e] hover:bg-emerald-100 rounded-full transition-all duration-300 relative hover:scale-110" title="Notificaciones">
            <span class="material-symbols-outlined text-2xl">notifications</span>
            <span class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-red-500 rounded-full animate-pulse"></span>
        </a>
        <div class="w-10 h-10 rounded-full bg-gradient-to-br from-[#39a900] to-[#2d8c00] text-white font-bold flex items-center justify-center text-sm shadow-lg border-2 border-white hover:shadow-xl transition-all duration-300" title="Perfil">
            ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre.substring(0,2).toUpperCase() : 'US'}
        </div>
    </div>
</header>
