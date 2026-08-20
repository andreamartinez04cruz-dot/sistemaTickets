<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="co.edu.sena.mesa.modelo.Categoria" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SENA Help Desk - Registrar Requerimiento Administrativo</title>

        <!-- Material Symbols & Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#226d00",
                            "primary-container": "#39a900",
                            "on-primary-container": "#0c3400",
                            "background": "#f9f9f9",
                            "on-background": "#1a1c1c",
                            "surface": "#f9f9f9",
                            "on-surface": "#1a1c1c",
                            "on-surface-variant": "#3f4a38",
                            "outline-variant": "#becbb3",
                            "surface-container-low": "#f3f3f3",
                            "surface-container-high": "#e8e8e8",
                            "surface-container-lowest": "#ffffff"
                        }
                    }
                }
            }
        </script>
    </head>

    <body class="bg-background text-on-background min-h-screen flex flex-col">

        <!-- Layout Principal: Sidebar + Contenido -->
        <div class="flex pt-16 min-h-screen">

            <!-- Contenedor del Menú Lateral -->
            <aside class="w-64 fixed left-0 top-16 bottom-0 z-40 bg-surface border-r border-outline-variant overflow-y-auto hidden md:block">
                <jsp:include page="Menu.jsp"/>
            </aside>

            <!-- Main Content Area -->
            <main class="flex-1 md:ml-64 p-6 md:p-10 max-w-4xl mx-auto w-full pb-24 md:pb-12">

                <!-- Header de la Página -->
                <div class="mb-8">
                    <h2 class="text-2xl md:text-3xl font-bold text-on-surface">Registrar Requerimiento Administrativo</h2>
                    <p class="text-sm md:text-base text-on-surface-variant mt-1">Complete el siguiente formulario para generar un nuevo ticket de soporte o servicio.</p>
                </div>

                <!-- Formulario -->
                <form action="${pageContext.request.contextPath}/tickets/registrar/Funcionario" method="POST"
                      class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant p-6 md:p-8 flex flex-col gap-6 relative overflow-hidden">

                    <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary"></div>

                    <!-- Título -->
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-medium text-on-surface" for="titulo">Título del Requerimiento</label>
                        <input class="bg-surface border border-outline-variant rounded-md px-4 py-3 text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all" 
                               id="titulo" name="titulo" placeholder="Ej. Solicitud de insumos de papelería" type="text" required>
                    </div>

                    <!-- Descripción Detallada -->
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-medium text-on-surface" for="descripcion">Descripción Detallada <span class="text-red-600">*</span></label>
                        <textarea class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all resize-y" 
                                  id="descripcion" name="descripcion" placeholder="Describa el problema o solicitud con el mayor detalle posible..." required rows="4"></textarea>
                    </div>

                    <!-- Tipo de Solicitud (Categoría) -->
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-medium text-on-surface" for="categoria">
                            Tipo de Solicitud
                        </label>

                        <div class="relative">
                            <%
                                List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                            %>

                            <select class="w-full bg-surface border border-outline-variant rounded-md px-4 py-3 text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all appearance-none pr-10 cursor-pointer"
                                    id="categoria"
                                    name="idCategoria"
                                    required>

                                <option disabled selected value="">
                                    Seleccione el tipo de solicitud...
                                </option>

                                <%
                                    if (categorias != null) {
                                        for (Categoria cat : categorias) {
                                %>

                                <option value="<%= cat.getId()%>">
                                    <%= cat.getNombre()%>
                                </option>

                                <%
                                        }
                                    }
                                %>

                            </select>

                            <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">
                                expand_more
                            </span>
                        </div>
                    </div>

                    <!-- Jornada -->
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-medium text-on-surface" for="jornada">Jornada</label>
                        <div class="relative">
                            <select class="w-full bg-surface border border-outline-variant rounded-md px-4 py-3 text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all appearance-none pr-10 cursor-pointer"
                                    id="jornada" name="jornada" required>
                                <option disabled selected value="">Seleccione la jornada...</option>
                                <option value="MAÑANA">Mañana</option>
                                <option value="TARDE">Tarde</option>
                                <option value="NOCHE">Noche</option>
                            </select>
                            <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">
                                expand_more
                            </span>
                        </div>
                    </div>

                    <!-- Solicitante (Dinámico) -->
                    <div class="flex flex-col gap-2">
                        <label class="text-sm font-medium text-on-surface" for="ticket-applicant">Solicitante</label>
                        <div class="flex items-center gap-3 px-4 py-3 rounded-lg border border-surface-container-high bg-surface-container-low">
                            <span class="material-symbols-outlined text-on-surface-variant">person</span>
                            <input class="w-full bg-transparent text-on-surface-variant text-base focus:outline-none cursor-not-allowed" id="ticket-applicant" readonly type="text" value="${not empty sessionScope.usuario.nombre ? sessionScope.usuario.nombre : 'Aprendiz SENA'}"/>
                        </div>
                    </div>

                    <!-- Botones de Acción -->
                    <div class="pt-6 border-t border-outline-variant flex flex-col md:flex-row justify-end gap-4 mt-2">
                        <button class="order-2 md:order-1 px-6 py-3 rounded-full border border-primary text-primary font-semibold hover:bg-surface-container-high transition-all text-center" type="button" onclick="window.location.href='${pageContext.request.contextPath}/tickets/registrar/Funcionario?action=historial'">
                            Cancelar
                        </button>
                        <button class="order-1 md:order-2 px-8 py-3 rounded-full bg-primary-container text-on-primary-container font-bold hover:brightness-95 transition-all text-center flex items-center justify-center gap-2 shadow-sm" type="submit">
                            <span class="material-symbols-outlined text-lg">check_circle</span>
                            Registrar
                        </button>
                    </div>

                </form>
            </main>
        </div>

    </body>
</html>