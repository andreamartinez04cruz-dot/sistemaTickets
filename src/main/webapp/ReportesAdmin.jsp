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
        
        <!-- Header Superior -->
        <jsp:include page="Header.jsp" />
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

            <!-- Tabla de Resumen Metrológico -->
            <div class="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                <h3 class="text-lg font-bold text-gray-900 mb-4">Resumen General de Datos Reales</h3>
                <div class="overflow-x-auto">
                    <table class="w-full text-left text-sm text-gray-500">
                        <thead class="text-xs uppercase bg-emerald-50 text-emerald-900 border-b border-emerald-100">
                            <tr>
                                <th class="px-6 py-4 font-semibold">Métrica de Gestión</th>
                                <th class="px-6 py-4 font-semibold text-center">Cantidad</th>
                                <th class="px-6 py-4 font-semibold text-center">Porcentaje (%)</th>
                                <th class="px-6 py-4 font-semibold">Interpretación</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <tr class="hover:bg-emerald-50/30 transition-colors">
                                <td class="px-6 py-4 font-medium text-gray-900 flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-blue-500"></span> Total de Casos (Mes)
                                </td>
                                <td class="px-6 py-4 text-center font-bold text-gray-900">${estadisticasAdmin.totalTicketsMes}</td>
                                <td class="px-6 py-4 text-center">100%</td>
                                <td class="px-6 py-4 text-gray-500">Total acumulado de solicitudes registradas.</td>
                            </tr>
                            <tr class="hover:bg-emerald-50/30 transition-colors">
                                <td class="px-6 py-4 font-medium text-gray-900 flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-rose-500"></span> Casos de Alta Prioridad / Críticos
                                </td>
                                <td class="px-6 py-4 text-center font-bold text-rose-600">${estadisticasAdmin.criticos}</td>
                                <td class="px-6 py-4 text-center font-semibold text-rose-600">
                                    <c:choose>
                                        <c:when test="${estadisticasAdmin.totalTicketsMes > 0}">
                                            <c:out value="${Math.round((estadisticasAdmin.criticos * 100.0) / estadisticasAdmin.totalTicketsMes)}%" />
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-gray-500">Casos urgentes que requieren atención de primer nivel.</td>
                            </tr>
                            <tr class="hover:bg-emerald-50/30 transition-colors">
                                <td class="px-6 py-4 font-medium text-gray-900 flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-amber-500"></span> Casos sin Agente Asignado
                                </td>
                                <td class="px-6 py-4 text-center font-bold text-amber-600">${estadisticasAdmin.sinAsignar}</td>
                                <td class="px-6 py-4 text-center font-semibold text-amber-600">
                                    <c:choose>
                                        <c:when test="${estadisticasAdmin.totalTicketsMes > 0}">
                                            <c:out value="${Math.round((estadisticasAdmin.sinAsignar * 100.0) / estadisticasAdmin.totalTicketsMes)}%" />
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-gray-500">Solicitudes pendientes por reasignar a un técnico.</td>
                            </tr>
                            <tr class="hover:bg-emerald-50/30 transition-colors">
                                <td class="px-6 py-4 font-medium text-gray-900 flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-emerald-500"></span> Casos Cerrados Hoy
                                </td>
                                <td class="px-6 py-4 text-center font-bold text-emerald-600">${estadisticasAdmin.cerradosHoy}</td>
                                <td class="px-6 py-4 text-center font-semibold text-emerald-600">
                                    <c:choose>
                                        <c:when test="${estadisticasAdmin.totalTicketsMes > 0}">
                                            <c:out value="${Math.round((estadisticasAdmin.cerradosHoy * 100.0) / estadisticasAdmin.totalTicketsMes)}%" />
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 text-gray-500">Tickets finalizados con resolución exitosa el día de hoy.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
