<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Carga de Fuentes e Íconos -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>

<!-- Estilos Globales Mejorados - Paleta de Colores SENA Profesional -->
<style>
    /* ========== VARIABLES DE COLOR ========== */
    :root {
        --sena-dark: #073a1e;           /* Verde oscuro principal */
        --sena-medium: #1b5e20;         /* Verde medio */
        --sena-light: #39a900;          /* Verde claro/manzana */
        --sena-lighter: #dcfce7;        /* Verde muy claro de fondo */
        --sena-border: #a5d6a7;         /* Verde borde */
        --white: #ffffff;
        --bg-light: #f4fbf7;            /* Fondo muy claro verdoso */
        --text-light: rgba(7, 58, 30, 0.7);
    }

    /* ========== ESTILOS GLOBALES DEL BODY ========== */
    body {
        font-family: 'Work Sans', sans-serif !important;
        background-color: var(--bg-light) !important;
        color: var(--sena-dark) !important;
        margin: 0;
        padding: 0;
    }

    /* ========== SIDEBAR MEJORADO ========== */
    aside, .sena-sidebar {
        background: linear-gradient(135deg, #c8e6c9 0%, #a5d6a7 100%) !important;
        border-color: rgba(7, 58, 30, 0.1) !important;
        box-shadow: 2px 0 12px rgba(0, 0, 0, 0.08) !important;
    }

    /* Texto en el sidebar - Todo a verde oscuro */
    aside, .sena-sidebar {
        color: #073a1e !important;
    }

    .sena-sidebar * {
        color: #073a1e !important;
    }

    .sena-sidebar h1, 
    .sena-sidebar h2, 
    .sena-sidebar h3,
    .sena-sidebar span {
        color: #073a1e !important;
    }

    .sena-sidebar .text-white,
    .sena-sidebar .text-emerald-100,
    .sena-sidebar .text-emerald-300,
    .sena-sidebar .text-emerald-400 {
        color: #073a1e !important;
    }

    /* Encabezados y títulos */
    h1, h2, h3, h4, h5, h6,
    .text-primary, .text-emerald-800, .text-emerald-700, .text-green-800,
    .text-gray-900, .text-slate-900, .text-gray-800, .text-slate-800 {
        color: var(--sena-dark) !important;
        font-weight: 600 !important;
    }

    /* Textos secundarios */
    .text-emerald-600, .text-green-600, .text-emerald-500, .text-green-700,
    .text-gray-700, .text-slate-700 {
        color: var(--sena-medium) !important;
    }

    /* Textos mudos */
    .text-gray-500, .text-slate-500, .text-gray-400, .text-slate-400 {
        color: var(--text-light) !important;
    }

    /* ========== BOTONES PRINCIPALES ========== */
    .bg-primary, .bg-emerald-500, .bg-green-600, .bg-emerald-600,
    button[type="submit"], .btn-sena-primary,
    a.bg-emerald-500, a.bg-green-600, a.bg-emerald-600 {
        background: linear-gradient(135deg, #073a1e 0%, #1b5e20 100%) !important;
        color: var(--white) !important;
        border-radius: 0.75rem !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        border: none !important;
        font-weight: 600 !important;
    }

    .bg-primary:hover, .bg-emerald-500:hover, .bg-green-600:hover, .bg-emerald-600:hover,
    button[type="submit"]:hover, .btn-sena-primary:hover,
    a.bg-emerald-500:hover, a.bg-green-600:hover, a.bg-emerald-600:hover {
        background: linear-gradient(135deg, #1b5e20 0%, #0a4d26 100%) !important;
        box-shadow: 0 8px 16px rgba(7, 58, 30, 0.25) !important;
        transform: translateY(-2px) !important;
    }

    /* ========== FONDOS Y TARJETAS ========== */
    .bg-emerald-50, .bg-green-50, .bg-emerald-50\/20, .bg-green-50\/20,
    .bg-gradient-to-r.from-emerald-50.to-green-50\/20 {
        background: linear-gradient(135deg, #f0f9f4 0%, #e8f5e9 100%) !important;
        border: 1px solid var(--sena-border) !important;
    }

    /* ========== BORDES ========== */
    .border-emerald-100, .border-green-100, .border-emerald-100\/70,
    .border-gray-200, .border-slate-200, .border-outline-variant, .border-gray-300 {
        border-color: #c8e6c9 !important;
    }

    /* ========== TABLAS ========== */
    thead, thead tr, .bg-slate-100, .bg-gray-100, .bg-slate-50, .bg-gray-50 {
        background: linear-gradient(135deg, #e8f5e9 0%, #f0f9f4 100%) !important;
        color: var(--sena-dark) !important;
    }

    tbody tr:hover {
        background-color: #f0f9f4 !important;
    }

    /* ========== EFECTOS DE HOVER EN TARJETAS ========== */
    .hover\:border-blue-300:hover, .hover\:border-emerald-300:hover, .hover\:border-green-300:hover {
        border-color: var(--sena-light) !important;
    }

    /* ========== ANIMACIONES ========== */
    .chevron-icon {
        transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* ========== SCROLLBAR PERSONALIZADO ========== */
    .sena-sidebar::-webkit-scrollbar {
        width: 6px;
    }
    .sena-sidebar::-webkit-scrollbar-track {
        background-color: rgba(7, 58, 30, 0.05);
    }
    .sena-sidebar::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, rgba(7, 58, 30, 0.3), rgba(7, 58, 30, 0.15));
        border-radius: 3px;
    }
    .sena-sidebar::-webkit-scrollbar-thumb:hover {
        background: rgba(7, 58, 30, 0.4);
    }

    /* ========== HEADER MEJORADO ========== */
    header, .top-bar, .bg-surface.shadow-sm.border-b.border-outline-variant {
        background: linear-gradient(90deg, #ffffff 0%, #f8fffe 100%) !important;
        border-bottom: 2px solid #c8e6c9 !important;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06) !important;
        height: 4rem !important;
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        padding-left: 1.5rem !important;
        padding-right: 1.5rem !important;
        position: sticky !important;
        top: 0 !important;
        z-index: 30 !important;
    }

    header h1, header h2, .top-bar h1, .top-bar h2,
    header span.material-symbols-outlined, .top-bar span.material-symbols-outlined {
        color: var(--sena-dark) !important;
        font-family: 'Work Sans', sans-serif !important;
    }

    header .w-8.h-8, header .w-9.h-9,
    header div[class*="rounded-full"],
    .top-bar div[class*="rounded-full"] {
        background: linear-gradient(135deg, #39a900 0%, #2d8c00 100%) !important;
        color: var(--white) !important;
        box-shadow: 0 3px 8px rgba(57, 169, 0, 0.3) !important;
        border: 2px solid rgba(255, 255, 255, 0.3);
    }

    /* ========== ESTILOS DE MENÚ MEJORADOS ========== */
    .menu-toggle {
        background-color: transparent !important;
        border: 1px solid rgba(7, 58, 30, 0.15) !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        font-size: 0.95rem !important;
        letter-spacing: 0.3px !important;
        color: #073a1e !important;
    }

    .menu-toggle:hover {
        background: linear-gradient(90deg, rgba(7, 58, 30, 0.1), rgba(7, 58, 30, 0.05)) !important;
        border-color: rgba(7, 58, 30, 0.3) !important;
        color: #073a1e !important;
        box-shadow: inset 0 1px 3px rgba(7, 58, 30, 0.1) !important;
        transform: translateX(4px) !important;
    }

    .menu-toggle span.material-symbols-outlined {
        color: #39a900 !important;
        font-weight: bold !important;
    }

    /* ========== ESTILOS DE SUBMENÚS MEJORADOS ========== */
    .menu-toggle + div {
        background: linear-gradient(135deg, rgba(220, 252, 231, 0.95), rgba(200, 230, 201, 0.90)) !important;
        border: 2px solid #a5d6a7 !important;
        border-radius: 0.875rem !important;
        box-shadow: 0 4px 12px rgba(7, 58, 30, 0.08), inset 0 1px 2px rgba(255, 255, 255, 0.5) !important;
        backdrop-filter: blur(8px) !important;
    }

    .menu-toggle + div a {
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
        font-weight: 600 !important;
        position: relative !important;
    }

    .menu-toggle + div a:hover {
        background: linear-gradient(90deg, #bbf7d0, #a5d6a7) !important;
        color: #0b3a1a !important;
        padding-left: 1rem !important;
        box-shadow: 0 2px 6px rgba(7, 58, 30, 0.1) !important;
    }

    .menu-toggle + div a span.w-1\\.5.h-1\\.5 {
        box-shadow: 0 2px 4px rgba(57, 169, 0, 0.3) !important;
        transition: all 0.2s ease !important;
    }

    .menu-toggle + div a:hover span.w-1\\.5.h-1\\.5 {
        transform: scale(1.3) !important;
        box-shadow: 0 4px 8px rgba(57, 169, 0, 0.5) !important;
    }
</style>

<aside class="sena-sidebar w-72 text-[#073a1e] flex flex-col justify-between h-screen sticky top-0 z-40 shrink-0 shadow-2xl border-r-2 border-[#a5d6a7] overflow-y-auto">
    <div class="flex flex-col gap-8 p-6">
        <!-- Logo Institucional con Diseño Mejorado -->
        <div class="flex items-center gap-4 px-3 py-4 bg-gradient-to-r from-white/30 to-transparent rounded-2xl border border-[#a5d6a7] hover:border-[#73c69d] transition-all duration-300">
            <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-white to-emerald-100 p-2 flex items-center justify-center shadow-lg shrink-0">
                <img alt="SENA Logo" class="h-full w-auto object-contain" src="https://oferta.senasofiaplus.edu.co/sofia-oferta/images/logoSena.png"/>
            </div>
            <div class="flex flex-col min-w-0">
                <span class="font-bold text-lg text-[#073a1e] tracking-wide leading-tight truncate">Mesa de Ayuda</span>
                <span class="text-xs text-[#1b5e20] font-bold tracking-wider uppercase">SENA 2026</span>
            </div>
        </div>

        <!-- Obtener el Rol desde la sesión -->
        <c:set var="rolActual" value="${not empty sessionScope.rolUsuario ? sessionScope.rolUsuario : sessionScope.usuario.rol}" />

        <!-- Encabezado de Navegación -->
        <div class="px-3 py-2">
            <span class="text-xs font-bold text-[#1b5e20] tracking-wider uppercase">Navegación</span>
        </div>

        <!-- Opciones de Navegación según Rol -->
        <nav class="flex flex-col gap-1.5">
            <c:choose>
                <%-- ==================== 1. APRENDIZ ==================== --%>
                <c:when test="${rolActual == 'APRENDIZ'}">
                    <!-- Grupo: Gestión de Solicitudes -->
                    <div>
                        <button type="button" class="menu-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors" data-target="submenu-solicitudes-ap">
                            <div class="flex items-center gap-3">
                                <span class="material-symbols-outlined text-[#39a900]">confirmation_number</span>
                                <span>Mis Solicitudes</span>
                            </div>
                            <span class="material-symbols-outlined text-sm chevron-icon">keyboard_arrow_down</span>
                        </button>
                        <div id="submenu-solicitudes-ap" class="flex flex-col gap-1 pl-3 pr-2 py-2 mt-1 hidden ml-5 bg-[#dcfce7] rounded-lg border border-[#bbf7d0] shadow-sm">
                            <a href="${pageContext.request.contextPath}/tickets/registrar" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Crear Solicitud</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Mis Solicitudes</span>
                            </a>
                        </div>
                    </div>

                    <!-- Notificaciones Directas -->
                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" 
                       class="flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors">
                        <div class="flex items-center gap-3">
                            <span class="material-symbols-outlined text-[#39a900]">notifications</span>
                            <span>Notificaciones</span>
                        </div>
                    </a>
                </c:when>

                <%-- ==================== 2. FUNCIONARIO ==================== --%>
                <c:when test="${rolActual == 'FUNCIONARIO'}">
                    <!-- Grupo: Gestión de Solicitudes -->
                    <div>
                        <button type="button" class="menu-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors" data-target="submenu-solicitudes-fun">
                            <div class="flex items-center gap-3">
                                <span class="material-symbols-outlined text-[#39a900]">confirmation_number</span>
                                <span>Mis Solicitudes</span>
                            </div>
                            <span class="material-symbols-outlined text-sm chevron-icon">keyboard_arrow_down</span>
                        </button>
                        <div id="submenu-solicitudes-fun" class="flex flex-col gap-1 pl-3 pr-2 py-2 mt-1 hidden ml-5 bg-[#dcfce7] rounded-lg border border-[#bbf7d0] shadow-sm">
                            <a href="${pageContext.request.contextPath}/tickets/registrar" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Crear Solicitud</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/tickets/registrar?action=historial" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Mis Solicitudes</span>
                            </a>
                        </div>
                    </div>

                    <!-- Notificaciones Directas -->
                    <a href="${pageContext.request.contextPath}/Notificaciones.jsp" 
                       class="flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors">
                        <div class="flex items-center gap-3">
                            <span class="material-symbols-outlined text-[#39a900]">notifications</span>
                            <span>Notificaciones</span>
                        </div>
                    </a>
                </c:when>

                <%-- ==================== 3. AGENTE ==================== --%>
                <c:when test="${rolActual == 'AGENTE'}">
                    <div>
                        <button type="button" class="menu-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors" data-target="submenu-agente-tickets">
                            <div class="flex items-center gap-3">
                                <span class="material-symbols-outlined text-[#39a900]">confirmation_number</span>
                                <span>Panel de Tickets</span>
                            </div>
                            <span class="material-symbols-outlined text-sm chevron-icon">keyboard_arrow_down</span>
                        </button>
                        <div id="submenu-agente-tickets" class="flex flex-col gap-1 pl-3 pr-2 py-2 mt-1 hidden ml-5 bg-[#dcfce7] rounded-lg border border-[#bbf7d0] shadow-sm">
                            <a href="${pageContext.request.contextPath}/AgenteTickets.jsp" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Ver tickets</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/AgenteTickets.jsp?filter=atender" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Atender ticket</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/AgenteTickets.jsp?filter=historial" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Ver historial</span>
                            </a>
                        </div>
                    </div>
                </c:when>

                <%-- ==================== 4. ADMIN ==================== --%>
                <c:when test="${rolActual == 'ADMIN'}">
                    <!-- Gestión de Tickets -->
                    <div>
                        <button type="button" class="menu-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors" data-target="submenu-admin-usuarios">
                            <div class="flex items-center gap-3">
                                <span class="material-symbols-outlined text-[#39a900]">confirmation_number</span>
                                <span>Gestión de Tickets</span>
                            </div>
                            <span class="material-symbols-outlined text-sm chevron-icon">keyboard_arrow_down</span>
                        </button>
                        <div id="submenu-admin-tickets" class="flex flex-col gap-1 pl-3 pr-2 py-2 mt-1 hidden ml-5 bg-[#dcfce7] rounded-lg border border-[#bbf7d0] shadow-sm">
                            <a href="${pageContext.request.contextPath}/admin/tickets" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Gestión de Tickets</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/reasignar-agentes" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Reasignar Agentes</span>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/reportes" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Reportes</span>
                            </a>
                        </div>
                    </div>

                    <!-- Gestión de Usuarios -->
                    <div>
                        <button type="button" class="menu-toggle w-full flex items-center justify-between px-3 py-2.5 rounded-lg text-sm font-semibold text-[#073a1e] hover:bg-white/20 hover:text-[#073a1e] transition-colors" data-target="submenu-admin-tickets">
                            <div class="flex items-center gap-3">
                                <span class="material-symbols-outlined text-[#39a900]">admin_panel_settings</span>
                                <span>Administración</span>
                            </div>
                            <span class="material-symbols-outlined text-sm chevron-icon">keyboard_arrow_down</span>
                        </button>
                        <div id="submenu-admin-usuarios" class="flex flex-col gap-1 pl-3 pr-2 py-2 mt-1 hidden ml-5 bg-[#dcfce7] rounded-lg border border-[#bbf7d0] shadow-sm">
                            <a href="${pageContext.request.contextPath}/admin/usuarios" 
                               class="flex items-center gap-2 px-2 py-1.5 rounded-md text-xs font-bold text-[#1b5e20] hover:text-[#0b3a1a] hover:bg-[#bbf7d0]/80 transition-all">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#39a900]"></span>
                                <span>Gestión Usuarios</span>
                            </a>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </nav>
    </div>

    <!-- Usuario Activo y Logout -->
    <div class="p-6 border-t-2 border-[#a5d6a7] flex flex-col gap-4 bg-gradient-to-b from-[#e8f5e9] to-[#dcfce7] backdrop-blur-sm">
        <!-- Tarjeta de Usuario -->
        <div class="flex items-center gap-4 px-4 py-3 rounded-xl bg-gradient-to-r from-white/40 to-white/30 border border-[#a5d6a7] hover:border-[#73c69d] hover:from-white/50 hover:to-white/40 transition-all duration-300">
            <!-- Avatar mejorado -->
            <div class="w-12 h-12 rounded-full bg-gradient-to-br from-[#39a900] to-[#2d8c00] text-white flex items-center justify-center font-bold text-base shadow-lg shrink-0 border-2 border-[#a5d6a7]">
                ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre.substring(0,2).toUpperCase() : 'US'}
            </div>
            <div class="flex flex-col min-w-0 flex-grow">
                <span class="font-bold text-sm text-[#073a1e] truncate leading-tight" title="${sessionScope.usuario.nombre}">
                    ${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre : 'Usuario SENA'}
                </span>
                <span class="text-xs font-bold text-[#1b5e20] tracking-wider uppercase mt-0.5">
                    ${not empty rolActual ? rolActual : 'INVITADO'}
                </span>
            </div>
        </div>

        <!-- Botón Cerrar Sesión Mejorado -->
        <a href="${pageContext.request.contextPath}/logout" class="flex items-center justify-center gap-2 px-4 py-3 rounded-xl text-sm font-bold text-[#073a1e] bg-gradient-to-r from-[#ffffff] to-[#e8f5e9] hover:from-[#f0fdf4] hover:to-[#dcfce7] hover:shadow-lg transition-all duration-300 transform hover:scale-105 border border-[#a5d6a7]">
            <span class="material-symbols-outlined text-lg text-[#073a1e]">logout</span>
            <span>Cerrar sesión</span>
        </a>
    </div>
</aside>

<!-- Script para el control interactivo y la persistencia de submenús -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // --- CONTROL DE SUBMENÚS ---
        const menuToggles = document.querySelectorAll(".menu-toggle");

        menuToggles.forEach(toggle => {
            toggle.addEventListener("click", function () {
                const targetId = this.getAttribute("data-target");
                const targetMenu = document.getElementById(targetId);
                const chevron = this.querySelector(".chevron-icon");

                if (targetMenu.classList.contains("hidden")) {
                    targetMenu.classList.remove("hidden");
                    if (chevron)
                        chevron.style.transform = "rotate(180deg)";
                    localStorage.setItem("submenu-" + targetId, "open");
                } else {
                    targetMenu.classList.add("hidden");
                    if (chevron)
                        chevron.style.transform = "rotate(0deg)";
                    localStorage.setItem("submenu-" + targetId, "closed");
                }
            });
        });

        // Restaurar estado de los submenús al cargar la página
        menuToggles.forEach(toggle => {
            const targetId = toggle.getAttribute("data-target");
            const targetMenu = document.getElementById(targetId);
            const chevron = toggle.querySelector(".chevron-icon");
            const savedState = localStorage.getItem("submenu-" + targetId);

            if (savedState === "open" || (!savedState && (targetId === "submenu-admin-tickets" || targetId === "submenu-agente-tickets" || targetId === "submenu-solicitudes-ap" || targetId === "submenu-solicitudes-fun"))) {
                targetMenu.classList.remove("hidden");
                if (chevron)
                    chevron.style.transform = "rotate(180deg)";
            } else {
                targetMenu.classList.add("hidden");
                if (chevron)
                    chevron.style.transform = "rotate(0deg)";
            }
        });
    });
</script>