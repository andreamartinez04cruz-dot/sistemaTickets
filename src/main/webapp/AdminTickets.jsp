<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Administrador</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
    </head>

    <!-- flex para que el sidebar y el contenido queden lado a lado -->
    <body class="bg-background text-on-background min-h-screen flex">

        <!-- 1. Único llamado al sidebar/menú -->
        <jsp:include page="Menu.jsp"/> 

        <!-- 2. Contenedor principal que ocupa el resto del ancho -->
        <div class="flex-grow flex flex-col min-w-0">

            <!-- Header superior -->
            <jsp:include page="Header.jsp"/>

            <!-- Contenido del Dashboard -->
            <main class="flex-grow p-6 w-full max-w-7xl mx-auto">
                <!-- Cabecera -->
                <div class="flex justify-between items-center mb-6 p-6 bg-gradient-to-r from-emerald-50 to-green-50/20 rounded-2xl border border-emerald-100/70 shadow-sm">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-900">Panel de Control - Administrador</h2>
                        <p class="text-sm text-emerald-800 font-medium mt-1 font-sans">Vista general de tickets e indicadores en tiempo real.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/reportes" class="bg-emerald-500 text-white px-4 py-2 rounded-xl font-semibold flex items-center gap-2 hover:bg-emerald-600 shadow-sm transition-colors text-sm">
                        <span class="material-symbols-outlined text-base">query_stats</span>
                        Ver Reportes Detallados
                    </a>
                </div>

                <!-- Tarjetas de Estadísticas -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <!-- Total Tickets -->
                    <div class="bg-white p-4 rounded-xl border border-gray-200 flex justify-between items-center shadow-sm">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Total Tickets</span>
                            <p class="text-3xl font-bold mt-1">${estadisticasAdmin.totalTicketsMes}</p>
                            <span class="text-xs text-green-600 mt-2 block font-medium">Este mes</span>
                        </div>
                        <div class="p-3 bg-green-50 rounded-lg text-emerald-600">
                            <span class="material-symbols-outlined">assignment</span>
                        </div>
                    </div>

                    <!-- Críticos -->
                    <div class="bg-white p-4 rounded-xl border-l-4 border-red-600 border-y border-r border-gray-200 flex justify-between items-center shadow-sm">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Críticos</span>
                            <p class="text-3xl font-bold mt-1">${estadisticasAdmin.criticos}</p>
                            <span class="text-xs text-red-600 font-medium mt-2 block font-medium">! Prioridad alta</span>
                        </div>
                        <div class="p-3 bg-red-50 rounded-lg text-red-600">
                            <span class="material-symbols-outlined">warning</span>
                        </div>
                    </div>

                    <!-- Sin Asignar -->
                    <div class="bg-white p-4 rounded-xl border-l-4 border-amber-500 border-y border-r border-gray-200 flex justify-between items-center shadow-sm">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Sin Asignar</span>
                            <p class="text-3xl font-bold mt-1">${estadisticasAdmin.sinAsignar}</p>
                            <span class="text-xs text-amber-600 font-medium mt-2 block font-medium">⏳ Casos pendientes</span>
                        </div>
                        <div class="p-3 bg-amber-50 rounded-lg text-amber-600">
                            <span class="material-symbols-outlined">hourglass_empty</span>
                        </div>
                    </div>

                    <!-- Cerrados Hoy -->
                    <div class="bg-white p-4 rounded-xl border-l-4 border-green-500 border-y border-r border-gray-200 flex justify-between items-center shadow-sm">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Cerrados Hoy</span>
                            <p class="text-3xl font-bold mt-1">${estadisticasAdmin.cerradosHoy}</p>
                            <span class="text-xs text-green-600 font-medium mt-2 block font-medium">✓ Resolución exitosa</span>
                        </div>
                        <div class="p-3 bg-green-50 rounded-lg text-green-500">
                            <span class="material-symbols-outlined">check_circle</span>
                        </div>
                    </div>
                </div>

                <!-- Sección de tickets por tipo de usuario -->
                <section class="mt-8 space-y-10">
                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-xl font-bold text-gray-800">Tickets Aprendiz</h3>
                            <span class="text-sm text-gray-500">Vista general</span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty aprendizTickets}">
                                <div class="grid grid-cols-1 xl:grid-cols-2 gap-5">
                                    <c:forEach var="ticket" items="${aprendizTickets}">
                                        <article class="bg-white rounded-2xl border border-gray-200 shadow-sm p-5">
                                            <div class="flex justify-between items-start mb-4">
                                                <div>
                                                    <p class="text-xs font-semibold uppercase tracking-wide text-gray-500">Ticket #<c:out value="${ticket.id}" /></p>
                                                    <h4 class="text-xl font-bold text-gray-900 mt-1"><c:out value="${ticket.titulo != null ? ticket.titulo : 'Sin título'}" /></h4>
                                                    <p class="text-sm text-gray-600 mt-1"><c:out value="${ticket.descripcion != null ? ticket.descripcion : 'Sin descripción'}" /></p>
                                                </div>
                                                <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 text-xs font-semibold">
                                                    <c:out value="${ticket.estado != null ? ticket.estado : 'ACTIVO'}" />
                                                </span>
                                            </div>

                                            <div class="space-y-3 text-sm">
                                                <c:if test="${ticket.estado != null && (fn:containsIgnoreCase(ticket.estado, 'NUEVO') || fn:containsIgnoreCase(ticket.estado, 'ASIGNADO') || fn:containsIgnoreCase(ticket.estado, 'EN_PROCESO') || fn:containsIgnoreCase(ticket.estado, 'EN PROCESO'))}">
                                                    <div class="mt-4 flex justify-end gap-2">
                                                        <a href="${pageContext.request.contextPath}/admin/reasignar-agentes?idTicket=${ticket.id}" class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-amber-100 text-amber-800 text-xs font-semibold hover:bg-amber-200">
                                                            <span class="material-symbols-outlined text-sm">swap_horiz</span>
                                                            Reasignar agente
                                                         </a>
                                                         <a href="javascript:void(0);" onclick="confirmarCancelar('${ticket.id}')" class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-red-100 text-red-800 text-xs font-semibold hover:bg-red-200">
                                                             <span class="material-symbols-outlined text-sm">cancel</span>
                                                             Cancelar ticket
                                                        </a>
                                                    </div>
                                                </c:if>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Nombre aprendiz</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.nombreAprendiz != null ? ticket.nombreAprendiz : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Programa</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.programa != null ? ticket.programa : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Número de programa</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.numeroPrograma != null ? ticket.numeroPrograma : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Instructor a cargo</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.instructorCargo != null ? ticket.instructorCargo : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Jornada</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.jornada != null ? ticket.jornada : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Categoría</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.categoria != null ? ticket.categoria : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between border-b pb-2">
                                                    <span class="text-gray-500">Prioridad</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.prioridad != null ? ticket.prioridad : 'Sin datos'}" /></span>
                                                </div>
                                                <div class="flex justify-between">
                                                    <span class="text-gray-500">Estado</span>
                                                    <span class="font-semibold text-gray-800"><c:out value="${ticket.estado != null ? ticket.estado : 'Sin datos'}" /></span>
                                                </div>
                                            </div>
                                        </article>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="bg-white rounded-2xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                                    No hay tickets de aprendices registrados en la base de datos.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div>
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-xl font-bold text-gray-800">Tickets Funcionario</h3>
                            <span class="text-sm text-gray-500">Vista general</span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty funcionarioTickets}">
                                <div class="grid grid-cols-1 xl:grid-cols-2 gap-5">
                                    <c:forEach var="ticket" items="${funcionarioTickets}">
                                        <article class="bg-white rounded-2xl border border-gray-200 shadow-sm p-5">
                                            <div class="flex justify-between items-start mb-4">
                                                <div>
                                                    <p class="text-xs font-semibold uppercase tracking-wide text-gray-500">Ticket #<c:out value="${ticket.id}" /></p>
                                                    <h4 class="text-xl font-bold text-gray-900 mt-1"><c:out value="${ticket.titulo != null ? ticket.titulo : 'Sin título'}" /></h4>
                                                    <p class="text-sm text-gray-600 mt-1"><c:out value="${ticket.descripcion != null ? ticket.descripcion : 'Sin descripción'}" /></p>
                                                </div>
                                                <span class="px-3 py-1 rounded-full bg-blue-100 text-blue-700 text-xs font-semibold">
                                                    <c:out value="${ticket.estado != null ? ticket.estado : 'ASIGNADO'}" />
                                                </span>
                                            </div>

                                            <div class="space-y-3 text-sm">
                                                <c:if test="${ticket.estado != null && (fn:containsIgnoreCase(ticket.estado, 'NUEVO') || fn:containsIgnoreCase(ticket.estado, 'ASIGNADO') || fn:containsIgnoreCase(ticket.estado, 'EN_PROCESO') || fn:containsIgnoreCase(ticket.estado, 'EN PROCESO'))}">
                                                    <div class="mt-4 flex justify-end gap-2">
                                                        <a href="${pageContext.request.contextPath}/admin/reasignar-agentes?idTicket=${ticket.id}" class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-amber-100 text-amber-800 text-xs font-semibold hover:bg-amber-200">
                                                            <span class="material-symbols-outlined text-sm">swap_horiz</span>
                                                            Reasignar agente
                                                         </a>
                                                         <a href="javascript:void(0);" onclick="confirmarCancelar('${ticket.id}')" class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-red-100 text-red-800 text-xs font-semibold hover:bg-red-200">
                                                             <span class="material-symbols-outlined text-sm">cancel</span>
                                                             Cancelar ticket
                                                        </a>
                                                    </div>
                                                </c:if>
                                                <div class="flex justify-between border-b pb-2"><span class="text-gray-500">Nombre funcionario</span><span class="font-semibold text-gray-800"><c:out value="${ticket.nombreFuncionario != null ? ticket.nombreFuncionario : 'Sin datos'}" /></span></div>
                                                <div class="flex justify-between border-b pb-2"><span class="text-gray-500">Rol</span><span class="font-semibold text-gray-800"><c:out value="${ticket.rol != null ? ticket.rol : 'Sin datos'}" /></span></div>
                                                <div class="flex justify-between border-b pb-2"><span class="text-gray-500">Jornada</span><span class="font-semibold text-gray-800"><c:out value="${ticket.jornada != null ? ticket.jornada : 'Sin datos'}" /></span></div>
                                                <div class="flex justify-between border-b pb-2"><span class="text-gray-500">Categoría</span><span class="font-semibold text-gray-800"><c:out value="${ticket.categoria != null ? ticket.categoria : 'Sin datos'}" /></span></div>
                                                <div class="flex justify-between border-b pb-2"><span class="text-gray-500">Prioridad</span><span class="font-semibold text-gray-800"><c:out value="${ticket.prioridad != null ? ticket.prioridad : 'Sin datos'}" /></span></div>
                                                <div class="flex justify-between"><span class="text-gray-500">Estado</span><span class="font-semibold text-gray-800"><c:out value="${ticket.estado != null ? ticket.estado : 'Sin datos'}" /></span></div>
                                            </div>
                                        </article>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="bg-white rounded-2xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                                    No hay tickets de funcionarios registrados en la base de datos.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmarCancelar(idTicket) {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "Esta acción cambiará el estado del ticket #" + idTicket + " a CANCELADO.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ef4444',
                    cancelButtonColor: '#3b82f6',
                    confirmButtonText: 'Sí, cancelar ticket',
                    cancelButtonText: 'No, mantener activo',
                    reverseButtons: true
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = "${pageContext.request.contextPath}/admin/cancelar-ticket?idTicket=" + idTicket;
                    }
                });
            }
        </script>
    </body>
</html>