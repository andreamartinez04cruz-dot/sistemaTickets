<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8" />
            <title>Reasignar Agentes</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
            <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
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
                
                <!-- Contenido Principal -->
                <main class="flex-1 p-8">
                    <div class="max-w-5xl mx-auto">
                    <!-- Cabecera -->
                    <div
                        class="flex items-center justify-between mb-8 p-6 bg-gradient-to-r from-emerald-50 to-green-50/20 rounded-2xl border border-emerald-100/70 shadow-sm">
                        <div>
                            <h1 class="text-3xl font-bold text-gray-900">Reasignar Agentes</h1>
                            <p class="text-sm text-emerald-800 font-medium mt-1">Asigna cada ticket a un agente
                                disponible.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/tickets"
                            class="px-4 py-2 rounded-xl bg-emerald-500 text-white hover:bg-emerald-600 font-semibold shadow-sm transition-colors">
                            Volver al panel
                        </a>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/reasignar-agentes"
                        class="grid grid-cols-1 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">ID del Ticket</label>
                            <c:choose>
                                <c:when test="${not empty ticketSeleccionado}">
                                    <input type="hidden" name="idTicket" value="${ticketSeleccionado}" />
                                    <input type="text"
                                        class="w-full border border-gray-200 bg-gray-50 text-gray-500 rounded-lg px-3 py-2 focus:outline-none cursor-not-allowed font-medium"
                                        value="Ticket #${ticketSeleccionado}" readonly />
                                </c:when>
                                <c:otherwise>
                                    <select name="idTicket"
                                        class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                        required>
                                        <option value="">Seleccione un ticket</option>
                                        <c:forEach var="t" items="${tickets}">
                                            <option value="${t.id}" data-agente="${t.idAgenteAsignado}">Ticket #${t.id}
                                                - ${t.solicitante} (${t.categoria})</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Agente</label>
                            <select name="idAgente"
                                class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
                                required>
                                <option value="">Seleccione un agente</option>
                                <c:forEach var="agente" items="${agentes}">
                                    <option value="${agente.id}">${agente.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="flex justify-end">
                            <button type="submit"
                                class="inline-flex items-center justify-center px-5 py-2.5 rounded-lg bg-green-600 text-white font-semibold hover:bg-green-700 shadow-sm">
                                Guardar reasignación
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const ticketSelect = document.querySelector('select[name="idTicket"]');
                    const agenteSelect = document.querySelector('select[name="idAgente"]');

                    if (ticketSelect && agenteSelect) {
                        // Guardar todas las opciones originales de agente en un array
                        const todasLasOpcionesAgente = Array.from(agenteSelect.options);

                        ticketSelect.addEventListener("change", function () {
                            const selectedOption = ticketSelect.options[ticketSelect.selectedIndex];
                            const idAgenteAsignado = selectedOption ? selectedOption.getAttribute("data-agente") : "";

                            // Limpiar selector de agentes
                            agenteSelect.innerHTML = "";

                            todasLasOpcionesAgente.forEach(option => {
                                // Omitir el agente que ya tiene asignado el ticket seleccionado
                                if (option.value !== "" && option.value === idAgenteAsignado) {
                                    return;
                                }
                                agenteSelect.appendChild(option.cloneNode(true));
                            });

                            // Reiniciar la selección del agente
                            agenteSelect.value = "";
                        });
                    }
                });
            </script>
        </body>

        </html>