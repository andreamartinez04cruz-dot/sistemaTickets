<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="light" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Help Desk - Historial de Tickets</title>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <!-- Material Symbols -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <!-- Tailwind Config -->
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
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
                            "secondary": "#5d5f5f",
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
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "gutter": "24px",
                            "unit": "8px",
                            "container-max": "1280px",
                            "margin-desktop": "32px",
                            "stack-sm": "8px",
                            "margin-mobile": "16px",
                            "stack-md": "16px",
                            "stack-lg": "32px"
                        },
                        "fontFamily": {
                            "body-lg": [
                                "Work Sans"
                            ],
                            "headline-lg": [
                                "Work Sans"
                            ],
                            "headline-md": [
                                "Work Sans"
                            ],
                            "display-lg": [
                                "Work Sans"
                            ],
                            "title-lg": [
                                "Work Sans"
                            ],
                            "label-sm": [
                                "Work Sans"
                            ],
                            "headline-lg-mobile": [
                                "Work Sans"
                            ],
                            "body-md": [
                                "Work Sans"
                            ],
                            "label-md": [
                                "Work Sans"
                            ]
                        },
                        "fontSize": {
                            "body-lg": [
                                "18px",
                                {
                                    "lineHeight": "28px",
                                    "fontWeight": "400"
                                }
                            ],
                            "headline-lg": [
                                "32px",
                                {
                                    "lineHeight": "40px",
                                    "fontWeight": "600"
                                }
                            ],
                            "headline-md": [
                                "24px",
                                {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                                }
                            ],
                            "display-lg": [
                                "48px",
                                {
                                    "lineHeight": "56px",
                                    "letterSpacing": "-0.02em",
                                    "fontWeight": "700"
                                }
                            ],
                            "title-lg": [
                                "20px",
                                {
                                    "lineHeight": "28px",
                                    "fontWeight": "500"
                                }
                            ],
                            "label-sm": [
                                "12px",
                                {
                                    "lineHeight": "16px",
                                    "fontWeight": "600"
                                }
                            ],
                            "headline-lg-mobile": [
                                "24px",
                                {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                                }
                            ],
                            "body-md": [
                                "16px",
                                {
                                    "lineHeight": "24px",
                                    "fontWeight": "400"
                                }
                            ],
                            "label-md": [
                                "14px",
                                {
                                    "lineHeight": "20px",
                                    "letterSpacing": "0.01em",
                                    "fontWeight": "500"
                                }
                            ]
                        }
                    },
                },
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
            body {
                background-color: #f9f9f9; /* background */
                color: #1a1c1c; /* on-background */
            }
        </style>
    </head>
    <body class="antialiased font-body-lg overflow-x-hidden min-h-screen pb-20 md:pb-0 md:pl-80 lg:pl-80">
        <!-- TopAppBar -->
        <header class="fixed top-0 w-full z-50 bg-surface border-b border-outline-variant shadow-sm h-16 md:h-16 flex justify-between items-center px-margin-mobile md:px-margin-desktop md:hidden">
            <div class="flex items-center gap-4">
                <button class="active:scale-95 transition-transform text-primary hover:bg-surface-container-high p-2 rounded-full">
                    <span class="material-symbols-outlined">menu</span>
                </button>
                <h1 class="font-headline-md text-headline-md font-bold text-primary">SENA Help Desk</h1>
            </div>
            <div>
                <div class="w-8 h-8 rounded-full bg-surface-variant flex items-center justify-center overflow-hidden">
                    <img class="w-full h-full object-cover" data-alt="A professional portrait of an administrative staff member smiling warmly in a bright, modern office setting. The lighting is soft and flattering, highlighting a clean, institutional aesthetic with subtle green accents in the background." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCEQBNSBbS-WkkRVaNWK-U_cgs6R3KUCk0onU4NNtFGgmrchWVxIY8l3-Pw6h-IUDJf48dctVqmLjWOVsmryUm-wWdkV0RCArsrfoPTwKJOXjg1tZqkHZSCVSJzmFjWEKq93BYERA5ZiHPEh2wAl4GgwKUfbD4QQkQBmNr7lA5H4_cPoMyYIywc26j9MtAl73MgOZnAkmn7EzSoCMRrdtjJhgs9v02SarEUQo7DO4WGAI0pIE2-vxiB"/>
                </div>
            </div>
        </header>
        <!-- NavigationDrawer (Desktop) -->
        <aside class="fixed left-0 top-0 h-full w-80 z-40 bg-surface-container-low border-r border-outline-variant shadow-md hidden lg:flex flex-col pt-20">
            <div class="px-6 mb-8 flex items-center gap-4">
                <div class="w-12 h-12 rounded-full bg-surface-variant flex items-center justify-center overflow-hidden shrink-0">
                    <img class="w-full h-full object-cover" data-alt="A close-up shot of a modern, stylized logo featuring geometric shapes in shades of vibrant green and stark white. The design is sleek, professional, and conveys a sense of institutional trust and efficiency, set against a pristine white background." src="https://lh3.googleusercontent.com/aida-public/AB6AXuA7VcxG-bRG-Hu6W3kgbsR0jKg3VRUJM9LQjNRTN14ll88jlyChsswZ_sR3ZI5Qu1mnRbYKYoijCVoF3jfCfqvrHrAkaJ0WjsvgUoay6ZS1i7yYEpFEV5F4JTY9HNE_R2tLiYeTEfrOwCHfWcIzdV3AOkcz5kd6zlI5krwC4JvBYHFLaxi77GyJJcBxVJSf-7RwlVb6j4g5l10c07hbJJIwB3fNN9M04ZEVuT3DDMspTL-3mjbJR8Sx"/>
                </div>
                <div>
                    <h2 class="font-title-lg text-title-lg font-bold text-primary">SENA Admin</h2>
                    <p class="font-label-md text-label-md text-on-surface-variant">Institutional Support</p>
                </div>
            </div>
            <nav class="flex-1 px-4 space-y-2">
                <a class="text-on-surface-variant hover:bg-surface-container-high rounded-full px-4 py-3 flex items-center gap-4 duration-200 ease-in-out font-label-md text-label-md" href="#">
                    <span class="material-symbols-outlined">dashboard</span>
                    Dashboard
                </a>
                <a class="text-on-surface-variant hover:bg-surface-container-high rounded-full px-4 py-3 flex items-center gap-4 duration-200 ease-in-out font-label-md text-label-md" href="#">
                    <span class="material-symbols-outlined">add_box</span>
                    New Ticket
                </a>
                <a class="bg-primary-container text-on-primary-container rounded-full px-4 py-3 flex items-center gap-4 duration-200 ease-in-out font-label-md text-label-md font-semibold" href="#">
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">history</span>
                    My Requests
                </a>
                <a class="text-on-surface-variant hover:bg-surface-container-high rounded-full px-4 py-3 flex items-center gap-4 duration-200 ease-in-out font-label-md text-label-md" href="#">
                    <span class="material-symbols-outlined">menu_book</span>
                    Knowledge Base
                </a>
            </nav>
        </aside>
        <!-- Main Content Canvas -->
        <main class="pt-20 md:pt-8 px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto w-full">
            <!-- Header Section -->
            <div class="mb-stack-lg">
                <h1 class="font-display-lg text-display-lg text-on-surface mb-stack-sm md:mt-8">Historial de Tickets</h1>
                <p class="font-body-md text-body-md text-on-surface-variant">Revisa el estado y el historial de todas tus solicitudes.</p>
            </div>
            <!-- Summary / Filters -->
            <div class="flex flex-wrap gap-4 mb-stack-lg">
                <button class="bg-surface-container-high hover:bg-surface-container-highest text-on-surface px-4 py-2 rounded-full font-label-md text-label-md flex items-center gap-2 border border-outline-variant transition-colors">
                    <span>Todos</span>
                    <span class="bg-surface-variant text-on-surface px-2 py-0.5 rounded-full text-[10px]">12</span>
                </button>
                <button class="bg-surface text-on-surface hover:bg-surface-container-high px-4 py-2 rounded-full font-label-md text-label-md flex items-center gap-2 border border-outline-variant transition-colors">
                    <div class="w-2 h-2 rounded-full bg-tertiary"></div>
                    <span>Pendiente</span>
                    <span class="bg-surface-variant text-on-surface px-2 py-0.5 rounded-full text-[10px]">3</span>
                </button>
                <button class="bg-surface text-on-surface hover:bg-surface-container-high px-4 py-2 rounded-full font-label-md text-label-md flex items-center gap-2 border border-outline-variant transition-colors">
                    <div class="w-2 h-2 rounded-full bg-yellow-500"></div>
                    <span>En Progreso</span>
                    <span class="bg-surface-variant text-on-surface px-2 py-0.5 rounded-full text-[10px]">5</span>
                </button>
                <button class="bg-surface text-on-surface hover:bg-surface-container-high px-4 py-2 rounded-full font-label-md text-label-md flex items-center gap-2 border border-outline-variant transition-colors">
                    <div class="w-2 h-2 rounded-full bg-primary-container"></div>
                    <span>Resuelto</span>
                    <span class="bg-surface-variant text-on-surface px-2 py-0.5 rounded-full text-[10px]">4</span>
                </button>
            </div>
            <!-- Ticket Cards List -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Ticket Card 1 (Resuelto) -->
                <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant relative overflow-hidden flex flex-col h-full hover:shadow-md transition-shadow">
                    <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary-container"></div>
                    <div class="flex justify-between items-start mb-4">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">#TK-1234</span>
                        <span class="px-3 py-1 rounded-full bg-primary-container/20 text-on-primary-container font-label-sm text-label-sm border border-primary-container/30">
                            Resuelto
                        </span>
                    </div>
                    <h3 class="font-title-lg text-title-lg text-on-surface mb-2 line-clamp-2">Actualización de software de diseño en Sala 3</h3>
                    <div class="flex items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-[16px] text-tertiary">computer</span>
                        <span class="font-label-md text-label-md text-tertiary">Soporte Técnico</span>
                    </div>
                    <div class="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">12 Oct 2023</span>
                        <button class="text-primary hover:text-primary-fixed-dim font-label-md text-label-md flex items-center gap-1 transition-colors">
                            Ver Detalles <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                        </button>
                    </div>
                </div>
                <!-- Ticket Card 2 (En Progreso) -->
                <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant relative overflow-hidden flex flex-col h-full hover:shadow-md transition-shadow">
                    <div class="absolute left-0 top-0 bottom-0 w-1 bg-yellow-500"></div>
                    <div class="flex justify-between items-start mb-4">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">#TK-1245</span>
                        <span class="px-3 py-1 rounded-full bg-yellow-500/20 text-yellow-800 font-label-sm text-label-sm border border-yellow-500/30">
                            En Progreso
                        </span>
                    </div>
                    <h3 class="font-title-lg text-title-lg text-on-surface mb-2 line-clamp-2">Solicitud de nuevos certificados de formación</h3>
                    <div class="flex items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-[16px] text-tertiary">description</span>
                        <span class="font-label-md text-label-md text-tertiary">Administrativo</span>
                    </div>
                    <div class="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">14 Oct 2023</span>
                        <button class="text-primary hover:text-primary-fixed-dim font-label-md text-label-md flex items-center gap-1 transition-colors">
                            Ver Detalles <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                        </button>
                    </div>
                </div>
                <!-- Ticket Card 3 (Pendiente) -->
                <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant relative overflow-hidden flex flex-col h-full hover:shadow-md transition-shadow">
                    <div class="absolute left-0 top-0 bottom-0 w-1 bg-tertiary"></div>
                    <div class="flex justify-between items-start mb-4">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">#TK-1250</span>
                        <span class="px-3 py-1 rounded-full bg-surface-variant text-on-surface-variant font-label-sm text-label-sm border border-outline-variant">
                            Pendiente
                        </span>
                    </div>
                    <h3 class="font-title-lg text-title-lg text-on-surface mb-2 line-clamp-2">Problema con el proyector del auditorio principal</h3>
                    <div class="flex items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-[16px] text-tertiary">videocam</span>
                        <span class="font-label-md text-label-md text-tertiary">Mantenimiento</span>
                    </div>
                    <div class="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">15 Oct 2023</span>
                        <button class="text-primary hover:text-primary-fixed-dim font-label-md text-label-md flex items-center gap-1 transition-colors">
                            Ver Detalles <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                        </button>
                    </div>
                </div>
                <!-- Ticket Card 4 (Resuelto) -->
                <div class="bg-surface-container-lowest rounded-xl p-6 shadow-sm border border-outline-variant relative overflow-hidden flex flex-col h-full hover:shadow-md transition-shadow">
                    <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary-container"></div>
                    <div class="flex justify-between items-start mb-4">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">#TK-1190</span>
                        <span class="px-3 py-1 rounded-full bg-primary-container/20 text-on-primary-container font-label-sm text-label-sm border border-primary-container/30">
                            Resuelto
                        </span>
                    </div>
                    <h3 class="font-title-lg text-title-lg text-on-surface mb-2 line-clamp-2">Acceso denegado a plataforma virtual de aprendizaje</h3>
                    <div class="flex items-center gap-2 mb-4">
                        <span class="material-symbols-outlined text-[16px] text-tertiary">lock</span>
                        <span class="font-label-md text-label-md text-tertiary">Soporte Técnico</span>
                    </div>
                    <div class="mt-auto pt-4 border-t border-outline-variant flex justify-between items-center">
                        <span class="font-label-sm text-label-sm text-on-surface-variant">05 Oct 2023</span>
                        <button class="text-primary hover:text-primary-fixed-dim font-label-md text-label-md flex items-center gap-1 transition-colors">
                            Ver Detalles <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                        </button>
                    </div>
                </div>
            </div>
        </main>
        <!-- BottomNavBar (Mobile) -->
        <nav class="lg:hidden fixed bottom-0 left-0 w-full flex justify-around items-center px-4 pb-2 pt-2 bg-surface shadow-lg z-50 rounded-t-xl">
            <a class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-lg w-16 transition-colors" href="#">
                <span class="material-symbols-outlined">home</span>
                <span class="font-label-sm text-label-sm mt-1">Home</span>
            </a>
            <a class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-lg w-16 transition-colors" href="#">
                <span class="material-symbols-outlined">add_circle</span>
                <span class="font-label-sm text-label-sm mt-1">New</span>
            </a>
            <a class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-2xl px-4 py-1 active:scale-90 transition-all duration-150" href="#">
                <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">receipt_long</span>
                <span class="font-label-sm text-label-sm mt-1">History</span>
            </a>
            <a class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-lg w-16 transition-colors" href="#">
                <span class="material-symbols-outlined">settings</span>
                <span class="font-label-sm text-label-sm mt-1">Settings</span>
            </a>
        </nav>
    </body></html>