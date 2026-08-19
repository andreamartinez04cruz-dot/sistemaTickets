<!DOCTYPE html>

<html class="light" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Iniciar Sesión</title>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "secondary": "#5d5f5f",
                            "inverse-on-surface": "#f1f1f1",
                            "primary": "#226d00",
                            "primary-container": "#39a900",
                            "tertiary-fixed-dim": "#c6c6c6",
                            "on-secondary-fixed": "#1a1c1c",
                            "outline-variant": "#becbb3",
                            "primary-fixed-dim": "#6fdf43",
                            "surface-container-high": "#e8e8e8",
                            "on-primary-fixed": "#052100",
                            "on-tertiary": "#ffffff",
                            "on-background": "#1a1c1c",
                            "on-error-container": "#93000a",
                            "outline": "#6f7b66",
                            "tertiary-fixed": "#e2e2e2",
                            "secondary-fixed-dim": "#c6c6c7",
                            "on-secondary-fixed-variant": "#454747",
                            "surface-dim": "#dadada",
                            "error": "#ba1a1a",
                            "tertiary-container": "#929393",
                            "on-tertiary-container": "#2a2c2c",
                            "surface-container-low": "#f3f3f3",
                            "on-primary-container": "#0c3400",
                            "surface": "#f9f9f9",
                            "on-tertiary-fixed-variant": "#454747",
                            "tertiary": "#5d5f5e",
                            "on-secondary-container": "#616363",
                            "inverse-surface": "#2f3131",
                            "primary-fixed": "#8afd5d",
                            "surface-container-lowest": "#ffffff",
                            "surface-tint": "#226d00",
                            "error-container": "#ffdad6",
                            "on-surface": "#1a1c1c",
                            "surface-container-highest": "#e2e2e2",
                            "on-surface-variant": "#3f4a38",
                            "on-primary-fixed-variant": "#185200",
                            "on-primary": "#ffffff",
                            "on-secondary": "#ffffff",
                            "on-tertiary-fixed": "#1a1c1c",
                            "secondary-container": "#dfe0e0",
                            "background": "#f9f9f9",
                            "inverse-primary": "#6fdf43",
                            "surface-variant": "#e2e2e2",
                            "secondary-fixed": "#e2e2e2",
                            "surface-bright": "#f9f9f9",
                            "surface-container": "#eeeeee",
                            "on-error": "#ffffff"
                        },
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "stack-md": "16px",
                            "margin-desktop": "32px",
                            "stack-sm": "8px",
                            "unit": "8px",
                            "gutter": "24px",
                            "container-max": "1280px",
                            "margin-mobile": "16px",
                            "stack-lg": "32px"
                        },
                        "fontFamily": {
                            "body-lg": ["Work Sans"],
                            "headline-lg-mobile": ["Work Sans"],
                            "title-lg": ["Work Sans"],
                            "headline-lg": ["Work Sans"],
                            "body-md": ["Work Sans"],
                            "headline-md": ["Work Sans"],
                            "label-md": ["Work Sans"],
                            "display-lg": ["Work Sans"],
                            "label-sm": ["Work Sans"]
                        },
                        "fontSize": {
                            "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}],
                            "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                            "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "500"}],
                            "headline-lg": ["32px", {"lineHeight": "40px", "fontWeight": "600"}],
                            "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                            "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                            "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.01em", "fontWeight": "500"}],
                            "display-lg": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                            "label-sm": ["12px", {"lineHeight": "16px", "fontWeight": "600"}]
                        }
                    }
                }
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-surface to-primary-container/20 font-body-md text-on-surface antialiased min-h-screen flex flex-col pt-[64px]">
        <!-- Suppressed TopAppBar and Footer as this is a transactional linear flow (Login screen) -->
        <!-- Main Content Canvas -->
        <main class="flex-grow flex flex-col items-center justify-center px-margin-mobile w-full max-w-md mx-auto py-stack-lg relative z-10">
            <!-- Login Card Container -->
            <div class="bg-surface-container-lowest/80 backdrop-blur-md w-full rounded-2xl shadow-xl border border-surface-variant/50 p-stack-lg relative overflow-hidden flex flex-col gap-stack-lg">
                <!-- Branding Header -->
                <div class="flex flex-col items-center gap-stack-md text-center">
                    <img alt="SENA Logo" class="w-32 h-32 object-contain rounded-xl shadow-sm bg-white" src="https://lh3.googleusercontent.com/aida/AP1WRLsgqsUoGT-2lwimwLtDM221DxP7NWvos4EH-jZO44clebvSs4G9xkk3qy5_sx5r-gM4QaISpEHQdi6MkDmZJjlCouJfjc7cqoB6IKxC6KqhF6otdPBmlirkRXwoftCPtJGBQyj1RHApkoKcCsMv5ZBZUKFMbmvqfkr06yOy5bowvIO_D_snGIHh_9WJluN-wBVSCTX9wmiL-2HUR0a5qth3wQ7dWYpJoACf7PPvRziZydOgCWGfP1eakb0"/>
                    <div class="flex flex-col gap-1">
                        <h1 class="font-headline-lg-mobile text-[28px] leading-[36px] font-bold text-on-surface tracking-tight">
                            Bienvenido a la Mesa de Ayuda
                        </h1>
                        <p class="font-body-md text-body-md text-on-surface-variant">
                            Ingrese sus credenciales para acceder al sistema.
                        </p>
                    </div>
                </div>
                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/login"
                      method="POST"
                      class="flex flex-col gap-stack-md w-full">
                    <!-- Email / Document Input -->
                    <div class="flex flex-col gap-stack-sm">
                        <label class="font-label-md text-label-md text-on-surface font-semibold" for="username">Correo o Documento</label>
                        <div class="relative group">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors pointer-events-none" data-icon="person">person</span>
                            <input class="w-full pl-12 pr-4 py-3.5 bg-surface-container-low border border-outline-variant/60 rounded-xl font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary focus:bg-surface transition-all shadow-inner" id="username" name="username" placeholder="Ej. jperez@sena.edu.co" required="" type="text"/>
                        </div>
                    </div>
                    <!-- Password Input -->
                    <div class="flex flex-col gap-stack-sm">
                        <label class="font-label-md text-label-md text-on-surface font-semibold" for="password">Contrase�a</label>
                        <div class="relative group">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors pointer-events-none" data-icon="lock">lock</span>
                            <input class="w-full pl-12 pr-12 py-3.5 bg-surface-container-low border border-outline-variant/60 rounded-xl font-body-md text-body-md text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary focus:bg-surface transition-all shadow-inner" id="password" name="password" placeholder="????????" required="" type="password"/>
                            <button aria-label="Toggle password visibility" class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-primary transition-colors focus:outline-none" type="button">
                                <span class="material-symbols-outlined" data-icon="visibility">visibility</span>
                            </button>
                        </div>
                    </div>
                    <!-- Remember Me & Forgot Password Row -->
                    <div class="flex items-center justify-between w-full mt-2">
                        <label class="flex items-center gap-2 cursor-pointer group">
                            <div class="relative flex items-center">
                                <input class="peer sr-only" type="checkbox"/>
                                <div class="w-5 h-5 border-2 border-outline-variant rounded-md bg-surface peer-checked:bg-primary-container peer-checked:border-primary-container transition-colors flex items-center justify-center shadow-sm">
                                    <span class="material-symbols-outlined text-on-primary text-[16px] opacity-0 peer-checked:opacity-100 transition-opacity" data-icon="check" data-weight="fill" style="font-variation-settings: 'FILL' 1;">check</span>
                                </div>
                            </div>
                            <span class="font-label-md text-label-md text-on-surface-variant group-hover:text-on-surface transition-colors">Recordarme</span>
                        </label>
                        <a class="font-label-md text-label-md text-primary hover:text-primary-container underline transition-colors font-semibold" href="#">
                            �Olvid� su contrase�a?
                        </a>
                    </div>
                    <!-- Primary Action -->
                    <button class="w-full mt-stack-md py-3.5 bg-primary-container text-on-primary rounded-xl font-label-md text-[16px] font-bold shadow-md hover:shadow-lg hover:bg-primary transition-all active:scale-[0.98] flex items-center justify-center gap-2" type="submit">
                        Iniciar Sesi�n
                        <span class="material-symbols-outlined" data-icon="arrow_forward">arrow_forward</span>
                    </button>
                </form>
                <!-- Secondary Actions -->
                <div class="pt-stack-md border-t border-outline-variant/50 text-center w-full">
                    <p class="font-body-md text-body-md text-on-surface-variant">
                        �No tiene cuenta? 
                        <a class="font-label-md text-label-md text-primary font-bold hover:underline transition-all" href="#">Solicitar acceso</a>
                    </p>
                </div>
            </div>
        </main>
        <!-- Suppressed TopAppBar and Footer as this is a transactional linear flow (Login screen) -->
    </body></html>