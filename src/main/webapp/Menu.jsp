<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Carga de Fuentes e Íconos -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>

<aside class="w-72 bg-white border-r border-zinc-200 flex flex-col justify-between h-screen sticky top-0 z-40 shrink-0 shadow-lg transition-all duration-300">
    <div class="flex flex-col gap-6 p-5">

        <!-- Logo y Header institucional -->
        <div class="flex items-center gap-3.5 px-3 py-2.5 bg-emerald-50 rounded-2xl border border-emerald-100 shadow-sm">
            <div class="w-10 h-10 rounded-xl bg-white flex items-center justify-center p-1.5 shadow-sm shrink-0 border border-emerald-100">
                <img alt="SENA Logo" class="h-full w-auto object-contain" src="https://commondatastorage.googleapis.com/codesign-sena-bucket/logo-sena-verde.png"/>
            </div>
            <div class="flex flex-col min-w-0">
                <span class="text-xs font-semibold tracking-wider text-emerald-700 uppercase">SENA</span>
                <span class="text-base font-bold text-zinc-900 leading-tight truncate">Mesa de Ayuda</span>
            </div>
        </div>

        <!-- Obtener el Rol desde la sesión -->
        <c:set var="rolActual" value="${not empty sessionScope.rolUsuario ? sessionScope.rolUsuario : sessionScope.usuario.rol}" />

        <!-- Opciones de Navegación según Rol -->
        <nav class="flex flex-col gap-1.5">
            <span class="px-3 text-xs font-semibold tracking-wider text-zinc-400 uppercase mb-1">Menú Principal</span>

            <c:choose>
                <%-- 1. APRENDIZ  --%>
                <c:when test="${rolActual == 'APRENDIZ'}">
                    <a href="${pageContext.request.contextPath}/tickets/registrar" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">add_circle</span>
                        <span>Crear Solicitud</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">confirmation_number</span>
                        <span>Mis Solicitudes</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">notifications</span>
                        <span>Notificaciones</span>
                    </a>
                </c:when>
                <%-- FUNCIONARIO --%>
               <c:when test="${rolActual == 'FUNCIONARIO'}">
                    <a href="${pageContext.request.contextPath}/tickets/registrar/Funcionarior" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">add_circle</span>
                        <span>Crear Solicitud</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">confirmation_number</span>
                        <span>Mis Solicitudes</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">notifications</span>
                        <span>Notificaciones</span>
                    </a>
                </c:when>

                <%-- 2. AGENTE --%>
                <c:when test="${rolActual == 'AGENTE'}">
                    <a href="${pageContext.request.contextPath}/AgenteTickets.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">inbox</span>
                        <span>Tickets Asignados</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/AgenteTickets.jsp?filter=atender" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">support_agent</span>
                        <span>Atender Tickets</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/AgenteTickets.jsp?filter=historial" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">task_alt</span>
                        <span>Historial</span>

                    <a href="${pageContext.request.contextPath}/historial-resueltos.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">task_alt</span>
                        <span>Resueltos</span>
                    </a>
                </c:when>

                <%-- 3. ADMIN --%>
                <c:when test="${rolActual == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/tickets" 

                    <a href="${pageContext.request.contextPath}/AdminTickets.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">confirmation_number</span>
                        <span>Gestión de Tickets</span>
                    </a>


                    <a href="${pageContext.request.contextPath}/admin/reasignar-agentes" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">swap_horiz</span>
                        <span>Reasignar Agentes</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/reportes" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">query_stats</span>
                        <span>Reportes</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/usuarios" 

                    <a href="${pageContext.request.contextPath}/usuarios.jsp" 
                       class="flex items-center gap-3.5 px-4 py-3 rounded-xl text-sm font-medium text-zinc-700 hover:bg-emerald-50 hover:text-emerald-700 transition-all group">
                        <span class="material-symbols-outlined text-emerald-600 group-hover:scale-110 transition-transform">group</span>
                        <span>Gestión Usuarios</span>
                    </a>
                </c:when>
            </c:choose>
        </nav>
    </div>

    <!-- Usuario Activo y Logout -->
    <div class="p-4 border-t border-zinc-200 flex flex-col gap-3 bg-zinc-50">
        <div class="flex items-center gap-3 px-2 py-1">
            <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-emerald-600 to-emerald-500 text-white flex items-center justify-center font-bold text-sm shadow-md shadow-emerald-600/20 shrink-0">
                ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre.substring(0,2).toUpperCase() : 'US'}
            </div>
            <div class="flex flex-col min-w-0">
                <span class="text-sm font-semibold text-zinc-900 truncate">
                    ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre : 'Usuario SENA'}
                </span>
                <span class="text-xs font-medium text-emerald-600 uppercase tracking-wide">
                    ${not empty rolActual ? rolActual : 'INVITADO'}
                </span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="flex items-center justify-center gap-2.5 px-4 py-2.5 rounded-xl text-sm font-semibold text-rose-600 bg-rose-50 hover:bg-rose-100 transition-colors shadow-sm">
            <span class="material-symbols-outlined text-rose-500 text-lg">logout</span>
            <span>Cerrar sesión</span>
        </a>
    </div>
</aside>