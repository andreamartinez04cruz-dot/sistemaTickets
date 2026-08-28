<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8"/>
        <title>Reportes y Estadísticas - Administrador</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f4fbf7;
                color: #073a1e;
            }
        </style>
    </head>
    <body class="min-h-screen flex">
        <jsp:include page="Menu.jsp" />

        <div class="flex-1 flex flex-col">

            <div class="flex items-center justify-between mb-8 p-6 bg-gradient-to-r from-emerald-50 to-green-50/20 rounded-2xl border border-emerald-100/70 shadow-sm">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Estadísticas y Reportes</h1>
                    <p class="text-sm text-emerald-800 font-medium mt-1">Análisis de rendimiento y estado actual de los tickets de la mesa de ayuda.</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/admin/tickets" class="px-4 py-2 rounded-xl bg-emerald-500 text-white hover:bg-emerald-600 flex items-center gap-2 text-sm font-semibold shadow-sm transition-colors">
                        <span class="material-symbols-outlined text-base">arrow_back</span>
                        Volver al panel
                    </a>
                </div>
            </div>

            <!-- Fichas de Indicadores Clave -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-5 mb-8">
                <div class="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm flex items-center gap-4">
                    <div class="p-3 bg-blue-50 text-blue-600 rounded-xl">
                        <span class="material-symbols-outlined text-3xl">confirmation_number</span>
                    </div>
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">Total este Mes</p>
                        <p class="text-2xl font-bold text-gray-900 mt-1">${estadisticasAdmin.totalTicketsMes}</p>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm flex items-center gap-4">
                    <div class="p-3 bg-rose-50 text-rose-600 rounded-xl">
                        <span class="material-symbols-outlined text-3xl">error</span>
                    </div>
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">Casos Críticos</p>
                        <p class="text-2xl font-bold text-rose-600 mt-1">${estadisticasAdmin.criticos}</p>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm flex items-center gap-4">
                    <div class="p-3 bg-amber-50 text-amber-600 rounded-xl">
                        <span class="material-symbols-outlined text-3xl">hourglass_empty</span>
                    </div>
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">Sin Asignar</p>
                        <p class="text-2xl font-bold text-amber-600 mt-1">${estadisticasAdmin.sinAsignar}</p>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-5 shadow-sm flex items-center gap-4">
                    <div class="p-3 bg-emerald-50 text-emerald-600 rounded-xl">
                        <span class="material-symbols-outlined text-3xl">check_circle</span>
                    </div>
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-wider text-gray-400">Cerrados Hoy</p>
                        <p class="text-2xl font-bold text-emerald-600 mt-1">${estadisticasAdmin.cerradosHoy}</p>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
                <div class="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-5">
                        <h3 class="text-lg font-bold text-gray-900">Tickets por estado</h3>
                        <span class="material-symbols-outlined text-emerald-600">bar_chart</span>
                    </div>
                    <div class="space-y-4 bar-chart" data-chart="estado">
                        <c:forEach var="fila" items="${estadisticasAdmin.ticketsPorEstado}">
                            <div class="bar-row" data-value="${fila.cantidad}">
                                <div class="flex justify-between text-sm mb-1">
                                    <span class="font-medium text-gray-700"><c:out value="${fila.estado}" /></span>
                                    <span class="font-bold text-emerald-700"><c:out value="${fila.cantidad}" /></span>
                                </div>
                                <div class="h-3 bg-emerald-50 rounded-full overflow-hidden">
                                    <div class="bar-fill h-full bg-emerald-500 rounded-full"></div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty estadisticasAdmin.ticketsPorEstado}">
                            <p class="text-sm text-gray-500">No hay datos disponibles.</p>
                        </c:if>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-5">
                        <h3 class="text-lg font-bold text-gray-900">Tickets por agente</h3>
                        <span class="material-symbols-outlined text-blue-600">bar_chart</span>
                    </div>
                    <div class="space-y-4 bar-chart" data-chart="agente">
                        <c:forEach var="fila" items="${estadisticasAdmin.ticketsPorAgente}">
                            <div class="bar-row" data-value="${fila.cantidad}">
                                <div class="flex justify-between text-sm mb-1">
                                    <span class="font-medium text-gray-700"><c:out value="${fila.agente}" /></span>
                                    <span class="font-bold text-blue-700"><c:out value="${fila.cantidad}" /></span>
                                </div>
                                <div class="h-3 bg-blue-50 rounded-full overflow-hidden">
                                    <div class="bar-fill h-full bg-blue-500 rounded-full"></div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty estadisticasAdmin.ticketsPorAgente}">
                            <p class="text-sm text-gray-500">No hay agentes con tickets activos.</p>
                        </c:if>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-5">
                        <h3 class="text-lg font-bold text-gray-900">SLA vencidos</h3>
                        <span class="material-symbols-outlined text-red-600">warning</span>
                    </div>
                    <div class="space-y-4 bar-chart" data-chart="sla" data-max="${estadisticasAdmin.totalTicketsMes}">
                        <div class="bar-row" data-value="${estadisticasAdmin.slaVencidos}">
                            <div class="flex justify-between text-sm mb-1">
                                <span class="font-medium text-gray-700">Tickets fuera de tiempo</span>
                                <span class="font-bold text-red-700"><c:out value="${estadisticasAdmin.slaVencidos}" /></span>
                            </div>
                            <div class="h-3 bg-red-50 rounded-full overflow-hidden">
                                <div class="bar-fill h-full bg-red-500 rounded-full"></div>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500">Tickets activos que superaron el tiempo permitido.</p>
                    </div>
                </div>
            </div>

            <script>
                document.querySelectorAll('.bar-chart').forEach(function (chart) {
                    const rows = chart.querySelectorAll('.bar-row');
                    const configuredMax = Number(chart.dataset.max);
                    const max = Math.max(configuredMax || 0,
                            ...Array.from(rows).map(row => Number(row.dataset.value)), 1);
                    rows.forEach(function (row) {
                        row.querySelector('.bar-fill').style.width = (Number(row.dataset.value) / max * 100) + '%';
                    });
                });
            </script>

        </div>
    </div>
</body>
</html>
