<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="light" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Mesa de Ayuda SENA - Detalle de Ticket</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <!-- SweetAlert2 CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <%
            String mensajeExito = (String) session.getAttribute("mensajeExito");
            if (mensajeExito != null) {
                session.removeAttribute("mensajeExito");
        %>
        <script>
            Swal.fire({
                icon: 'success',
                title: '¡Éxito!',
                text: '<%= mensajeExito%>',
                timer: 2500,
                showConfirmButton: false
            });
        </script>
        <%
            }
        %>

        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#226d00",
                            "primary-container": "#39a900",
                            "primary-fixed": "#8afd5d",
                            background: "#f9f9f9",
                            surface: "#f9f9f9",
                            "surface-container": "#eeeeee",
                            "surface-container-low": "#f3f3f3",
                            "surface-container-lowest": "#ffffff",
                            "surface-container-high": "#e8e8e8",
                            "surface-variant": "#e2e2e2",
                            "on-surface": "#1a1c1c",
                            "on-surface-variant": "#3f4a38",
                            "on-primary": "#ffffff",
                            "on-primary-container": "#0c3400",
                            outline: "#6f7b66",
                            "outline-variant": "#becbb3",
                            tertiary: "#5d5f5e"
                        },
                        borderRadius: {
                            DEFAULT: "0.25rem",
                            lg: "0.5rem",
                            xl: "0.75rem",
                            full: "9999px"
                        },
                        spacing: {
                            "stack-sm": "8px",
                            "stack-md": "16px",
                            "stack-lg": "32px",
                            gutter: "24px"
                        },
                        fontFamily: {
                            body: ["Work Sans"],
                            headline: ["Work Sans"]
                        }
                    }
                }
            };
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
            }
        </style>
    </head>

    <body class="bg-background text-on-surface min-h-screen flex flex-col">
        <main class="flex-grow max-w-7xl mx-auto w-full px-4 md:px-8 py-8">
            <div class="mb-8 flex flex-col md:flex-row md:justify-between md:items-center gap-4">
                <div>
                    <div class="flex items-center gap-3 mb-2">
                        <h2 class="text-3xl font-bold">
                            #TK-${ticket.id}
                        </h2>
                        <!-- ESTADO -->
                        <span class="bg-yellow-100 text-yellow-800 font-medium px-3 py-1 rounded-full border border-yellow-300 flex items-center gap-1">
                            <span class="material-symbols-outlined" style="font-size:16px;">
                                pending
                            </span>
                            ${ticket.estado}
                        </span>
                    </div>
                    <!-- TITULO -->
                    <h3 class="text-xl font-medium">
                        ${ticket.titulo}
                    </h3>
                </div>
                <!-- BOTON VOLVER -->
                <div>
                    <a href="${pageContext.request.contextPath}/agente/tickets" class="border border-primary text-primary hover:bg-green-50 font-medium px-4 py-2 rounded-lg transition-colors flex items-center gap-2">
                        <span class="material-symbols-outlined" style="font-size:18px;">
                            arrow_back
                        </span>
                        Volver
                    </a>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-12 gap-6">
                <div class="md:col-span-8 flex flex-col gap-8">
                    <div class="bg-white rounded-xl shadow-sm border border-outline-variant overflow-hidden relative">
                        <!-- BARRA LATERAL -->
                        <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary"></div>
                        <div class="p-6 ml-1">
                            <!-- INFORMACION -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6 mb-6 border-b border-surface-variant pb-6">
                                <div>
                                    <p class="text-xs font-semibold text-on-surface-variant mb-1">
                                        Categoría
                                    </p>
                                    <p class="text-base flex items-center gap-1">
                                        <span class="material-symbols-outlined text-outline" style="font-size:18px;">
                                            computer
                                        </span>
                                        ${ticket.categoriaNombre}
                                    </p>
                                </div>
                                <div>
                                    <p class="text-xs font-semibold text-on-surface-variant mb-1">
                                        Fecha de Creación
                                    </p>
                                    <p class="text-base">
                                        ${ticket.fechaCreacion}
                                    </p>
                                </div>
                                <div>
                                    <p class="text-xs font-semibold text-on-surface-variant mb-1">
                                        Solicitante
                                    </p>
                                    <p class="text-base flex items-center gap-1">
                                        <span class="material-symbols-outlined text-outline" style="font-size:18px;">
                                            person
                                        </span>
                                        ${ticket.solicitanteNombre}
                                    </p>
                                </div>
                            </div>
                            <div>
                                <h4 class="text-xl font-medium mb-3">
                                    Descripción
                                </h4>
                                <p class="text-base text-on-surface-variant whitespace-pre-line leading-relaxed">
                                    ${ticket.descripcion}
                                </p>
                            </div>
                        </div>
                    </div>

                    <div>
                        <h4 class="text-xl font-medium mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">
                                forum
                            </span>
                            Historial de Actividad
                        </h4>
                        <div class="flex flex-col gap-4">
                            <c:choose>
                                <c:when test="${not empty comentarios}">
                                    <c:forEach var="comentario" items="${comentarios}">
                                        <div class="flex gap-4">
                                            <!-- AVATAR -->
                                            <div class="flex-shrink-0">
                                                <div class="w-10 h-10 rounded-full bg-primary-container text-white flex items-center justify-center font-bold">
                                                    ${not empty comentario.nombreUsuario ? comentario.nombreUsuario.substring(0,1) : 'U'}
                                                </div>
                                            </div>
                                            <!-- COMENTARIO -->
                                            <div class="bg-white rounded-lg p-4 flex-grow border border-outline-variant shadow-sm">
                                                <!-- AUTOR Y FECHA -->
                                                <div class="flex justify-between items-start mb-2 gap-3">
                                                    <span class="font-semibold">
                                                        ${not empty comentario.nombreUsuario ? comentario.nombreUsuario : 'Usuario'}
                                                    </span>
                                                    <span class="text-xs text-on-surface-variant">
                                                        ${comentario.fechaFormateada}
                                                    </span>
                                                </div>
                                                <!-- TEXTO -->
                                                <p class="text-on-surface-variant whitespace-pre-line">
                                                    ${comentario.texto}
                                                </p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-surface-container-low rounded-lg p-6 border border-outline-variant text-center">
                                        <span class="material-symbols-outlined text-4xl text-tertiary">
                                            forum
                                        </span>
                                        <p class="text-on-surface-variant mt-2">
                                            Aún no hay comentarios en este ticket.
                                        </p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="md:col-span-4">
                    <div class="bg-white rounded-xl shadow-sm border border-outline-variant p-6 sticky top-6">
                        <c:choose>
                            <c:when test="${ticket.estado == 'CERRADO' || ticket.estado == 'CANCELADO' || ticket.estado == 'RESUELTO'}">
                                <div class="rounded-lg border border-red-200 bg-red-50 p-4 text-red-700">
                                    <p class="font-semibold mb-2">Comentarios bloqueados</p>
                                    <p class="text-sm">Este ticket ya está en estado final y no admite más comentarios.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <h4 class="text-xl font-medium mb-4">
                                    Agregar Comentario
                                </h4>
                                <form action="${pageContext.request.contextPath}/tickets/comentar" method="POST" class="flex flex-col gap-4">
                                    <!-- ID DEL TICKET -->
                                    <input type="hidden" name="idTicket" value="${ticket.id}"/>
                                    <!-- TEXTO -->
                                    <div>
                                        <label class="block text-sm font-medium text-on-surface-variant mb-2" for="comment-box">
                                            Mensaje
                                        </label>
                                        <textarea id="comment-box" name="texto" required rows="5" placeholder="Escribe tu comentario o avance aquí..." class="w-full rounded-lg border border-outline bg-white p-3 text-base focus:border-primary focus:ring-1 focus:ring-primary outline-none resize-none"></textarea>
                                    </div>
                                    <!-- BOTON -->
                                    <button type="submit" class="bg-primary text-white hover:bg-primary-container font-medium px-6 py-3 rounded-lg transition-colors shadow-sm flex items-center justify-center gap-2">
                                        Enviar
                                        <span class="material-symbols-outlined" style="font-size:18px;">
                                            send
                                        </span>
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>

        <div class="md:hidden fixed bottom-0 left-0 w-full bg-white border-t border-outline-variant p-4 shadow-lg z-40">
            <a href="${pageContext.request.contextPath}/agente/tickets" class="w-full border border-primary text-primary py-3 rounded-lg flex items-center justify-center gap-2">
                <span class="material-symbols-outlined">
                    arrow_back
                </span>
                Volver
            </a>
        </div>
    </body>
</html>