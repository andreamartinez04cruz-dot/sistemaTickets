<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="co.edu.sena.mesa.servicio.TicketService" %>
<%@ page import="co.edu.sena.mesa.modelo.Categoria" %>
<%@ page import="java.util.List" %>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    if (categorias == null) {
        TicketService ticketService = (TicketService) getServletContext().getAttribute("ticketService");
        if (ticketService != null) {
            categorias = ticketService.ListarCategorias();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Registrar Ticket</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>

        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "on-background": "#1a1c1c",
                            "surface-container": "#eeeeee",
                            "inverse-surface": "#2f3131",
                            "surface": "#f9f9f9",
                            "secondary-container": "#dfe0e0",
                            "on-surface-variant": "#3f4a38",
                            "secondary": "#5d5f5f",
                            "on-tertiary": "#ffffff",
                            "outline": "#6f7b66",
                            "tertiary-fixed": "#e2e2e2",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "on-error-container": "#93000a",
                            "surface-container-high": "#e8e8e8",
                            "tertiary": "#5d5f5e",
                            "outline-variant": "#becbb3",
                            "surface-bright": "#f9f9f9",
                            "surface-dim": "#dadada",
                            "secondary-fixed": "#e2e2e2",
                            "on-primary": "#ffffff",
                            "on-secondary-container": "#616363",
                            "on-tertiary-container": "#2a2c2c",
                            "inverse-on-surface": "#f1f1f1",
                            "surface-tint": "#226d00",
                            "background": "#f9f9f9",
                            "on-primary-fixed-variant": "#185200",
                            "on-primary-fixed": "#052100",
                            "on-tertiary-fixed-variant": "#454747",
                            "surface-variant": "#e2e2e2",
                            "on-tertiary-fixed": "#1a1c1c",
                            "on-primary-container": "#0c3400",
                            "on-secondary-fixed-variant": "#454747",
                            "primary": "#226d00",
                            "on-secondary": "#ffffff",
                            "primary-fixed-dim": "#6fdf43",
                            "surface-container-low": "#f3f3f3",
                            "on-surface": "#1a1c1c",
                            "primary-fixed": "#8afd5d",
                            "surface-container-highest": "#e2e2e2",
                            "surface-container-lowest": "#ffffff",
                            "error": "#ba1a1a",
                            "inverse-primary": "#6fdf43",
                            "primary-container": "#39a900",
                            "secondary-fixed-dim": "#c6c6c7",
                            "on-secondary-fixed": "#1a1c1c",
                            "on-error": "#ffffff",
                            "tertiary-container": "#929393",
                            "error-container": "#ffdad6"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "container-max": "1280px",
                            "margin-mobile": "16px",
                            "stack-lg": "32px",
                            "margin-desktop": "32px",
                            "gutter": "24px",
                            "stack-sm": "8px",
                            "unit": "8px",
                            "stack-md": "16px"
                        },
                        "fontFamily": {
                            "headline-lg-mobile": ["Work Sans"],
                            "label-md": ["Work Sans"],
                            "body-lg": ["Work Sans"],
                            "headline-md": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "title-lg": ["Work Sans"],
                            "display-lg": ["Work Sans"],
                            "headline-lg": ["Work Sans"],
                            "label-sm": ["Work Sans"]
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            .input-focus-ring:focus-within {
                box-shadow: 0 0 0 2px rgba(57, 169, 0, 0.2);
                border-color: #39a900;
            }
        </style>
    </head>
    <body class="bg-background text-on-background min-h-screen flex">
        
        <!-- UNICO LLAMADO AL MENU -->
        <jsp:include page="Menu.jsp"/>

        <!-- CONTENEDOR PRINCIPAL -->
        <div class="flex-grow flex flex-col min-w-0">

            <!-- TopAppBar -->
            <header class="w-full flex justify-between items-center px-margin-mobile md:px-margin-desktop h-16 bg-surface dark:bg-surface-dim shadow-sm border-b border-outline-variant sticky top-0 z-30">
                <div class="flex items-center gap-2">
                    <h1 class="font-headline-md text-headline-md font-bold text-primary dark:text-primary-fixed-dim">Panel de Aprendiz</h1>
                </div>
                <div class="flex items-center gap-4">
                    <button class="text-on-surface-variant hover:bg-surface-container-high transition-colors p-2 rounded-full">
                        <span class="material-symbols-outlined">notifications</span>
                    </button>
                    <div class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center font-bold text-sm">
                        AP
                    </div>
                </div>
            </header>

            <!-- Formulario -->
            <main class="flex-grow flex flex-col items-center py-stack-lg px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto">
                <div class="w-full max-w-3xl">
                    <!-- Header Section -->
                    <div class="mb-stack-lg">
                        <h2 class="font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-background mb-stack-sm">Registrar Nuevo Ticket</h2>
                        <p class="font-body-md text-body-md text-on-surface-variant">Complete los detalles a continuación para reportar una incidencia o solicitar un servicio.</p>
                    </div>

                    <!-- Form Card -->
                    <div class="bg-surface-container-lowest rounded-xl shadow-sm border border-surface-container p-stack-lg relative overflow-hidden">
                        <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary"></div>

                        <form action="${pageContext.request.contextPath}/tickets/registrar" method="POST" class="flex flex-col gap-gutter">
                            <!-- Título -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-title">Título del Ticket <span class="text-error">*</span></label>
                                <input name="titulo" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all" id="ticket-title" placeholder="Ej: Problema con acceso a correo institucional" required type="text"/>
                            </div>

                            <!-- Categoría -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-category">Categoría <span class="text-error">*</span></label>
                                <div class="relative">
                                    <select name="idCategoria" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md appearance-none focus:outline-none input-focus-ring transition-all" id="ticket-category" required>
                                        <option disabled selected value="">Seleccione una categoría</option>
                                        <%
                                            if (categorias != null) {
                                                for (Categoria cat : categorias) {
                                        %>
                                            <option value="<%= cat.getId() %>"><%= cat.getNombre() %></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                    <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">expand_more</span>
                                </div>
                            </div>

                            <!-- Descripción -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-description">Descripción Detallada <span class="text-error">*</span></label>
                                <textarea name="descripcion" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all resize-y" id="ticket-description" placeholder="Describa el problema o solicitud con el mayor detalle posible..." required rows="5"></textarea>
                            </div>

                            <!-- Solicitante (Dinámico) -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-applicant">Solicitante</label>
                                <div class="flex items-center gap-3 px-4 py-3 rounded-lg border border-surface-container-high bg-surface-container-low">
                                    <span class="material-symbols-outlined text-on-surface-variant">person</span>
                                    <input class="w-full bg-transparent text-on-surface-variant font-body-md text-body-md focus:outline-none cursor-not-allowed" id="ticket-applicant" readonly type="text" value="${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre : 'Aprendiz SENA'}"/>
                                </div>
                            </div>

                            <!-- Programa -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-programa">Programa <span class="text-error">*</span></label>
                                <input name="programa" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all" id="ticket-programa" placeholder="Ej: Análisis y Desarrollo de Software" required type="text"/>
                            </div>

                            <!-- Número de programa -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-numeroPrograma">Número de Programa (Ficha) <span class="text-error">*</span></label>
                                <input name="numeroPrograma" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all" id="ticket-numeroPrograma" placeholder="Ej: 2712345" required type="text"/>
                            </div>

                            <!-- Instructor -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-instructor">Instructor <span class="text-error">*</span></label>
                                <input name="instructor" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all" id="ticket-instructor" placeholder="Ej: Osman" required type="text"/>
                            </div>

                            <!-- Jornada -->
                            <div class="flex flex-col gap-stack-sm">
                                <label class="font-label-md text-label-md text-on-surface" for="ticket-jornada">Jornada <span class="text-error">*</span></label>
                                <div class="relative">
                                    <select name="jornada" class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md appearance-none focus:outline-none input-focus-ring transition-all" id="ticket-jornada" required>
                                        <option disabled selected value="">Seleccione una jornada</option>
                                        <option value="Mañana">Mañana</option>
                                        <option value="Tarde">Tarde</option>
                                        <option value="Noche">Noche</option>
                                    </select>
                                    <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">expand_more</span>
                                </div>
                            </div>

                            <!-- Acciones -->
                            <div class="flex justify-end gap-4 mt-stack-md pt-stack-md border-t border-surface-container">
                                <button class="px-6 py-2.5 rounded-lg border border-outline-variant text-on-surface font-label-md text-label-md hover:bg-surface-container-low transition-colors" type="button">
                                    Cancelar
                                </button>
                                <button class="px-6 py-2.5 rounded-lg bg-primary-container text-white font-label-md text-label-md hover:bg-on-primary-fixed-variant transition-colors shadow-sm flex items-center gap-2" type="submit">
                                    <span class="material-symbols-outlined text-sm">send</span>
                                    Registrar Ticket
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Tarjeta de Información -->
                    <div class="mt-stack-md bg-secondary-container rounded-lg p-stack-md flex gap-4 items-start shadow-sm">
                        <span class="material-symbols-outlined text-primary mt-1">info</span>
                        <div>
                            <h4 class="font-title-lg text-title-lg text-on-surface mb-1">Tiempos de Respuesta</h4>
                            <p class="font-body-sm text-body-sm text-on-surface-variant">Los tickets de criticidad alta serán atendidos en un plazo máximo de 4 horas hábiles. Para otras categorías, el tiempo estándar de respuesta es de 24 a 48 horas.</p>
                        </div>
                    </div>
                </div>
            </main>

            <!-- Footer -->
            <footer class="w-full py-stack-md px-margin-mobile flex flex-col md:flex-row justify-between items-center gap-stack-sm bg-surface-container-lowest dark:bg-inverse-surface border-t border-outline-variant mt-auto">
                <div class="font-label-md text-label-md font-bold text-secondary flex items-center gap-2">
                    <img alt="SENA Logo" class="h-6 w-auto opacity-70 grayscale" src="https://upload.wikimedia.org/wikipedia/commons/8/8c/SENA_Logo.svg"/>
                </div>
                <p class="font-label-sm text-label-sm text-on-surface-variant">© 2024 Servicio Nacional de Aprendizaje SENA. Todos los derechos reservados.</p>
                <div class="flex gap-4">
                    <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors" href="#">Privacidad</a>
                    <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors" href="#">Términos de Uso</a>
                    <a class="font-label-sm text-label-sm text-on-surface-variant hover:text-primary transition-colors" href="#">Contacto</a>
                </div>
            </footer>
        </div>

    </body>
</html>