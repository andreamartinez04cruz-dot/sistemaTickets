<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Tickets Asignados - SENA Mesa de Ayuda</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
    <body class="bg-background text-on-background min-h-screen flex flex-col">
        <!-- TopAppBar -->
        <header class="bg-surface dark:bg-surface-dim shadow-sm fixed top-0 w-full z-50 flex justify-between items-center px-margin-mobile md:px-margin-desktop h-16">
            <div class="flex items-center gap-4">
                <button class="p-2 rounded-full hover:bg-surface-container-high transition-colors text-on-surface-variant dark:text-on-surface-variant active:scale-95 transition-transform">
                    <span class="material-symbols-outlined" data-icon="menu">menu</span>
                </button>
                <div class="flex items-center gap-3">
                    <img alt="SENA Logo" class="h-8 w-8 object-contain" src="https://lh3.googleusercontent.com/aida/AP1WRLsgqsUoGT-2lwimwLtDM221DxP7NWvos4EH-jZO44clebvSs4G9xkk3qy5_sx5r-gM4QaISpEHQdi6MkDmZJjlCouJfjc7cqoB6IKxC6KqhF6otdPBmlirkRXwoftCPtJGBQyj1RHApkoKcCsMv5ZBZUKFMbmvqfkr06yOy5bowvIO_D_snGIHh_9WJluN-wBVSCTX9wmiL-2HUR0a5qth3wQ7dWYpJoACf7PPvRziZydOgCWGfP1eakb0"/>
                    <h1 class="font-headline-md text-headline-md-mobile md:text-headline-md font-bold text-primary dark:text-primary-fixed-dim">
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

        <!-- Layout contenedor (Menú + Contenido) -->
        <div class="flex flex-1 pt-16">
            <!-- Sidebar Menu -->
            <aside class="shrink-0">
                <jsp:include page="Menu.jsp"/>
            </aside>

            <!-- Main Content -->
            <main class="flex-grow w-full max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop py-stack-lg flex flex-col gap-stack-lg min-w-0">
                <!-- Page Title & Actions -->
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-stack-md">
                    <div>
                        <h2 class="font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Tickets Asignados</h2>
                        <p class="font-body-md text-body-md text-on-surface-variant mt-1">Gestiona los requerimientos asignados a tu perfil.</p>
                    </div>
                </div>

                <!-- Summary Cards (Bento style) -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-gutter">
                    <!-- Total -->
                    <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant flex items-center gap-4">
                        <div class="w-12 h-12 rounded-lg bg-surface-container-high flex items-center justify-center text-primary">
                            <span class="material-symbols-outlined icon-fill text-3xl">confirmation_number</span>
                        </div>
                        <div>
                            <p class="font-label-md text-label-md text-on-surface-variant">Mis Asignados</p>
                            <p class="font-display-lg text-display-lg text-on-surface">24</p>
                        </div>
                    </div>
                    <!-- Alta Prioridad -->
                    <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant flex items-center gap-4 relative overflow-hidden">
                        <div class="absolute left-0 top-0 bottom-0 w-1 bg-error"></div>
                        <div class="w-12 h-12 rounded-lg bg-error-container flex items-center justify-center text-error">
                            <span class="material-symbols-outlined icon-fill text-3xl">priority_high</span>
                        </div>
                        <div>
                            <p class="font-label-md text-label-md text-on-surface-variant">Alta Prioridad</p>
                            <p class="font-display-lg text-display-lg text-on-surface">5</p>
                        </div>
                    </div>
                    <!-- Vencen Hoy -->
                    <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant flex items-center gap-4 relative overflow-hidden">
                        <div class="absolute left-0 top-0 bottom-0 w-1 bg-[#f59e0b]"></div>
                        <div class="w-12 h-12 rounded-lg bg-[#fef3c7] flex items-center justify-center text-[#d97706]">
                            <span class="material-symbols-outlined icon-fill text-3xl">timer</span>
                        </div>
                        <div>
                            <p class="font-label-md text-label-md text-on-surface-variant">Vencen Hoy</p>
                            <p class="font-display-lg text-display-lg text-on-surface">3</p>
                        </div>
                    </div>
                </div>

                <!-- Filter/Search Bar -->
                <div class="bg-surface-container-lowest rounded-xl p-4 shadow-sm border border-outline-variant flex flex-col md:flex-row gap-4 items-center">
                    <div class="relative w-full md:w-96">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-on-surface-variant">search</span>
                        <input class="w-full pl-10 pr-4 py-2 bg-surface-container-low border border-outline-variant rounded-lg focus:outline-none focus:border-primary focus:ring-1 focus:ring-primary font-body-md text-body-md text-on-surface transition-colors" placeholder="Buscar por ID, asunto o solicitante..." type="text"/>
                    </div>
                    <div class="flex gap-2 w-full md:w-auto overflow-x-auto pb-1 md:pb-0">
                        <button class="px-4 py-2 rounded-lg bg-surface-container-high text-on-surface font-label-md text-label-md whitespace-nowrap hover:bg-surface-variant transition-colors border border-outline-variant">
                            Todos
                        </button>
                        <button class="px-4 py-2 rounded-lg bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md whitespace-nowrap hover:bg-surface-container-high transition-colors border border-outline-variant">
                            Abiertos
                        </button>
                        <button class="px-4 py-2 rounded-lg bg-surface-container-lowest text-on-surface-variant font-label-md text-label-md whitespace-nowrap hover:bg-surface-container-high transition-colors border border-outline-variant flex items-center gap-2">
                            <span class="material-symbols-outlined text-sm">filter_list</span>
                            Más filtros
                        </button>
                    </div>
                </div>

                <!-- Ticket List -->
                <div class="flex flex-col gap-4">
                    <!-- Ticket Card 1 (Alta) -->
                    <div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant p-5 hover:shadow-md transition-shadow relative overflow-hidden group cursor-pointer">
                        <div class="absolute left-0 top-0 bottom-0 w-1.5 bg-error group-hover:w-2 transition-all"></div>
                        <div class="flex flex-col md:flex-row justify-between gap-4">
                            <div class="flex flex-col gap-2 pl-2">
                                <div class="flex items-center gap-3 flex-wrap">
                                    <span class="font-label-md text-label-md text-on-surface-variant">#TK-9876</span>
                                    <span class="px-2 py-0.5 rounded-full bg-error-container text-on-error-container font-label-sm text-label-sm flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 rounded-full bg-error"></span> Alta
                                    </span>
                                    <span class="px-2 py-0.5 rounded-full bg-surface-container-high text-on-surface-variant font-label-sm text-label-sm border border-outline-variant">
                                        Abierto
                                    </span>
                                </div>
                                <h3 class="font-title-lg text-title-lg text-on-surface">Falla masiva en servidor Sofía Plus</h3>
                                <div class="flex items-center gap-4 text-on-surface-variant font-body-md text-body-md mt-1">
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">person</span>
                                        Carlos Mendoza
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">apartment</span>
                                        Centro de Industria
                                    </div>
                                </div>
                            </div>
                            <div class="flex flex-row md:flex-col items-center md:items-end justify-between pl-2 md:pl-0 border-t md:border-t-0 md:border-l border-outline-variant pt-3 md:pt-0 md:pl-4">
                                <div class="flex items-center gap-1 text-error font-label-md text-label-md bg-error-container/30 px-3 py-1 rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">timer</span>
                                    2h restantes
                                </div>
                                <button class="text-primary font-label-md text-label-md hover:underline mt-0 md:mt-auto flex items-center gap-1">
                                    Ver detalles <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Ticket Card 2 (Media) -->
                    <div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant p-5 hover:shadow-md transition-shadow relative overflow-hidden group cursor-pointer">
                        <div class="absolute left-0 top-0 bottom-0 w-1.5 bg-[#f59e0b] group-hover:w-2 transition-all"></div>
                        <div class="flex flex-col md:flex-row justify-between gap-4">
                            <div class="flex flex-col gap-2 pl-2">
                                <div class="flex items-center gap-3 flex-wrap">
                                    <span class="font-label-md text-label-md text-on-surface-variant">#TK-9842</span>
                                    <span class="px-2 py-0.5 rounded-full bg-[#fef3c7] text-[#92400e] font-label-sm text-label-sm flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 rounded-full bg-[#f59e0b]"></span> Media
                                    </span>
                                    <span class="px-2 py-0.5 rounded-full bg-primary-container text-on-primary-container font-label-sm text-label-sm border border-primary/20">
                                        En Proceso
                                    </span>
                                </div>
                                <h3 class="font-title-lg text-title-lg text-on-surface">Actualización de software laboratorio D-4</h3>
                                <div class="flex items-center gap-4 text-on-surface-variant font-body-md text-body-md mt-1">
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">person</span>
                                        Instructora Ana Ríos
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">apartment</span>
                                        Diseño y Multimedia
                                    </div>
                                </div>
                            </div>
                            <div class="flex flex-row md:flex-col items-center md:items-end justify-between pl-2 md:pl-0 border-t md:border-t-0 md:border-l border-outline-variant pt-3 md:pt-0 md:pl-4">
                                <div class="flex items-center gap-1 text-[#b45309] font-label-md text-label-md bg-[#fef3c7]/50 px-3 py-1 rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">schedule</span>
                                    Mañana
                                </div>
                                <button class="text-primary font-label-md text-label-md hover:underline mt-0 md:mt-auto flex items-center gap-1">
                                    Ver detalles <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Ticket Card 3 (Baja) -->
                    <div class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant p-5 hover:shadow-md transition-shadow relative overflow-hidden group cursor-pointer">
                        <div class="absolute left-0 top-0 bottom-0 w-1.5 bg-[#3b82f6] group-hover:w-2 transition-all"></div>
                        <div class="flex flex-col md:flex-row justify-between gap-4">
                            <div class="flex flex-col gap-2 pl-2">
                                <div class="flex items-center gap-3 flex-wrap">
                                    <span class="font-label-md text-label-md text-on-surface-variant">#TK-9810</span>
                                    <span class="px-2 py-0.5 rounded-full bg-[#dbeafe] text-[#1e40af] font-label-sm text-label-sm flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 rounded-full bg-[#3b82f6]"></span> Baja
                                    </span>
                                    <span class="px-2 py-0.5 rounded-full bg-surface-container-high text-on-surface-variant font-label-sm text-label-sm border border-outline-variant">
                                        Abierto
                                    </span>
                                </div>
                                <h3 class="font-title-lg text-title-lg text-on-surface">Solicitud de creación de cuenta correo SENA</h3>
                                <div class="flex items-center gap-4 text-on-surface-variant font-body-md text-body-md mt-1">
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">person</span>
                                        Luis Pérez (Aprendiz)
                                    </div>
                                    <div class="flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[18px]">apartment</span>
                                        Administrativa
                                    </div>
                                </div>
                            </div>
                            <div class="flex flex-row md:flex-col items-center md:items-end justify-between pl-2 md:pl-0 border-t md:border-t-0 md:border-l border-outline-variant pt-3 md:pt-0 md:pl-4">
                                <div class="flex items-center gap-1 text-on-surface-variant font-label-md text-label-md bg-surface-container-high px-3 py-1 rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">calendar_today</span>
                                    3 días
                                </div>
                                <button class="text-primary font-label-md text-label-md hover:underline mt-0 md:mt-auto flex items-center gap-1">
                                    Ver detalles <span class="material-symbols-outlined text-sm">arrow_forward</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <!-- Footer -->
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
    </body>
</html>