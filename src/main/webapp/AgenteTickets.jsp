<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Tickets Asignados - SENA Mesa de Ayuda</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "on-primary": "#ffffff",
                            "error": "#ba1a1a",
                            "tertiary": "#5d5f5e",
                            "on-tertiary-fixed": "#1a1c1c",
                            "on-primary-container": "#0c3400",
                            "outline": "#6f7b66",
                            "on-tertiary": "#ffffff",
                            "inverse-primary": "#6fdf43",
                            "surface-container-high": "#e8e8e8",
                            "tertiary-fixed": "#e2e2e2",
                            "inverse-surface": "#2f3131",
                            "on-secondary-fixed": "#1a1c1c",
                            "on-error": "#ffffff",
                            "on-primary-fixed": "#052100",
                            "primary-container": "#39a900",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "background": "#f9f9f9",
                            "on-secondary-container": "#616363",
                            "on-tertiary-container": "#2a2c2c",
                            "on-background": "#1a1c1c",
                            "surface-container-highest": "#e2e2e2",
                            "surface-bright": "#f9f9f9",
                            "surface-variant": "#e2e2e2",
                            "on-surface-variant": "#3f4a38",
                            "on-secondary-fixed-variant": "#454747",
                            "error-container": "#ffdad6",
                            "tertiary-container": "#929393",
                            "surface": "#f9f9f9",
                            "surface-dim": "#dadada",
                            "on-surface": "#1a1c1c",
                            "surface-container-lowest": "#ffffff",
                            "secondary-fixed-dim": "#c6c6c7",
                            "on-error-container": "#93000a",
                            "surface-container-low": "#f3f3f3",
                            "on-primary-fixed-variant": "#185200",
                            "secondary": "#5d5f5f",
                            "secondary-fixed": "#e2e2e2",
                            "secondary-container": "#dfe0e0",
                            "on-tertiary-fixed-variant": "#454747",
                            "primary-fixed": "#8afd5d",
                            "outline-variant": "#becbb3",
                            "primary-fixed-dim": "#6fdf43",
                            "surface-tint": "#226d00",
                            "inverse-on-surface": "#f1f1f1",
                            "surface-container": "#eeeeee",
                            "primary": "#226d00",
                            "on-secondary": "#ffffff"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "stack-sm": "8px",
                            "margin-mobile": "16px",
                            "unit": "8px",
                            "margin-desktop": "32px",
                            "container-max": "1280px",
                            "gutter": "24px",
                            "stack-lg": "32px",
                            "stack-md": "16px"
                        },
                        "fontFamily": {
                            "label-sm": ["Work Sans"],
                            "headline-md": ["Work Sans"],
                            "headline-lg": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "label-md": ["Work Sans"],
                            "body-lg": ["Work Sans"],
                            "display-lg": ["Work Sans"],
                            "title-lg": ["Work Sans"],
                            "headline-lg-mobile": ["Work Sans"]
                        },
                        "fontSize": {
                            "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                            "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                            "headline-lg": ["32px", {"lineHeight": "40px", "fontWeight": "600"}],
                            "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                            "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}],
                            "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                            "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                            "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "500"}],
                            "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}]
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f9f9f9;
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            .icon-fill {
                font-variation-settings: 'FILL' 1;
            }
        </style>
    </head>
    <%@ page import="java.sql.*, java.util.*" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="co.edu.sena.mesa.servicio.notificacion.Notificador, co.edu.sena.mesa.servicio.notificacion.NotificadorEnAplicacion, co.edu.sena.mesa.servicio.notificacion.NotificacionService, co.edu.sena.mesa.servicio.notificacion.NotificacionServiceImpl" %>
<%
    List<Map<String, Object>> ticketsAsignados = new ArrayList<>();
    int totalAsignados = 0;
    int urgentes = 0;
    int pendientes = 0;
    String mensajeEstado = "";

    Notificador notificadorEnAplicacion = new NotificadorEnAplicacion();
    NotificacionService notificacionService = new NotificacionServiceImpl(notificadorEnAplicacion);
    HttpSession sesion = request.getSession(false);

    java.util.function.Function<String, String> normalizarEstadoTicket = (estado) -> {
        if (estado == null) {
            return null;
        }
        String valor = estado.trim();
        if (valor.isEmpty()) {
            return null;
        }
        String mayus = valor.toUpperCase(Locale.ROOT);
        if ("EN_PROCESO".equals(mayus) || "EN PROCESO".equalsIgnoreCase(valor)) {
            return "EN PROCESO";
        }
        return mayus;
    };

    if ("POST".equalsIgnoreCase(request.getMethod()) && sesion != null && sesion.getAttribute("usuario") != null) {
        co.edu.sena.mesa.modelo.Usuario usuarioActual = (co.edu.sena.mesa.modelo.Usuario) sesion.getAttribute("usuario");
        int idUsuarioActual = usuarioActual.getId();
        String idTicketParam = request.getParameter("idTicket");
        String accion = request.getParameter("accion");
        String nuevoEstado = request.getParameter("nuevoEstado");

        if (idTicketParam != null) {
            try {
                int idTicket = Integer.parseInt(idTicketParam);
                String validarSql = "SELECT 1 FROM ticketagente WHERE idTicket = ? AND idUsuario = ?";
                String updateSql = "UPDATE ticket SET estado = ? WHERE id = ? AND id IN (SELECT idTicket FROM ticketagente WHERE idUsuario = ?)";

                try (Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mesaayuda", "root", "Sena2026*")) {
                    try (PreparedStatement validarPs = cn.prepareStatement(validarSql)) {
                        validarPs.setInt(1, idTicket);
                        validarPs.setInt(2, idUsuarioActual);
                        try (ResultSet rs = validarPs.executeQuery()) {
                            if (!rs.next()) {
                                mensajeEstado = "Este ticket no está asignado a tu usuario.";
                            } else if ("resolverTicket".equals(accion)) {
                                try (PreparedStatement updatePs = cn.prepareStatement(updateSql)) {
                                    updatePs.setString(1, "RESUELTO");
                                    updatePs.setInt(2, idTicket);
                                    updatePs.setInt(3, idUsuarioActual);
                                    int filas = updatePs.executeUpdate();
                                    if (filas > 0) {
                                        mensajeEstado = "Ticket resuelto correctamente y guardado en la base de datos.";
                                        String correoSolicitante = null;
                                        try (PreparedStatement correoPs = cn.prepareStatement(
                                                "SELECT u.correo FROM ticket t JOIN usuario u ON u.id = t.idUsuario WHERE t.id = ?")) {
                                            correoPs.setInt(1, idTicket);
                                            try (ResultSet correoRs = correoPs.executeQuery()) {
                                                if (correoRs.next()) {
                                                    correoSolicitante = correoRs.getString("correo");
                                                }
                                            }
                                        }
                                        if (correoSolicitante != null && !correoSolicitante.trim().isEmpty()) {
                                            notificacionService.notificarTicketResuelto(correoSolicitante, idTicket);
                                        }
                                    } else {
                                        mensajeEstado = "No se pudo resolver el ticket.";
                                    }
                                }
                            } else {
                                String estado = normalizarEstadoTicket.apply(nuevoEstado);
                                if (estado != null && !estado.trim().isEmpty()) {
                                    try (PreparedStatement updatePs = cn.prepareStatement(updateSql)) {
                                        updatePs.setString(1, estado);
                                        updatePs.setInt(2, idTicket);
                                        updatePs.setInt(3, idUsuarioActual);
                                        int filas = updatePs.executeUpdate();
                                        if (filas > 0) {
                                            mensajeEstado = "Estado actualizado correctamente y guardado en la base de datos.";
                                            String correoSolicitante = null;
                                            try (PreparedStatement correoPs = cn.prepareStatement(
                                                    "SELECT u.correo FROM ticket t JOIN usuario u ON u.id = t.idUsuario WHERE t.id = ?")) {
                                                correoPs.setInt(1, idTicket);
                                                try (ResultSet correoRs = correoPs.executeQuery()) {
                                                    if (correoRs.next()) {
                                                        correoSolicitante = correoRs.getString("correo");
                                                    }
                                                }
                                            }
                                            if (correoSolicitante != null && !correoSolicitante.trim().isEmpty()) {
                                                notificacionService.notificarCambioEstado(correoSolicitante, idTicket, estado);
                                            }
                                        } else {
                                            mensajeEstado = "No se pudo actualizar el estado.";
                                        }
                                    }
                                } else {
                                    mensajeEstado = "Debe elegir un estado válido.";
                                }
                            }
                        }
                    }
                }
            } catch (Exception e) {
                mensajeEstado = "Error al guardar el cambio del ticket.";
                e.printStackTrace();
            }
        }
    }
    if (mensajeEstado != null && !mensajeEstado.isEmpty()) {
        request.setAttribute("mensajeEstado", mensajeEstado);
    }

    if (sesion != null && sesion.getAttribute("usuario") != null) {
        co.edu.sena.mesa.modelo.Usuario usuarioActual = (co.edu.sena.mesa.modelo.Usuario) sesion.getAttribute("usuario");
        int idUsuarioActual = usuarioActual.getId();

        String sql = "SELECT t.id, t.titulo, t.estado, c.nombre AS categoria, pr.tipoPrioridad AS prioridad, "
                + "u.nombre AS solicitante, u.apellido AS apellido_solicitante "
                + "FROM ticketagente ta "
                + "JOIN ticket t ON t.id = ta.idTicket "
                + "JOIN usuario u ON u.id = t.idUsuario "
                + "LEFT JOIN categoria c ON c.id = t.idCategoria "
                + "LEFT JOIN prioridad pr ON pr.id = t.idPrioridad "
                + "WHERE ta.idUsuario = ? "
                + "ORDER BY t.id DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mesaayuda", "root", "Sena2026*");
                 PreparedStatement ps = cn.prepareStatement(sql)) {
                ps.setInt(1, idUsuarioActual);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> ticket = new HashMap<>();
                        ticket.put("id", rs.getInt("id"));
                        ticket.put("titulo", rs.getString("titulo"));
                        ticket.put("estado", rs.getString("estado"));
                        ticket.put("categoria", rs.getString("categoria"));
                        ticket.put("prioridad", rs.getString("prioridad"));
                        ticket.put("solicitante", rs.getString("solicitante") + (rs.getString("apellido_solicitante") != null ? " " + rs.getString("apellido_solicitante") : ""));
                        ticketsAsignados.add(ticket);
                        totalAsignados++;

                        String prioridad = rs.getString("prioridad");
                        if (prioridad != null && (prioridad.equalsIgnoreCase("Alta") || prioridad.equalsIgnoreCase("Urgente") || prioridad.equalsIgnoreCase("Crítica") || prioridad.equalsIgnoreCase("Inmediata"))) {
                            urgentes++;
                        }

                        String estado = rs.getString("estado");
                        if (estado != null && !"CERRADO".equalsIgnoreCase(estado) && !"CANCELADO".equalsIgnoreCase(estado)) {
                            pendientes++;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    request.setAttribute("ticketsAsignados", ticketsAsignados);
    request.setAttribute("totalAsignados", totalAsignados);
    request.setAttribute("urgentes", urgentes);
    request.setAttribute("pendientes", pendientes);
    request.setAttribute("mensajeEstado", mensajeEstado);
%>

<body class="bg-background text-on-background min-h-screen flex flex-col">
        <header class="bg-gradient-to-r from-emerald-50 to-green-50/20 border-b border-emerald-100 shadow-sm fixed top-0 w-full z-50 flex justify-between items-center px-margin-mobile md:px-margin-desktop h-16">
            <div class="flex items-center gap-4">
                <button class="p-2 rounded-full hover:bg-surface-container-high transition-colors text-on-surface-variant dark:text-on-surface-variant active:scale-95 transition-transform">
                    <span class="material-symbols-outlined" data-icon="menu">menu</span>
                </button>
                <div class="flex items-center gap-3">
                    <img alt="SENA Logo" class="h-8 w-8 object-contain" src="https://upload.wikimedia.org/wikipedia/commons/8/8c/SENA_Logo.svg"/>
                    <h1 class="font-headline-md text-headline-md-mobile md:text-headline-md font-bold text-emerald-600 dark:text-emerald-500">
                        SENA Mesa de Ayuda
                    </h1>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <button class="p-2 rounded-full hover:bg-surface-container-high transition-colors text-on-surface-variant dark:text-on-surface-variant relative">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-error rounded-full"></span>
                </button>
                <div class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center font-bold font-label-md text-label-md overflow-hidden">
                    <img class="w-full h-full object-cover" alt="Perfil del agente" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDVcgvaeTOM--M2WmIIMQ23lpVNw1zjeoGbv5KJB02RR1MQbF0lbgMnCn9QHx-6C0i-odfMGQOuaOhjnFrH-BVOGTPZRYakdMSb9KNcpEDZ9DLGXHaUcBelexJNOHN3RMMHt6Clag4oycj1bCZl2vnNDRF6Nm6WKXFTbmu6dbn1LTAyj-3XKiE3FN0GpGLMq8d1o4exs3oYrdnlX3usm2w0pdQ8n_J4hbQt9CTZhrMqrBmzKwgIaAJp"/>
                </div>
            </div>
        </header>

        <div class="flex flex-1 pt-16">
            <aside class="shrink-0">
                <jsp:include page="Menu.jsp"/>
            </aside>

            <main class="flex-grow w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-stack-lg flex flex-col gap-stack-lg min-w-0">
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-stack-md p-6 bg-gradient-to-r from-emerald-50 to-green-50/20 rounded-2xl border border-emerald-100/70 shadow-sm">
                    <div>
                        <h2 class="font-headline-lg text-headline-lg-mobile md:text-headline-lg text-gray-900">Tickets Asignados</h2>
                        <p class="font-body-md text-emerald-800 font-medium mt-1">Gestiona los requerimientos asignados a tu perfil en tiempo real.</p>
                    </div>
                </div>



                <c:if test="${not empty mensajeEstado}">
                    <div class="rounded-xl border border-green-200 bg-green-50 px-4 py-3 text-sm text-green-800 shadow-sm flex items-start gap-3">
                        <span class="material-symbols-outlined text-lg">notifications_active</span>
                        <div>
                            <p class="font-semibold">Notificación</p>
                            <p>${mensajeEstado}</p>
                        </div>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty ticketsAsignados}">
                        <div class="bg-white rounded-2xl shadow-sm border border-outline-variant overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="w-full border-collapse text-left">
                                    <thead>
                                        <tr class="bg-gray-50 border-b border-outline-variant text-xs font-semibold text-gray-500 uppercase tracking-wider">
                                            <th class="py-4 px-6">ID / Asunto</th>
                                            <th class="py-4 px-6">Solicitante</th>
                                            <th class="py-4 px-6">Categoría</th>
                                            <th class="py-4 px-6">Prioridad</th>
                                            <th class="py-4 px-6">Estado</th>
                                            <th class="py-4 px-6 text-right">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-outline-variant">
                                        <c:forEach var="ticket" items="${ticketsAsignados}">
                                            <c:set var="priorityColor" value="#3b82f6" />
                                            <c:set var="priorityBg" value="bg-blue-50 text-blue-700 border-blue-200" />
                                            <c:if test="${ticket.prioridad == 'Alta' || ticket.prioridad == 'URGENTE' || ticket.prioridad == 'Urgente' || ticket.prioridad == 'Crítica' || ticket.prioridad == 'Critica'}">
                                                <c:set var="priorityColor" value="#ef4444" />
                                                <c:set var="priorityBg" value="bg-red-50 text-red-700 border-red-200" />
                                            </c:if>
                                            <c:if test="${ticket.prioridad == 'Media' || ticket.prioridad == 'MEDIA'}">
                                                <c:set var="priorityColor" value="#f59e0b" />
                                                <c:set var="priorityBg" value="bg-amber-50 text-amber-700 border-amber-200" />
                                            </c:if>
                                            <c:if test="${ticket.prioridad == 'Baja' || ticket.prioridad == 'BAJA'}">
                                                <c:set var="priorityColor" value="#10b981" />
                                                <c:set var="priorityBg" value="bg-emerald-50 text-emerald-700 border-emerald-200" />
                                            </c:if>

                                            <c:set var="stateBg" value="bg-gray-100 text-gray-700 border-gray-200" />
                                            <c:if test="${ticket.estado == 'ASIGNADO'}">
                                                <c:set var="stateBg" value="bg-indigo-50 text-indigo-700 border border-indigo-200" />
                                            </c:if>
                                            <c:if test="${ticket.estado == 'EN PROCESO'}">
                                                <c:set var="stateBg" value="bg-amber-50 text-amber-700 border border-amber-200" />
                                            </c:if>
                                            <c:if test="${ticket.estado == 'RESUELTO'}">
                                                <c:set var="stateBg" value="bg-emerald-50 text-emerald-700 border border-emerald-200" />
                                            </c:if>
                                            <c:if test="${ticket.estado == 'CANCELADO'}">
                                                <c:set var="stateBg" value="bg-rose-50 text-rose-700 border border-rose-200" />
                                            </c:if>

                                            <tr class="ticket-card hover:bg-gray-50/40 transition-colors group"
                                                data-id="${ticket.id}" data-titulo="${ticket.titulo}" data-solicitante="${ticket.solicitante}" data-estado="${ticket.estado}" data-prioridad="${ticket.prioridad}">
                                                <!-- ID / Asunto -->
                                                <td class="py-4 px-6">
                                                    <div class="flex items-center gap-3">
                                                        <span class="font-mono text-xs font-semibold text-gray-400 bg-gray-100 px-2 py-0.5 rounded">#${ticket.id}</span>
                                                        <a href="${pageContext.request.contextPath}/tickets/comentar?id=${ticket.id}" class="font-bold text-gray-900 group-hover:text-emerald-600 transition-colors hover:underline">
                                                            ${ticket.titulo}
                                                        </a>
                                                    </div>
                                                </td>
                                                <!-- Solicitante -->
                                                <td class="py-4 px-6">
                                                    <div class="flex items-center gap-2 text-gray-700 font-medium">
                                                        <span class="material-symbols-outlined text-[18px] text-gray-400">person</span>
                                                        ${ticket.solicitante}
                                                    </div>
                                                </td>
                                                <!-- Categoría -->
                                                <td class="py-4 px-6">
                                                    <div class="flex items-center gap-2 text-gray-600 font-medium">
                                                        <span class="material-symbols-outlined text-[18px] text-gray-400">apartment</span>
                                                        ${ticket.categoria != null ? ticket.categoria : 'Sin categoría'}
                                                    </div>
                                                </td>
                                                <!-- Prioridad -->
                                                <td class="py-4 px-6">
                                                    <span class="px-2.5 py-1 rounded-full font-semibold text-xs border ${priorityBg} inline-flex items-center gap-1.5 shadow-sm">
                                                        <span class="w-1.5 h-1.5 rounded-full" style="background-color: ${priorityColor};"></span>
                                                        ${ticket.prioridad != null ? ticket.prioridad : 'Sin prioridad'}
                                                    </span>
                                                </td>
                                                <!-- Estado -->
                                                <td class="py-4 px-6">
                                                    <span class="px-2.5 py-1 rounded-full font-semibold text-xs border ${stateBg} shadow-sm">
                                                        ${ticket.estado != null ? ticket.estado : 'ABIERTO'}
                                                    </span>
                                                </td>
                                                <!-- Acciones -->
                                                <td class="py-4 px-6 text-right">
                                                    <div class="flex items-center justify-end gap-3 flex-wrap">
                                                        <c:choose>
                                                            <c:when test="${ticket.estado == 'CERRADO' || ticket.estado == 'CANCELADO'}">
                                                                <span class="text-xs font-bold text-gray-400 flex items-center gap-1">
                                                                    <span class="material-symbols-outlined text-sm">lock</span> Finalizado
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${ticket.estado == 'RESUELTO'}">
                                                                <span class="text-xs font-bold text-emerald-600 flex items-center gap-1">
                                                                    <span class="material-symbols-outlined text-sm">check_circle</span> Resuelto
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form method="post" action="${pageContext.request.contextPath}/AgenteTickets.jsp" class="flex items-center gap-2">
                                                                    <input type="hidden" name="idTicket" value="${ticket.id}"/>
                                                                    <select name="nuevoEstado" class="rounded-lg border border-outline-variant bg-surface-container-low px-2 py-1 text-xs text-on-surface focus:outline-none focus:ring-1 focus:ring-emerald-500 font-semibold shadow-sm">
                                                                        <c:choose>
                                                                            <c:when test="${ticket.estado == 'ASIGNADO'}">
                                                                                <option value="ASIGNADO" selected>ASIGNADO</option>
                                                                                <option value="EN PROCESO">EN PROCESO</option>
                                                                                <option value="RESUELTO">RESUELTO</option>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <option value="EN PROCESO" selected>EN PROCESO</option>
                                                                                <option value="RESUELTO">RESUELTO</option>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </select>
                                                                    <button type="submit" name="accion" value="cambiarEstado" class="bg-emerald-600 hover:bg-emerald-700 text-white p-1 rounded-lg text-xs font-bold shadow-sm hover:shadow transition-all flex items-center justify-center" title="Guardar estado">
                                                                        <span class="material-symbols-outlined text-sm">save</span>
                                                                    </button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        
                                                        <a href="${pageContext.request.contextPath}/tickets/comentar?id=${ticket.id}" class="bg-emerald-50 hover:bg-emerald-100 text-emerald-700 border border-emerald-200 px-3 py-1.5 rounded-lg font-bold text-xs flex items-center gap-1 transition-all">
                                                            <c:choose>
                                                                <c:when test="${ticket.estado == 'CERRADO' || ticket.estado == 'CANCELADO' || ticket.estado == 'RESUELTO'}">
                                                                    Historial <span class="material-symbols-outlined text-sm">visibility</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Atender <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-white rounded-2xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                            No tienes tickets asignados en este momento.
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>

        <footer class="bg-surface-container-lowest dark:bg-inverse-surface border-t border-outline-variant w-full py-stack-md px-margin-mobile flex flex-col md:flex-row justify-between items-center gap-stack-sm mt-auto z-10">
            <p class="font-label-sm text-label-sm text-primary dark:text-primary-fixed-dim">
                © 2024 Servicio Nacional de Aprendizaje SENA. Todos los derechos reservados.
            </p>
            <div class="flex gap-4">
                <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Privacidad</a>
                <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Términos de Uso</a>
                <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Contacto</a>
            </div>
        </footer>
        <!-- Script de Filtrado por Menú Lateral -->
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const menuVerTickets = document.getElementById('menu-ver-tickets');
                const menuAtenderTicket = document.getElementById('menu-atender-ticket');
                const menuVerHistorial = document.getElementById('menu-ver-historial');
                const ticketCards = document.querySelectorAll('.ticket-card');

                // Leer parámetro de la URL
                const urlParams = new URLSearchParams(window.location.search);
                let currentView = urlParams.get('filter') || 'todos'; // 'todos', 'atender', 'historial'

                function applyFilters() {
                    // 1. Actualizar estilos del menú lateral
                    [menuVerTickets, menuAtenderTicket, menuVerHistorial].forEach(menu => {
                        if (menu) {
                            menu.classList.remove('bg-emerald-100', 'text-emerald-950', 'font-semibold');
                            menu.classList.add('text-on-surface');
                        }
                    });

                    if (currentView === 'todos') {
                        if (menuVerTickets) {
                            menuVerTickets.classList.add('bg-emerald-100', 'text-emerald-950', 'font-semibold');
                            menuVerTickets.classList.remove('text-on-surface');
                        }
                    } else if (currentView === 'atender') {
                        if (menuAtenderTicket) {
                            menuAtenderTicket.classList.add('bg-emerald-100', 'text-emerald-950', 'font-semibold');
                            menuAtenderTicket.classList.remove('text-on-surface');
                        }
                    } else if (currentView === 'historial') {
                        if (menuVerHistorial) {
                            menuVerHistorial.classList.add('bg-emerald-100', 'text-emerald-950', 'font-semibold');
                            menuVerHistorial.classList.remove('text-on-surface');
                        }
                    }

                    // 2. Filtrar tarjetas
                    ticketCards.forEach(card => {
                        const estado = card.getAttribute('data-estado').toUpperCase();

                        // Filtro de vista principal (lateral)
                        const isHistorial = estado === "RESUELTO" || estado === "CERRADO" || estado === "CANCELADO";
                        
                        let matchesView = true;
                        if (currentView === 'atender') {
                            matchesView = !isHistorial;
                        } else if (currentView === 'historial') {
                            matchesView = isHistorial;
                        }

                        if (matchesView) {
                            card.style.display = "";
                        } else {
                            card.style.display = "none";
                        }
                    });
                }

                // Eventos del menú lateral
                if (menuVerTickets) {
                    menuVerTickets.addEventListener('click', function(e) {
                        e.preventDefault();
                        currentView = 'todos';
                        window.history.pushState({}, '', window.location.pathname);
                        applyFilters();
                    });
                }

                if (menuAtenderTicket) {
                    menuAtenderTicket.addEventListener('click', function(e) {
                        e.preventDefault();
                        currentView = 'atender';
                        window.history.pushState({}, '', `${window.location.pathname}?filter=atender`);
                        applyFilters();
                    });
                }

                if (menuVerHistorial) {
                    menuVerHistorial.addEventListener('click', function(e) {
                        e.preventDefault();
                        currentView = 'historial';
                        window.history.pushState({}, '', `${window.location.pathname}?filter=historial`);
                        applyFilters();
                    });
                }

                // Inicializar
                applyFilters();
            });
        </script>
    </body>
</html>