<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    if (request.getAttribute("notificacionesPreparadas") == null) {
        response.sendRedirect(request.getContextPath() + "/notificaciones");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Notificaciones - Panel de Aprendiz</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#226d00",
                            "primary-green": "#28a745",
                            "light-bg": "#f8f9fa",
                            "border-color": "#e2e8f0"
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body class="bg-[#f8f9fa] text-gray-900 min-h-screen flex flex-col">

        <!-- Header Fijo (Panel de Aprendiz) -->
        <header class="fixed top-0 left-0 w-full bg-white border-b border-gray-200 h-16 px-6 md:px-12 flex items-center justify-between z-40 shadow-sm">
            <h1 class="text-[#2e7d32] font-bold text-lg md:text-xl">
                Panel de Aprendiz
            </h1>

            <div class="flex items-center gap-4">
                <button class="p-2 text-gray-700 hover:bg-gray-100 rounded-full transition-colors">
                    <span class="material-symbols-outlined text-2xl">notifications</span>
                </button>
                <div class="w-9 h-9 rounded-full bg-[#1b5e20] text-white font-bold flex items-center justify-center text-sm shadow-sm cursor-pointer">
                    AP
                </div>
            </div>
        </header>

        <!-- Contenedor Principal Flex (Menú + Contenido) -->
        <div class="flex flex-1 pt-16">

            <!-- Menú Lateral -->
            <aside class="w-64 shrink-0 hidden md:block">
                <jsp:include page="Menu.jsp"/>
            </aside>

            <!-- Main Content Area -->
            <main class="flex-1 w-full p-8 md:p-12 pb-12">
                <!-- Header Section -->
                <div class="mb-6">
                    <h1 class="text-3xl md:text-4xl font-extrabold text-gray-900 mb-2 tracking-tight">Notificaciones</h1>
                    <p class="text-sm md:text-base text-gray-600">Mantente al día con los cambios y asignaciones de tickets.</p>
                </div>

                <!-- Filter / Action Button -->
                <div class="mb-8">
                    <button class="bg-[#f0fdf4] hover:bg-[#dcfce7] text-[#16a34a] border border-[#bbf7d0] px-4 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-colors shadow-sm">
                        <span class="material-symbols-outlined text-[18px]">done_all</span>
                        <span>Marcar todas como leídas</span>
                    </button>
                </div>

                <!-- Notification Grid (2 Columnas) -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-5 max-w-5xl">

                    <c:choose>
                        <c:when test="${not empty sessionScope.notificaciones}">
                            <c:forEach var="notificacion" items="${sessionScope.notificaciones}">
                                <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-200/80 flex gap-4 items-start relative hover:shadow-md transition-all">
                                    <div class="w-10 h-10 rounded-full bg-[#f0fdf4] border border-[#dcfce7] flex items-center justify-center shrink-0">
                                        <span class="material-symbols-outlined text-[#16a34a] text-xl">notifications_active</span>
                                    </div>

                                    <div class="flex-1 pr-4">
                                        <h3 class="text-base font-bold text-gray-900 mb-1">Cambio de estado</h3>
                                        <p class="text-xs text-gray-600 leading-relaxed mb-4">
                                            ${notificacion}
                                        </p>
                                        <span class="text-[11px] font-semibold text-gray-400">Ahora</span>
                                    </div>

                                    <span class="w-2.5 h-2.5 rounded-full bg-[#22c55e] absolute top-5 right-5"></span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-200/80 flex gap-4 items-start relative hover:shadow-md transition-all lg:col-span-2">
                                <div class="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center shrink-0">
                                    <span class="material-symbols-outlined text-gray-600 text-xl">notifications</span>
                                </div>
                                <div class="flex-1">
                                    <h3 class="text-base font-bold text-gray-900 mb-1">Sin notificaciones</h3>
                                    <p class="text-xs text-gray-600 leading-relaxed mb-0">
                                        Cuando el estado de uno de tus tickets cambie, aparecerá aquí.
                                    </p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${not empty ticketsUsuario}">
                        <c:forEach var="ticket" items="${ticketsUsuario}">
                            <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-200/80 flex gap-4 items-start relative hover:shadow-md transition-all">
                                <div class="w-10 h-10 rounded-full bg-[#fef3c7] border border-[#fcd34d] flex items-center justify-center shrink-0">
                                    <span class="material-symbols-outlined text-[#b45309] text-xl">sync_alt</span>
                                </div>

                                <div class="flex-1 pr-4">
                                    <h3 class="text-base font-bold text-gray-900 mb-1">${ticket.tipoNotificacion}</h3>
                                    <p class="text-xs text-gray-600 leading-relaxed mb-3">
                                        ${ticket.mensaje}
                                    </p>
                                    <c:if test="${ticket.estado eq 'RESUELTO'}">
                                        <form method="post" action="${pageContext.request.contextPath}/notificaciones">
                                            <input type="hidden" name="accion" value="finalizarTicket"/>
                                            <input type="hidden" name="idTicket" value="${ticket.id}"/>
                                            <button type="submit" class="bg-[#1b5e20] hover:bg-[#154a1a] text-white text-xs font-semibold px-3 py-2 rounded-lg transition-colors">
                                                Finalizar ticket
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.rolUsuario and sessionScope.rolUsuario == 'AGENTE'}">
                                        <a href="${pageContext.request.contextPath}/tickets/comentar?id=${ticket.id}" class="inline-block mt-3 bg-emerald-50 hover:bg-emerald-100 text-emerald-700 border border-emerald-200 px-3 py-2 rounded-lg font-bold text-xs">
                                            Ver ticket
                                        </a>
                                    </c:if>
                                </div>
                                <span class="w-2.5 h-2.5 rounded-full bg-[#f59e0b] absolute top-5 right-5"></span>
                            </div>
                        </c:forEach>
                    </c:if>

                </div>
            </main>
        </div>

    </body>
</html>