<!DOCTYPE html>

<html class="light" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Dashboard Administrador</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "tertiary-fixed": "#e2e2e2",
                            "outline": "#6f7b66",
                            "on-background": "#1a1c1c",
                            "surface-container-lowest": "#ffffff",
                            "inverse-surface": "#2f3131",
                            "surface-container-high": "#e8e8e8",
                            "on-tertiary-fixed-variant": "#454747",
                            "on-primary-container": "#0c3400",
                            "on-primary-fixed": "#052100",
                            "secondary-container": "#dfe0e0",
                            "tertiary-container": "#929393",
                            "surface": "#f9f9f9",
                            "on-secondary-fixed-variant": "#454747",
                            "on-secondary": "#ffffff",
                            "on-tertiary-container": "#2a2c2c",
                            "on-secondary-fixed": "#1a1c1c",
                            "on-secondary-container": "#616363",
                            "on-primary": "#ffffff",
                            "tertiary": "#5d5f5e",
                            "surface-variant": "#e2e2e2",
                            "outline-variant": "#becbb3",
                            "secondary-fixed": "#e2e2e2",
                            "surface-bright": "#f9f9f9",
                            "background": "#f9f9f9",
                            "surface-container": "#eeeeee",
                            "on-primary-fixed-variant": "#185200",
                            "primary-container": "#39a900",
                            "primary-fixed": "#8afd5d",
                            "secondary": "#5d5f5f",
                            "on-surface": "#1a1c1c",
                            "on-tertiary": "#ffffff",
                            "primary": "#226d00",
                            "inverse-on-surface": "#f1f1f1",
                            "error": "#ba1a1a",
                            "surface-container-low": "#f3f3f3",
                            "surface-dim": "#dadada",
                            "primary-fixed-dim": "#6fdf43",
                            "error-container": "#ffdad6",
                            "on-error-container": "#93000a",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "secondary-fixed-dim": "#c6c6c7",
                            "surface-tint": "#226d00",
                            "on-error": "#ffffff",
                            "surface-container-highest": "#e2e2e2",
                            "on-tertiary-fixed": "#1a1c1c",
                            "on-surface-variant": "#3f4a38",
                            "inverse-primary": "#6fdf43"
                        },
                        borderRadius: {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        spacing: {
                            "unit": "8px",
                            "margin-desktop": "32px",
                            "stack-lg": "32px",
                            "margin-mobile": "16px",
                            "container-max": "1280px",
                            "stack-sm": "8px",
                            "stack-md": "16px",
                            "gutter": "24px"
                        },
                        fontFamily: {
                            "title-lg": ["Work Sans"],
                            "headline-md": ["Work Sans"],
                            "headline-lg-mobile": ["Work Sans"],
                            "body-lg": ["Work Sans"],
                            "display-lg": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "label-sm": ["Work Sans"],
                            "label-md": ["Work Sans"],
                            "headline-lg": ["Work Sans"]
                        },
                        fontSize: {
                            "title-lg": ["20px", {lineHeight: "28px", fontWeight: "500"}],
                            "headline-md": ["24px", {lineHeight: "32px", fontWeight: "600"}],
                            "headline-lg-mobile": ["24px", {lineHeight: "32px", fontWeight: "600"}],
                            "body-lg": ["18px", {lineHeight: "28px", fontWeight: "400"}],
                            "display-lg": ["48px", {lineHeight: "56px", letterSpacing: "-0.02em", fontWeight: "700"}],
                            "body-md": ["16px", {lineHeight: "24px", fontWeight: "400"}],
                            "label-sm": ["12px", {lineHeight: "16px", fontWeight: "600"}],
                            "label-md": ["14px", {lineHeight: "20px", letterSpacing: "0.01em", fontWeight: "500"}],
                            "headline-lg": ["32px", {lineHeight: "40px", fontWeight: "600"}]
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #F4F4F4;
            }
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            .icon-fill {
                font-variation-settings: 'FILL' 1;
            }
        </style>
    </head>
    <body class="bg-background text-on-background min-h-screen flex flex-col pt-16">
        <!-- TopAppBar -->
        <header class="bg-surface dark:bg-surface-dim font-headline-md text-headline-md-mobile md:text-headline-md docked full-width top-0 shadow-sm fixed top-0 w-full z-50 flex justify-between items-center px-margin-mobile md:px-margin-desktop py-stack-sm h-16">
            <div class="flex items-center gap-4">
                <button class="text-on-surface-variant dark:text-on-surface-variant hover:bg-surface-container-high transition-colors active:scale-95 transition-transform p-2 rounded-full flex items-center justify-center">
                    <span class="material-symbols-outlined">menu</span>
                </button>
                <div class="flex items-center gap-3">
                    <img alt="SENA Logo" class="h-8 object-contain" src="https://lh3.googleusercontent.com/aida/AP1WRLsgqsUoGT-2lwimwLtDM221DxP7NWvos4EH-jZO44clebvSs4G9xkk3qy5_sx5r-gM4QaISpEHQdi6MkDmZJjlCouJfjc7cqoB6IKxC6KqhF6otdPBmlirkRXwoftCPtJGBQyj1RHApkoKcCsMv5ZBZUKFMbmvqfkr06yOy5bowvIO_D_snGIHh_9WJluN-wBVSCTX9wmiL-2HUR0a5qth3wQ7dWYpJoACf7PPvRziZydOgCWGfP1eakb0"/>
                    <span class="font-headline-md text-headline-md font-bold text-primary dark:text-primary-fixed-dim hidden md:block">SENA Mesa de Ayuda</span>
                </div>
            </div>
            <div class="flex items-center gap-4">
                <button class="text-on-surface-variant hover:bg-surface-container-high p-2 rounded-full transition-colors relative">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="absolute top-1 right-1 w-2.5 h-2.5 bg-error rounded-full border-2 border-surface"></span>
                </button>
                <div class="w-8 h-8 rounded-full bg-primary-container text-on-primary-container flex items-center justify-center font-label-md font-bold">
                    AD
                </div>
            </div>
        </header>
        <main class="flex-grow max-w-container-max mx-auto w-full px-margin-mobile md:px-margin-desktop py-stack-lg flex flex-col gap-stack-lg">
            <!-- Header Section -->
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                <div>
                    <h1 class="font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Panel de Control - Administrador</h1>
                    <p class="font-body-md text-body-md text-on-surface-variant mt-1">Gestión general de tickets e indicadores.</p>
                </div>
                <button class="bg-primary-container text-on-primary-container px-6 py-3 rounded-DEFAULT font-label-md hover:bg-primary transition-colors hover:text-on-primary shadow-sm flex items-center gap-2">
                    <span class="material-symbols-outlined icon-fill">download</span>
                    Exportar Reporte
                </button>
            </div>
            <!-- Global Metrics -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-gutter">
                <!-- Total Tickets -->
                <div class="bg-surface-container-lowest rounded-lg p-6 shadow-sm border-l-4 border-primary">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Total Tickets</p>
                            <h2 class="font-display-lg text-display-lg text-on-surface mt-2">1,245</h2>
                        </div>
                        <div class="p-3 bg-surface-container rounded-full text-primary">
                            <span class="material-symbols-outlined">receipt_long</span>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-primary-fixed-dim text-sm">
                        <span class="material-symbols-outlined text-sm mr-1">trending_up</span>
                        <span class="font-medium">+12% este mes</span>
                    </div>
                </div>
                <!-- Unassigned -->
                <div class="bg-surface-container-lowest rounded-lg p-6 shadow-sm border-l-4 border-surface-variant">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Sin Asignar</p>
                            <h2 class="font-display-lg text-display-lg text-on-surface mt-2">48</h2>
                        </div>
                        <div class="p-3 bg-surface-container rounded-full text-tertiary">
                            <span class="material-symbols-outlined">person_off</span>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-tertiary text-sm">
                        <span class="material-symbols-outlined text-sm mr-1">schedule</span>
                        <span class="font-medium">Requieren atención</span>
                    </div>
                </div>
                <!-- Critical -->
                <div class="bg-surface-container-lowest rounded-lg p-6 shadow-sm border-l-4 border-error">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Críticos</p>
                            <h2 class="font-display-lg text-display-lg text-on-surface mt-2">15</h2>
                        </div>
                        <div class="p-3 bg-error-container rounded-full text-on-error-container">
                            <span class="material-symbols-outlined">warning</span>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-error text-sm">
                        <span class="material-symbols-outlined text-sm mr-1">priority_high</span>
                        <span class="font-medium">Prioridad alta</span>
                    </div>
                </div>
                <!-- Closed Today -->
                <div class="bg-surface-container-lowest rounded-lg p-6 shadow-sm border-l-4 border-primary-fixed">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="font-label-sm text-label-sm text-on-surface-variant uppercase tracking-wider">Cerrados hoy</p>
                            <h2 class="font-display-lg text-display-lg text-on-surface mt-2">89</h2>
                        </div>
                        <div class="p-3 bg-primary-fixed rounded-full text-on-primary-fixed">
                            <span class="material-symbols-outlined">check_circle</span>
                        </div>
                    </div>
                    <div class="mt-4 flex items-center text-primary text-sm">
                        <span class="material-symbols-outlined text-sm mr-1">done_all</span>
                        <span class="font-medium">Resolución exitosa</span>
                    </div>
                </div>
            </div>
            <!-- Filters Section -->
            <div class="bg-surface-container-lowest rounded-lg shadow-sm p-6">
                <h3 class="font-title-lg text-title-lg text-on-surface mb-4">Filtros Avanzados</h3>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div class="relative">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 transform -translate-y-1/2 text-on-surface-variant">search</span>
                        <input class="w-full pl-10 pr-4 py-2 border border-outline-variant rounded-DEFAULT focus:border-primary focus:ring-1 focus:ring-primary bg-surface-bright text-on-surface font-body-md outline-none transition-colors" placeholder="Buscar ID, Asunto..." type="text"/>
                    </div>
                    <select class="w-full px-4 py-2 border border-outline-variant rounded-DEFAULT focus:border-primary focus:ring-1 focus:ring-primary bg-surface-bright text-on-surface font-body-md outline-none transition-colors appearance-none cursor-pointer">
                        <option value="">Regional / Sede</option>
                        <option value="bogota">Bogotá - Dirección General</option>
                        <option value="antioquia">Antioquia</option>
                        <option value="valle">Valle del Cauca</option>
                    </select>
                    <select class="w-full px-4 py-2 border border-outline-variant rounded-DEFAULT focus:border-primary focus:ring-1 focus:ring-primary bg-surface-bright text-on-surface font-body-md outline-none transition-colors appearance-none cursor-pointer">
                        <option value="">Agente Asignado</option>
                        <option value="unassigned">Sin Asignar</option>
                        <option value="agent1">Carlos Gómez</option>
                        <option value="agent2">María Rodríguez</option>
                    </select>
                    <select class="w-full px-4 py-2 border border-outline-variant rounded-DEFAULT focus:border-primary focus:ring-1 focus:ring-primary bg-surface-bright text-on-surface font-body-md outline-none transition-colors appearance-none cursor-pointer">
                        <option value="">Categoría</option>
                        <option value="hardware">Soporte Hardware</option>
                        <option value="software">Soporte Software</option>
                        <option value="redes">Infraestructura y Redes</option>
                    </select>
                </div>
            </div>
            <!-- Ticket List -->
            <div class="flex flex-col gap-4">
                <!-- Ticket Card 1 (Critical) -->
                <div class="bg-surface-container-lowest rounded-lg shadow-sm p-6 border-l-4 border-error flex flex-col md:flex-row justify-between items-start md:items-center gap-4 hover:shadow-md transition-shadow relative overflow-hidden">
                    <div class="absolute top-0 right-0 w-16 h-16 bg-error-container transform rotate-45 translate-x-8 -translate-y-8 z-0"></div>
                    <div class="flex-grow z-10 relative">
                        <div class="flex flex-wrap items-center gap-3 mb-2">
                            <span class="font-label-md font-bold text-on-surface">#TK-9905</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-error-container text-on-error-container">Crítico</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-surface-container text-on-surface-variant border border-outline-variant">Abierto</span>
                        </div>
                        <h4 class="font-title-lg text-title-lg text-on-surface mb-1">Caída del sistema de matrículas SOFIA Plus</h4>
                        <p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-4 flex-wrap">
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">person</span> Director Regional (Bogotá)</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">support_agent</span> Carlos Gómez</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">calendar_today</span> Hoy, 08:30 AM</span>
                        </p>
                    </div>
                    <div class="shrink-0 z-10">
                        <button class="border border-primary text-primary px-4 py-2 rounded-DEFAULT font-label-md hover:bg-surface-container transition-colors w-full md:w-auto text-center">Ver Detalle</button>
                    </div>
                </div>
                <!-- Ticket Card 2 (Unassigned) -->
                <div class="bg-surface-container-lowest rounded-lg shadow-sm p-6 border-l-4 border-surface-variant flex flex-col md:flex-row justify-between items-start md:items-center gap-4 hover:shadow-md transition-shadow">
                    <div class="flex-grow">
                        <div class="flex flex-wrap items-center gap-3 mb-2">
                            <span class="font-label-md font-bold text-on-surface">#TK-9904</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-tertiary-container text-on-tertiary-container">Media</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-surface-container text-on-surface-variant border border-outline-variant">Abierto</span>
                        </div>
                        <h4 class="font-title-lg text-title-lg text-on-surface mb-1">Solicitud de licencias Adobe Creative Cloud</h4>
                        <p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-4 flex-wrap">
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">person</span> Instructor Diseño (Antioquia)</span>
                            <span class="flex items-center gap-1 text-error"><span class="material-symbols-outlined text-sm">person_off</span> Sin Asignar</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">calendar_today</span> Hoy, 09:15 AM</span>
                        </p>
                    </div>
                    <div class="shrink-0 flex gap-2 w-full md:w-auto">
                        <button class="bg-primary-container text-on-primary-container px-4 py-2 rounded-DEFAULT font-label-md hover:bg-primary hover:text-on-primary transition-colors flex-grow text-center">Asignar</button>
                        <button class="border border-outline text-on-surface px-4 py-2 rounded-DEFAULT font-label-md hover:bg-surface-container transition-colors shrink-0"><span class="material-symbols-outlined text-sm align-middle">visibility</span></button>
                    </div>
                </div>
                <!-- Ticket Card 3 (In Progress) -->
                <div class="bg-surface-container-lowest rounded-lg shadow-sm p-6 border-l-4 border-primary flex flex-col md:flex-row justify-between items-start md:items-center gap-4 hover:shadow-md transition-shadow">
                    <div class="flex-grow">
                        <div class="flex flex-wrap items-center gap-3 mb-2">
                            <span class="font-label-md font-bold text-on-surface">#TK-9890</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-primary-container text-on-primary-container">Alta</span>
                            <span class="px-2 py-1 rounded text-xs font-semibold bg-secondary-container text-on-secondary-container">En Progreso</span>
                        </div>
                        <h4 class="font-title-lg text-title-lg text-on-surface mb-1">Fallo de red en bloque C</h4>
                        <p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-4 flex-wrap">
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">person</span> Coord. Académica (Valle)</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">support_agent</span> María Rodríguez</span>
                            <span class="flex items-center gap-1"><span class="material-symbols-outlined text-sm">calendar_today</span> Ayer, 16:45 PM</span>
                        </p>
                    </div>
                    <div class="shrink-0">
                        <button class="border border-primary text-primary px-4 py-2 rounded-DEFAULT font-label-md hover:bg-surface-container transition-colors w-full md:w-auto text-center">Ver Detalle</button>
                    </div>
                </div>
                <!-- Pagination -->
                <div class="flex justify-between items-center mt-4">
                    <span class="text-sm text-on-surface-variant">Mostrando 1-10 de 1,245</span>
                    <div class="flex gap-2">
                        <button class="p-2 border border-outline-variant rounded hover:bg-surface-container text-on-surface-variant disabled:opacity-50" disabled=""><span class="material-symbols-outlined text-sm">chevron_left</span></button>
                        <button class="w-8 h-8 flex items-center justify-center border border-primary bg-primary text-on-primary rounded font-label-md">1</button>
                        <button class="w-8 h-8 flex items-center justify-center border border-outline-variant hover:bg-surface-container text-on-surface rounded font-label-md">2</button>
                        <button class="w-8 h-8 flex items-center justify-center border border-outline-variant hover:bg-surface-container text-on-surface rounded font-label-md">3</button>
                        <button class="p-2 border border-outline-variant rounded hover:bg-surface-container text-on-surface-variant"><span class="material-symbols-outlined text-sm">chevron_right</span></button>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer -->
        <footer class="bg-surface-container-lowest dark:bg-inverse-surface text-primary dark:text-primary-fixed-dim font-label-sm text-label-sm full-width border-t border-outline-variant flat no shadows w-full py-stack-md px-margin-mobile flex flex-col md:flex-row justify-between items-center gap-stack-sm mt-auto">
            <div class="font-label-md text-label-md font-bold text-secondary">
                © 2024 Servicio Nacional de Aprendizaje SENA. Todos los derechos reservados.
            </div>
            <div class="flex gap-4">
                <a class="text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Privacidad</a>
                <a class="text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Términos de Uso</a>
                <a class="text-on-surface-variant hover:text-primary dark:hover:text-primary-fixed-dim opacity-80 hover:opacity-100 transition-opacity" href="#">Contacto</a>
            </div>
        </footer>
    </body></html>