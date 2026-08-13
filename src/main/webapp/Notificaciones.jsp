<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Notificaciones - Panel de Aprendiz</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#226d00",
                            "primary-green": "#28a745",
                            "light-bg": "#f8f9fa",
                            "border-color": "#e2e8f0"
                        }
                    }
                }
            }
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body class="bg-[#f8f9fa] text-gray-900 min-h-screen flex flex-col">

        <!-- Header Fijo (Panel de Aprendiz) -->
        <header class="fixed top-0 left-0 w-full bg-white border-b border-gray-200 h-16 px-6 md:px-12 flex items-center justify-between z-40 shadow-sm">
            <h1 class="text-[#2e7d32] font-bold text-lg md:text-xl">
                Panel de Aprendiz
            </h1>

            <div class="flex items-center gap-4">
                <button class="p-2 text-gray-700 hover:bg-gray-100 rounded-full transition-colors">
                    <span class="material-symbols-outlined text-2xl">notifications</span>
                </button>
                <div class="w-9 h-9 rounded-full bg-[#1b5e20] text-white font-bold flex items-center justify-center text-sm shadow-sm cursor-pointer">
                    AP
                </div>
            </div>
        </header>

        <!-- Contenedor Principal Flex (Menú + Contenido) -->
        <div class="flex flex-1 pt-16">

            <!-- Menú Lateral -->
            <aside class="w-64 shrink-0 hidden md:block">
                <jsp:include page="Menu.jsp"/>
            </aside>

            <!-- Main Content Area -->
            <main class="flex-1 w-full p-8 md:p-12 pb-20">

                <!-- Header Section -->
                <div class="mb-6">
                    <h1 class="text-3xl md:text-4xl font-extrabold text-gray-900 mb-2 tracking-tight">Notificaciones</h1>
                    <p class="text-sm md:text-base text-gray-600">Mantente al día con los cambios de estado de tus solicitudes.</p>
                </div>

                <!-- Filter / Action Button -->
                <div class="mb-8">
                    <button class="bg-[#f0fdf4] hover:bg-[#dcfce7] text-[#16a34a] border border-[#bbf7d0] px-4 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-colors shadow-sm">
                        <span class="material-symbols-outlined text-[18px]">done_all</span>
                        <span>Marcar todas como leídas</span>
                    </button>
                </div>

                <!-- Notification Grid (2 Columnas) -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-5 max-w-5xl">

                    <!-- Card 1: Ticket Resuelto -->
                    <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-200/80 flex gap-4 items-start relative hover:shadow-md transition-all">
                        <div class="w-10 h-10 rounded-full bg-[#f0fdf4] border border-[#dcfce7] flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-[#16a34a] text-xl">check_circle</span>
                        </div>

                        <div class="flex-1 pr-4">
                            <h3 class="text-base font-bold text-gray-900 mb-1">Ticket Resuelto</h3>
                            <p class="text-xs text-gray-600 leading-relaxed mb-4">
                                Tu solicitud <span class="font-medium text-gray-800">#TK-1234</span> ha sido marcada como resuelta por el soporte.
                            </p>
                            <span class="text-[11px] font-semibold text-gray-400">Hace 10 min</span>
                        </div>

                        <!-- Punto Verde de No Leído -->
                        <span class="w-2.5 h-2.5 rounded-full bg-[#22c55e] absolute top-5 right-5"></span>
                    </div>

                    <!-- Card 2: Ticket Asignado -->
                    <div class="bg-white rounded-2xl p-5 shadow-sm border border-gray-200/80 flex gap-4 items-start relative hover:shadow-md transition-all">
                        <div class="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-gray-600 text-xl">assignment_ind</span>
                        </div>

                        <div class="flex-1">
                            <h3 class="text-base font-bold text-gray-900 mb-1">Ticket Asignado</h3>
                            <p class="text-xs text-gray-600 leading-relaxed mb-4">
                                Tu requerimiento <span class="font-medium text-gray-800">#TK-1250</span> ha sido asignado a Soporte Técnico.
                            </p>
                            <span class="text-[11px] font-semibold text-gray-400">Ayer</span>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <!-- BottomNavBar (Mobile) -->
        <nav class="md:hidden fixed bottom-0 left-0 w-full flex justify-around items-center px-4 py-2 bg-white border-t border-gray-200 z-50">
            <a class="flex flex-col items-center justify-center text-gray-600 py-1 hover:text-green-700 w-16" href="#">
                <span class="material-symbols-outlined">home</span>
                <span class="text-[10px] mt-0.5">Inicio</span>
            </a>
            <a class="flex flex-col items-center justify-center text-gray-600 py-1 hover:text-green-700 w-16" href="#">
                <span class="material-symbols-outlined">add_circle</span>
                <span class="text-[10px] mt-0.5">Nuevo</span>
            </a>
            <a class="flex flex-col items-center justify-center text-green-700 font-semibold py-1 w-16" href="#">
                <span class="material-symbols-outlined">notifications</span>
                <span class="text-[10px] mt-0.5">Notificaciones</span>
            </a>
            <a class="flex flex-col items-center justify-center text-gray-600 py-1 hover:text-green-700 w-16" href="#">
                <span class="material-symbols-outlined">settings</span>
                <span class="text-[10px] mt-0.5">Ajustes</span>
            </a>
        </nav>

    </body>
</html>