<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Carga de Fuentes e Íconos -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>

<aside class="w-64 bg-surface dark:bg-surface-dim border-r border-outline-variant flex flex-col justify-between h-screen sticky top-0 z-40 shrink-0 shadow-sm">
    <div class="flex flex-col gap-6 p-4">
        <!-- Logo -->
        <div class="flex items-center gap-3 px-2 pt-2">
            <img alt="SENA Logo" class="h-9 w-auto" src="https://lh3.googleusercontent.com/aida/AP1WRLsgqsUoGT-2lwimwLtDM221DxP7NWvos4EH-jZO44clebvSs4G9xkk3qy5_sx5r-gM4QaISpEHQdi6MkDmZJjlCouJfjc7cqoB6IKxC6KqhF6otdPBmlirkRXwoftCPtJGBQyj1RHApkoKcCsMv5ZBZUKFMbmvqfkr06yOy5bowvIO_D_snGIHh_9WJluN-wBVSCTX9wmiL-2HUR0a5qth3wQ7dWYpJoACf7PPvRziZydOgCWGfP1eakb0"/>
            <span class="font-headline-md text-xl font-bold text-primary dark:text-primary-fixed-dim leading-tight">Mesa de Ayuda</span>
        </div>

        <!-- Obtener el Rol desde la sesión -->
        <c:set var="rolActual" value="${not empty sessionScope.rolUsuario ? sessionScope.rolUsuario : sessionScope.usuario.rol}" />

        <!-- Opciones de Navegación según Rol -->
        <nav class="flex flex-col gap-1">
            <c:choose>
                <%-- 1. APRENDIZ / FUNCIONARIO --%>
                <c:when test="${rolActual == 'APRENDIZ'}">
                    <!--  Apunta al Servlet para cargar las categorías antes de mostrar el formulario -->
                    <a href="${pageContext.request.contextPath}/tickets/registrar" 
                       class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">add_circle</span>
                        <span class="font-medium">Crear Solicitud</span>
                    </a>

                    <!-- ✅Apunta al Servlet con la acción historial -->
                    <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" 
                       class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">confirmation_number</span>
                        <span class="font-medium">Mis Solicitudes</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" 
                       class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">notifications</span>
                        <span class="font-medium">Notificaciones</span>
                    </a>
                </c:when>
                <c:when test="${rolActual == 'FUNCIONARIO'}">
                    <a href="${pageContext.request.contextPath}/tickets/registrar" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">add_circle</span>
                        <span class="font-medium">Crear Solicitud</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">confirmation_number</span>
                        <span class="font-medium">Mis Solicitudes</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">notifications</span>
                        <span class="font-medium">Notificaciones</span>
                    </a>
                </c:when>

                <%-- 2. AGENTE --%>
                <c:when test="${rolActual == 'AGENTE'}">
                    <a href="${pageContext.request.contextPath}/AgenteTickets.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">inbox</span>
                        <span class="font-medium">Tickets Asignados</span>
                    </a>

                    <a href="${pageContext.request.contextPath}/historial-resueltos.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">task_alt</span>
                        <span class="font-medium">Resueltos</span>
                    </a>
                </c:when>

                <%-- 3. ADMIN (Default) --%>
                <c:when test="${rolActual == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/AdminTickets.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">confirmation_number</span>
                        <span class="font-medium">Gestión de Tickets</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/usuarios.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg text-body-md text-on-surface hover:bg-surface-container-high transition-colors">
                        <span class="material-symbols-outlined text-primary">group</span>
                        <span class="font-medium">Gestión Usuarios</span>
                    </a>
                </c:when>
            </c:choose>
        </nav>
    </div>

    <!-- Usuario Activo y Logout -->
    <div class="p-4 border-t border-outline-variant flex flex-col gap-2 bg-surface-container-lowest">
        <div class="flex items-center gap-3 px-2 py-1">
            <div class="w-9 h-9 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm shadow-sm shrink-0">
                ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre.substring(0,2).toUpperCase() : 'US'}
            </div>
            <div class="flex flex-col min-w-0">
                <span class="font-label-md font-bold text-on-surface truncate">
                    ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre : 'Usuario SENA'}
                </span>
                <span class="font-label-sm text-secondary truncate">
                    ${not empty rolActual ? rolActual : 'INVITADO'}
                </span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/logout" class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-body-md text-error hover:bg-error-container/20 transition-colors mt-1">
            <span class="material-symbols-outlined text-error">logout</span>
            <span class="font-medium">Cerrar sesión</span>
        </a>
    </div>
</aside>