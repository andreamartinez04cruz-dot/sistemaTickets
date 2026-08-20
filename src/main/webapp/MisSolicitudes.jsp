<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="light" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Help Desk - Historial de Tickets</title>

        <!-- Google Fonts & Material Symbols -->
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary-fixed-dim": "#6fdf43",
                            "inverse-surface": "#2f3131",
                            "surface-container": "#eeeeee",
                            "background": "#f9f9f9",
                            "tertiary-container": "#929393",
                            "on-secondary-container": "#616363",
                            "on-error": "#ffffff",
                            "on-primary-container": "#0c3400",
                            "tertiary-fixed": "#e2e2e2",
                            "primary-container": "#39a900",
                            "on-tertiary-container": "#2a2c2c",
                            "on-tertiary-fixed": "#1a1c1c",
                            "tertiary": "#5d5f5e",
                            "on-surface-variant": "#3f4a38",
                            "error": "#ba1a1a",
                            "error-container": "#ffdad6",
                            "on-background": "#1a1c1c",
                            "surface-container-low": "#f3f3f3",
                            "surface-container-high": "#e8e8e8",
                            "on-primary-fixed-variant": "#185200",
                            "inverse-primary": "#6fdf43",
                            "primary": "#226d00",
                            "outline-variant": "#becbb3",
                            "surface-container-lowest": "#ffffff",
                            "secondary-fixed": "#e2e2e2",
                            "on-error-container": "#93000a",
                            "primary-fixed": "#8afd5d",
                            "on-primary-fixed": "#052100",
                            "surface": "#f9f9f9",
                            "surface-variant": "#e2e2e2",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "secondary": "#5d5f5e",
                            "surface-tint": "#226d00",
                            "outline": "#6f7b66",
                            "on-secondary": "#ffffff",
                            "surface-container-highest": "#e2e2e2",
                            "on-tertiary": "#ffffff",
                            "surface-bright": "#f9f9f9",
                            "on-surface": "#1a1c1c",
                            "on-secondary-fixed": "#1a1c1c",
                            "on-primary": "#ffffff",
                            "on-tertiary-fixed-variant": "#454747",
                            "inverse-on-surface": "#f1f1f1",
                            "on-secondary-fixed-variant": "#454747",
                            "secondary-container": "#dfe0e0",
                            "surface-dim": "#dadada",
                            "secondary-fixed-dim": "#c6c6c7"
                        },
                        spacing: {
                            "gutter": "24px",
                            "unit": "8px",
                            "container-max": "1280px",
                            "margin-desktop": "32px",
                            "stack-sm": "8px",
                            "margin-mobile": "16px",
                            "stack-md": "16px",
                            "stack-lg": "32px"
                        },
                        fontFamily: {
                            "body-lg": ["Work Sans", "sans-serif"]
                        }
                    }
                }
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            body {
                background-color: #f9f9f9;
                color: #1a1c1c;
            }
            .swal2-popup.custom-cancel-popup {
                border-radius: 16px;
                border: 1px solid #dfe0e0;
                box-shadow: 0 20px 45px rgba(0, 0, 0, 0.12);
            }
            .swal2-title.custom-cancel-title {
                font-family: 'Work Sans', sans-serif;
                color: #1a1c1c;
                font-size: 1.3rem;
                font-weight: 700;
            }
            .swal2-html-container.custom-cancel-text {
                color: #454747;
                font-size: 0.98rem;
            }
            .swal2-confirm.custom-confirm-btn,
            .swal2-cancel.custom-cancel-btn {
                border-radius: 9999px !important;
                padding: 0.6rem 1.3rem !important;
                font-weight: 600 !important;
                font-family: 'Work Sans', sans-serif;
            }
            .swal2-confirm.custom-confirm-btn {
                background: #ba1a1a !important;
            }
            .swal2-cancel.custom-cancel-btn {
                background: #e8e8e8 !important;
                color: #1a1c1c !important;
            }
        </style>
    </head>

    <body class="antialiased font-body-lg overflow-x-hidden min-h-screen bg-background">

        <!-- Contenedor Flex Principal (Menú + Contenido) -->
        <div class="flex min-h-screen">

            <!-- Menú Lateral Dinámico (Menu.jsp) -->
            <jsp:include page="Menu.jsp"/>


            <!-- Contenido Principal -->
            <main class="flex-1 p-6 md:p-8 max-w-container-max mx-auto w-full pb-24 md:pb-8">

                <!-- Header Section -->
                <div class="mb-stack-lg flex justify-between items-center">
                    <c:set var="rolActual" value="${not empty sessionScope.rolUsuario ? sessionScope.rolUsuario : sessionScope.usuario.rol}" />
                    <c:set var="nuevaSolicitudUrl" value="${pageContext.request.contextPath}/tickets/registrar" />
                    <c:set var="cancelarTicketUrlBase" value="${pageContext.request.contextPath}/tickets/registrar" />
                    <c:if test="${rolActual == 'FUNCIONARIO'}">
                        <c:set var="nuevaSolicitudUrl" value="${pageContext.request.contextPath}/tickets/registrar/Funcionario" />
                    </c:if>
                    <div>
                        <h1 class="font-headline-lg text-3xl md:text-4xl font-bold text-on-surface mb-stack-sm">Historial de Tickets</h1>
                        <p class="font-body-md text-on-surface-variant">Revisa el estado y el historial de todas tus solicitudes.</p>
                    </div>
                    <!-- Botón para ir al formulario de nueva solicitud -->
                    <a href="${nuevaSolicitudUrl}" 
                       class="bg-primary hover:bg-primary-fixed-dim text-white font-medium px-4 py-2 rounded-lg transition-colors flex items-center gap-2">
                        <span class="material-symbols-outlined text-sm">add</span> Nueva Solicitud
                    </a>
                </div>

                <!-- Grilla de Tarjetas Dinámica -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                    <!-- Bucle JSTL para renderizar las solicitudes traídas del Servlet -->
                    <c:forEach var="ticket" items="${tickets}">
                        <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant relative overflow-hidden flex flex-col h-full hover:shadow-md transition-shadow">

                            <!-- Borde lateral dinámico según estado -->
                            <div class="absolute left-0 top-0 bottom-0 w-1 
                                 <c:choose>
                                     <c:when test="${ticket.estadoNombre == 'RESUELTO' || ticket.estadoNombre == 'CERRADO'}">bg-primary-container</c:when>
                                     <c:when test="${ticket.estadoNombre == 'EN_PROCESO'}">bg-yellow-500</c:when>
                                     <c:otherwise>bg-tertiary</c:otherwise>
                                 </c:choose>">
                            </div>

                            <!-- Encabezado de Tarjeta -->
                            <div class="flex justify-between items-start mb-4">
                                <span class="text-xs text-on-surface-variant font-medium">#TK-${ticket.id}</span>

                                <!-- Badge de Estado -->
                                <span class="px-3 py-1 rounded-full text-xs font-medium border 
                                      <c:choose>
                                          <c:when test="${ticket.estadoNombre == 'RESUELTO' || ticket.estadoNombre == 'CERRADO'}">bg-primary-container/20 text-on-primary-container border-primary-container/30</c:when>
                                          <c:when test="${ticket.estadoNombre == 'EN_PROCESO'}">bg-yellow-500/20 text-yellow-800 border-yellow-500/30</c:when>
                                          <c:otherwise>bg-surface-variant text-on-surface-variant border-outline-variant</c:otherwise>
                                      </c:choose>">
                                    ${ticket.estadoNombre}
                                </span>
                            </div>

                            <!-- Título del Ticket -->
                            <h3 class="text-lg font-bold text-on-surface mb-2 line-clamp-2">${ticket.titulo}</h3>

                            <!-- Categoría -->
                            <div class="flex items-center gap-2 mb-4">
                                <span class="material-symbols-outlined text-[16px] text-tertiary">confirmation_number</span>
                                <span class="text-sm text-tertiary">${ticket.categoriaNombre}</span>
                            </div>

                            <!-- Pie de Tarjeta -->
                            <div class="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center gap-3 flex-wrap">
                                <span class="text-xs text-on-surface-variant">${ticket.fechaCreacion}</span>
                                <div class="flex items-center gap-3">
                                    <c:set var="estadoTicket" value="${ticket.estadoNombre}" />
                                    <c:if test="${empty estadoTicket || (estadoTicket != 'EN_PROCESO' && estadoTicket != 'CERRADO' && estadoTicket != 'RESUELTO' && estadoTicket != 'CANCELADO')}">
                                                     <a href="${cancelarTicketUrlBase}?action=cancelar&idTicket=${ticket.id}"
                                                         onclick="return confirmarCancelacion(event, this.href);"
                                           class="text-error hover:text-on-error-container text-sm font-semibold transition-colors">
                                            Cancelar
                                        </a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/tickets/comentar?id=${ticket.id}"
                                       class="text-primary hover:text-primary-fixed-dim text-sm font-medium flex items-center gap-1 transition-colors">
                                        Ver Detalles <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Mensaje dinámico si no hay solicitudes -->
                    <c:if test="${empty tickets}">
                        <div class="col-span-full text-center py-12 bg-surface-container-lowest rounded-xl border border-outline-variant">
                            <span class="material-symbols-outlined text-4xl text-tertiary mb-2">inbox</span>
                            <p class="text-on-surface-variant font-medium">No se encontraron solicitudes registradas.</p>
                        </div>
                    </c:if>

                </div>
            </main>
        </div>

        <script>
            function confirmarCancelacion(event, url) {
                event.preventDefault();

                Swal.fire({
                    title: '¿Seguro que deseas cancelar este ticket?',
                    html: 'Esta acción cambiará el estado a <b>CANCELADO</b> y no se puede deshacer fácilmente.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Sí, cancelar ticket',
                    cancelButtonText: 'Volver',
                    reverseButtons: true,
                    focusCancel: true,
                    customClass: {
                        popup: 'custom-cancel-popup',
                        title: 'custom-cancel-title',
                        htmlContainer: 'custom-cancel-text',
                        confirmButton: 'custom-confirm-btn',
                        cancelButton: 'custom-cancel-btn'
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = url;
                    }
                });

                return false;
            }
        </script>

    </body>
</html>