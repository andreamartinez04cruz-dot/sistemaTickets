<!DOCTYPE html><html lang="en"><head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SENA Help Desk - Registrar Requerimiento Administrativo</title>
        <!-- Material Symbols -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
        <!-- Google Fonts: Work Sans -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <!-- Tailwind Config -->
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "inverse-primary": "#6fdf43",
                            "primary-fixed-dim": "#6fdf43",
                            "on-tertiary-fixed-variant": "#454747",
                            "surface-tint": "#226d00",
                            "outline-variant": "#becbb3",
                            "on-secondary-fixed-variant": "#454747",
                            "on-surface": "#1a1c1c",
                            "tertiary": "#5d5f5e",
                            "on-tertiary": "#ffffff",
                            "surface-container-highest": "#e2e2e2",
                            "secondary": "#5d5f5f",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "surface-dim": "#dadada",
                            "on-error": "#ffffff",
                            "surface-bright": "#f9f9f9",
                            "primary-container": "#39a900",
                            "background": "#f9f9f9",
                            "on-tertiary-container": "#2a2c2c",
                            "surface-container-low": "#f3f3f3",
                            "tertiary-container": "#929393",
                            "surface-container": "#eeeeee",
                            "error-container": "#ffdad6",
                            "on-secondary-container": "#616363",
                            "on-primary-fixed": "#052100",
                            "inverse-surface": "#2f3131",
                            "surface-container-high": "#e8e8e8",
                            "primary": "#226d00",
                            "outline": "#6f7b66",
                            "surface-container-lowest": "#ffffff",
                            "on-primary-container": "#0c3400",
                            "on-primary": "#ffffff",
                            "on-background": "#1a1c1c",
                            "on-error-container": "#93000a",
                            "on-secondary-fixed": "#1a1c1c",
                            "error": "#ba1a1a",
                            "on-primary-fixed-variant": "#185200",
                            "primary-fixed": "#8afd5d",
                            "on-surface-variant": "#3f4a38",
                            "on-secondary": "#ffffff",
                            "surface-variant": "#e2e2e2",
                            "on-tertiary-fixed": "#1a1c1c",
                            "surface": "#f9f9f9",
                            "inverse-on-surface": "#f1f1f1",
                            "tertiary-fixed": "#e2e2e2",
                            "secondary-fixed": "#e2e2e2",
                            "secondary-container": "#dfe0e0",
                            "secondary-fixed-dim": "#c6c6c7"
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
                            "margin-desktop": "32px",
                            "gutter": "24px",
                            "stack-lg": "32px",
                            "unit": "8px",
                            "stack-md": "16px",
                            "container-max": "1280px"
                        },
                        "fontFamily": {
                            "title-lg": ["Work Sans"],
                            "headline-md": ["Work Sans"],
                            "headline-lg": ["Work Sans"],
                            "display-lg": ["Work Sans"],
                            "label-md": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "label-sm": ["Work Sans"],
                            "headline-lg-mobile": ["Work Sans"],
                            "body-lg": ["Work Sans"]
                        },
                        "fontSize": {
                            "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "500"}],
                            "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                            "headline-lg": ["32px", {"lineHeight": "40px", "fontWeight": "600"}],
                            "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                            "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}],
                            "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                            "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}],
                            "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                            "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}]
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                background-color: theme('colors.background');
                color: theme('colors.on-background');
                -webkit-font-smoothing: antialiased;
            }

            /* Custom scrollbar for textareas */
            textarea::-webkit-scrollbar {
                width: 8px;
            }
            textarea::-webkit-scrollbar-track {
                background: transparent;
            }
            textarea::-webkit-scrollbar-thumb {
                background-color: theme('colors.outline-variant');
                border-radius: 4px;
            }
        </style>
        <style>
            body {
                min-height: max(884px, 100dvh);
            }
        </style>
    </head>
    <body class="min-h-screen pt-20 pb-24 md:pb-12">
        <jsp:include page="Menu.jsp"/>
        <!-- TopAppBar -->
        <header class="fixed top-0 w-full z-50 bg-surface shadow-sm border-b border-outline-variant">
            <div class="flex justify-between items-center px-margin-mobile md:px-margin-desktop h-16 w-full max-w-container-max mx-auto">
                <!-- Leading Icon -->
                <button class="text-primary hover:bg-surface-container-high transition-colors p-2 rounded-full active:scale-95 transition-transform flex items-center justify-center">
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">menu</span>
                </button>
                <!-- Headline / Brand -->
                <h1 class="font-headline-md text-headline-md font-bold text-primary tracking-tight">SENA Help Desk</h1>
                <!-- Trailing Avatar -->
                <div class="w-8 h-8 rounded-full overflow-hidden border border-outline-variant cursor-pointer hover:opacity-80 active:scale-95 transition-all">
                    <img alt="Administrative Staff Profile" class="w-full h-full object-cover" data-alt="A professional headshot of an administrative staff member to serve as the user avatar. The subject is wearing business casual attire. The background is a clean, well-lit, neutral grey office setting. The lighting is soft and flattering, typical of a high-quality corporate profile photo. The mood is approachable and competent." src="https://lh3.googleusercontent.com/aida-public/AB6AXuD2l1dV6aAedWOzlSaThHhUv32ZPNPhkceaT1daFDQjgWQR7viixriVUfVI50OScAUzk2KaJS1zt6Zd2CJoJXyabifixejxPhp7vOj2Cv0gTUw9GEP1pLQDKeVj8bvKQeYmaPf7fovevdTOPq5bYh-4VEmcuF_Da0yqEC8uDAwfIAAIFW4j_gO1QpHjKSxZH-lrGOOaff8yN5i9aWxXnZLFZ3gz95h1SWVW4WyK516VeY2EI-FKMV_m">
                </div>
            </div>
        </header>
        <!-- Main Content Area -->
        <main class="max-w-[800px] mx-auto px-margin-mobile md:px-margin-desktop w-full">
            <!-- Page Header -->
            <div class="mb-stack-lg flex flex-col gap-stack-sm">
                <h2 class="font-headline-lg-mobile md:font-headline-lg text-headline-lg-mobile md:text-headline-lg text-on-surface">Registrar Requerimiento Administrativo</h2>
                <p class="font-body-md text-body-md text-on-surface-variant">Complete el siguiente formulario para generar un nuevo ticket de soporte o servicio.</p>
            </div>
            <!-- Form Card Container -->
            <form class="bg-surface-container-lowest rounded-xl shadow-sm border border-outline-variant p-6 md:p-8 flex flex-col gap-stack-lg relative overflow-hidden">
                <!-- Decorative Accent Line -->
                <div class="absolute left-0 top-0 bottom-0 w-1 bg-primary"></div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-gutter">
                    <!-- Título del Requerimiento -->
                    <div class="col-span-1 md:col-span-2 flex flex-col gap-stack-sm">
                        <label class="font-label-md text-label-md text-on-surface" for="titulo">Título del Requerimiento</label>
                        <input class="bg-surface border border-outline-variant rounded-md px-4 py-3 font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all placeholder:text-outline" id="titulo" placeholder="Ej. Solicitud de insumos de papelería" type="text">
                    </div>
                    <!-- Área o Departamento -->
                    <!-- Description -->
                    <div class="flex flex-col gap-stack-sm">
                        <label class="font-label-md text-label-md text-on-surface" for="ticket-description">Descripción Detallada <span class="text-error">*</span></label>
                        <textarea class="w-full px-4 py-3 rounded-lg border border-outline-variant bg-surface text-on-surface font-body-md text-body-md focus:outline-none input-focus-ring transition-all resize-y" id="ticket-description" placeholder="Describa el problema o solicitud con el mayor detalle posible..." required="" rows="5"></textarea>
                    </div>
                    <!-- Tipo de Solicitud -->
                    <div class="col-span-1 md:col-span-2 flex flex-col gap-stack-sm">
                        <label class="font-label-md text-label-md text-on-surface" for="tipo_solicitud">Tipo de Solicitud</label>
                        <div class="relative">
                            <select class="w-full bg-surface border border-outline-variant rounded-md px-4 py-3 font-body-md text-body-md text-on-surface focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20 transition-all appearance-none pr-10 cursor-pointer" id="tipo_solicitud">
                                <option disabled="" selected="" value="">Seleccione el tipo de solicitud...</option>
                                <option value="mantenimiento">Mantenimiento de Infraestructura</option>
                                <option value="suministros">Suministros y Dotación</option>
                                <option value="soporte">Soporte Técnico</option>
                                <option value="logistica">Apoyo Logístico</option>
                                <option value="otros">Otros</option>
                            </select>
                            <span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-on-surface-variant pointer-events-none">expand_more</span>
                        </div>
                    </div>
                    <!-- Descripción Detallada -->
                    <!-- Prioridad -->

                </div>
                <!-- Action Buttons -->
                <div class="flex flex-col gap-stack-sm">
                    <label class="font-label-md text-label-md text-on-surface" for="ticket-applicant">Solicitante</label>
                    <div class="flex items-center gap-3 px-4 py-3 rounded-lg border border-surface-container-high bg-surface-container-low">
                        <span class="material-symbols-outlined text-on-surface-variant">person</span>
                        <input class="w-full bg-transparent text-on-surface-variant font-body-md text-body-md focus:outline-none cursor-not-allowed" id="ticket-applicant" readonly="" type="text" value="Usuario SENA Activo">
                    </div>
                </div><div class="pt-6 border-t border-outline-variant flex flex-col md:flex-row justify-end gap-4 mt-2">
                    <button class="order-2 md:order-1 px-6 py-3 rounded-full border border-primary text-primary font-label-md text-label-md font-semibold hover:bg-surface-container-high active:scale-95 transition-all text-center" type="button">
                        Cancelar
                    </button>
                    <button class="order-1 md:order-2 px-8 py-3 rounded-full bg-primary-container text-on-primary-container font-label-md text-label-md font-bold hover:brightness-95 active:scale-95 transition-all text-center flex items-center justify-center gap-2 shadow-sm" type="submit">
                        <span class="material-symbols-outlined text-lg" style="font-variation-settings: 'FILL' 1;">check_circle</span>
                        Registrar
                    </button>
                </div>
            </form>
        </main>
        <!-- BottomNavBar (Mobile Only) -->
        <nav class="lg:hidden fixed bottom-0 left-0 w-full flex justify-around items-center px-4 pb-4 pt-2 bg-surface border-t border-outline-variant shadow-[0_-4px_12px_rgba(0,0,0,0.05)] rounded-t-xl z-50">
            <!-- Home (Inactive) -->
            <button class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-xl w-16 transition-all duration-150">
                <span class="material-symbols-outlined">home</span>
                <span class="font-label-sm text-label-sm mt-1">Home</span>
            </button>
            <!-- New (Active Match based on Intent) -->
            <button class="flex flex-col items-center justify-center bg-primary-container text-on-primary-container rounded-2xl px-4 py-1 hover:brightness-95 active:scale-90 transition-all duration-150 w-16">
                <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">add_circle</span>
                <span class="font-label-sm text-label-sm mt-1 font-semibold">New</span>
            </button>
            <!-- History (Inactive) -->
            <button class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-xl w-16 transition-all duration-150">
                <span class="material-symbols-outlined">receipt_long</span>
                <span class="font-label-sm text-label-sm mt-1">History</span>
            </button>
            <!-- Settings (Inactive) -->
            <button class="flex flex-col items-center justify-center text-on-surface-variant py-1 hover:bg-secondary-container rounded-xl w-16 transition-all duration-150">
                <span class="material-symbols-outlined">settings</span>
                <span class="font-label-sm text-label-sm mt-1">Settings</span>
            </button>
        </nav>


    </body></html>