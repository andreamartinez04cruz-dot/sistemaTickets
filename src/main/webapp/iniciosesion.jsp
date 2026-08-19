<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="light" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Iniciar Sesión</title>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            secondary: "#5d5f5f",
                            primary: "#226d00",
                            "primary-container": "#39a900",
                            outline: "#6f7b66",
                            "outline-variant": "#becbb3",
                            surface: "#f9f9f9",
                            "on-surface": "#1a1c1c",
                            "on-surface-variant": "#3f4a38",
                            "surface-container-lowest": "#ffffff",
                            "surface-container-low": "#f3f3f3",
                            "surface-variant": "#e2e2e2"
                        },
                        fontFamily: {
                            body: ["Work Sans", "sans-serif"],
                            headline: ["Work Sans", "sans-serif"]
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
    <body class="bg-gradient-to-br from-surface to-primary-container/10 font-body text-on-surface antialiased min-h-screen flex flex-col justify-center items-center p-4">

        <!-- Main Content Canvas -->
        <main class="w-full max-w-md mx-auto relative z-10">

            <!-- Login Card Container -->
            <div class="bg-surface-container-lowest/90 backdrop-blur-md w-full rounded-2xl shadow-xl border border-surface-variant/50 p-8 relative overflow-hidden flex flex-col gap-6">

                <!-- Branding Header con Imagen Mejorada -->
                <div class="flex flex-col items-center gap-4 text-center">
                    <div class="p-3 bg-white rounded-2xl shadow-md border border-slate-100 flex items-center justify-center">
                        <img alt="SENA Logo" class="w-20 h-20 object-contain" src="https://lh3.googleusercontent.com/aida/AP1WRLsgqsUoGT-2lwimwLtDM221DxP7NWvos4EH-jZO44clebvSs4G9xkk3qy5_sx5r-gM4QaISpEHQdi6MkDmZJjlCouJfjc7cqoB6IKxC6KqhF6otdPBmlirkRXwoftCPtJGBQyj1RHApkoKcCsMv5ZBZUKFMbmvqfkr06yOy5bowvIO_D_snGIHh_9WJluN-wBVSCTX9wmiL-2HUR0a5qth3wQ7dWYpJoACf7PPvRziZydOgCWGfP1eakb0"/>
                    </div>
                    <div class="flex flex-col gap-1">
                        <h1 class="text-2xl font-bold text-on-surface tracking-tight">
                            Mesa de Ayuda SENA
                        </h1>
                        <p class="text-sm text-on-surface-variant">
                            Ingrese sus credenciales para acceder al sistema.
                        </p>
                    </div>
                </div>

                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/login" method="POST" class="flex flex-col gap-4 w-full">

                    <!-- Email / Document Input -->
                    <div class="flex flex-col gap-1.5">
                        <label class="text-xs font-semibold text-on-surface uppercase tracking-wider" for="username">Correo o Documento</label>
                        <div class="relative group">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors pointer-events-none">person</span>
                            <input class="w-full pl-12 pr-4 py-3.5 bg-surface-container-low border border-outline-variant/60 rounded-xl text-sm text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary focus:bg-surface transition-all shadow-inner" id="username" name="username" placeholder="Ej. usuario@sena.edu.co" required type="text"/>
                        </div>
                    </div>

                    <!-- Password Input -->
                    <div class="flex flex-col gap-1.5">
                        <label class="text-xs font-semibold text-on-surface uppercase tracking-wider" for="password">Contraseña</label>
                        <div class="relative group">
                            <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-primary transition-colors pointer-events-none">lock</span>
                            <input class="w-full pl-12 pr-12 py-3.5 bg-surface-container-low border border-outline-variant/60 rounded-xl text-sm text-on-surface focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary focus:bg-surface transition-all shadow-inner" id="password" name="password" placeholder="••••••••" required type="password"/>
                            <button aria-label="Toggle password visibility" class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-primary transition-colors focus:outline-none" type="button" onclick="togglePassword()">
                                <span class="material-symbols-outlined" id="eye-icon">visibility</span>
                            </button>
                        </div>
                    </div>

                    <!-- Remember Me & Forgot Password Row -->
                    <div class="flex items-center justify-between w-full pt-1">
                        <label class="flex items-center gap-2 cursor-pointer group">
                            <input class="w-4 h-4 text-primary border-outline-variant rounded focus:ring-primary" type="checkbox" name="remember"/>
                            <span class="text-xs font-medium text-on-surface-variant group-hover:text-on-surface transition-colors">Recordarme</span>
                        </label>
                        <a class="text-xs text-primary hover:underline transition-colors font-semibold" href="#">
                            ¿Olvidó su contraseña?
                        </a>
                    </div>

                    <!-- Primary Action -->
                    <button class="w-full mt-2 py-3.5 bg-primary-container text-white rounded-xl text-sm font-bold shadow-md hover:shadow-lg hover:bg-primary transition-all active:scale-[0.98] flex items-center justify-center gap-2" type="submit">
                        <span>Iniciar Sesión</span>
                        <span class="material-symbols-outlined text-sm">arrow_forward</span>
                    </button>
                </form>

                <!-- Secondary Actions -->
                <div class="pt-4 border-t border-outline-variant/30 text-center w-full">
                    <p class="text-sm text-on-surface-variant">
                        ¿No tiene cuenta? 
                        <a class="text-xs text-primary font-bold hover:underline transition-all ml-1" href="#">Solicitar acceso</a>
                    </p>
                </div>
            </div>
        </main>

        <!-- Script para mostrar/ocultar contraseña -->
        <script>
            function togglePassword() {
                const passwordInput = document.getElementById('password');
                const eyeIcon = document.getElementById('eye-icon');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.textContent = 'visibility_off';
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.textContent = 'visibility';
                }
            }
        </script>
    </body>
</html>