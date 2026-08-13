<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>SENA Mesa de Ayuda - Administrador</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    </head>

    <!-- flex para que el sidebar y el contenido queden lado a lado -->
    <body class="bg-background text-on-background min-h-screen flex">

        <!-- 1. Único llamado al sidebar/menú -->
        <jsp:include page="Menu.jsp"/> 

        <!-- 2. Contenedor principal que ocupa el resto del ancho -->
        <div class="flex-grow flex flex-col min-w-0">

            <!-- Header superior -->
            <header class="w-full flex justify-between items-center px-6 h-16 bg-surface shadow-sm border-b border-outline-variant sticky top-0 z-10">
                <h1 class="text-xl font-bold text-primary">SENA Mesa de Ayuda</h1>
                <div class="flex items-center gap-3">
                    <button class="p-2 rounded-full hover:bg-surface-container-high">
                        <span class="material-symbols-outlined">notifications</span>
                    </button>
                    <div class="w-8 h-8 rounded-full bg-primary text-white flex items-center justify-center font-bold text-sm">
                        AD
                    </div>
                </div>
            </header>

            <!-- Contenido del Dashboard -->
            <main class="flex-grow p-6 w-full max-w-7xl mx-auto">
                <div class="flex justify-between items-center mb-6">
                    <div>
                        <h2 class="text-2xl font-bold">Panel de Control - Administrador</h2>
                        <p class="text-sm text-gray-600">Vista general de tickets e indicadores.</p>
                    </div>
                    <button class="bg-primary text-white px-4 py-2 rounded-lg font-medium flex items-center gap-2 hover:bg-green-700">
                        <span class="material-symbols-outlined text-sm">download</span>
                        Exportar Reporte
                    </button>
                </div>

                <!-- Tarjetas de Estadísticas -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <!-- Total Tickets -->
                    <div class="bg-white p-4 rounded-xl border border-gray-200 flex justify-between items-center">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Total Tickets</span>
                            <p class="text-3xl font-bold mt-1">15</p>
                            <span class="text-xs text-green-600 mt-2 block">Este mes</span>
                        </div>
                        <div class="p-3 bg-green-50 rounded-lg text-primary">
                            <span class="material-symbols-outlined">assignment</span>
                        </div>
                    </div>

                    <!-- Sin Asignar -->
                    <div class="bg-white p-4 rounded-xl border border-gray-200 flex justify-between items-center">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Sin Asignar</span>
                            <p class="text-3xl font-bold mt-1">48</p>
                            <span class="text-xs text-gray-500 mt-2 block">Requieren atención</span>
                        </div>
                        <div class="p-3 bg-gray-100 rounded-lg text-gray-600">
                            <span class="material-symbols-outlined">person_off</span>
                        </div>
                    </div>

                    <!-- Críticos -->
                    <div class="bg-white p-4 rounded-xl border-l-4 border-red-600 border-y border-r border-gray-200 flex justify-between items-center">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Críticos</span>
                            <p class="text-3xl font-bold mt-1">15</p>
                            <span class="text-xs text-red-600 font-medium mt-2 block">! Prioridad alta</span>
                        </div>
                        <div class="p-3 bg-red-50 rounded-lg text-red-600">
                            <span class="material-symbols-outlined">warning</span>
                        </div>
                    </div>

                    <!-- Cerrados Hoy -->
                    <div class="bg-white p-4 rounded-xl border-l-4 border-green-500 border-y border-r border-gray-200 flex justify-between items-center">
                        <div>
                            <span class="text-xs font-semibold text-gray-500 uppercase">Cerrados Hoy</span>
                            <p class="text-3xl font-bold mt-1">89</p>
                            <span class="text-xs text-green-600 font-medium mt-2 block">✓ Resolución exitosa</span>
                        </div>
                        <div class="p-3 bg-green-50 rounded-lg text-green-500">
                            <span class="material-symbols-outlined">check_circle</span>
                        </div>
                    </div>
                </div>

                <!-- Sección Filtros / Tabla -->
                <div class="bg-white rounded-xl p-4 border border-gray-200">
                    <h3 class="font-bold text-lg mb-4">Filtros Avanzados</h3>
                    <!-- Tu tabla o filtros van aquí -->
                </div>
            </main>
        </div>

    </body>
</html>