<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - Administrador</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link href="${pageContext.request.contextPath}/css/styles-global.css" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Work Sans', sans-serif;
            background-color: #f4fbf7;
            color: #073a1e;
        }
    </style>
</head>
<body class="min-h-screen flex">

    <!-- Incluir Menú Lateral -->
    <jsp:include page="Menu.jsp" />

    <!-- Contenedor Principal -->
    <div class="flex-1 flex flex-col">
            <div class="flex items-center justify-between mb-8 p-6 bg-gradient-to-r from-emerald-50 to-green-50/20 rounded-2xl border border-emerald-100/70 shadow-sm">
                <div>
                    <h1 class="text-3xl font-bold text-gray-900">Perfiles de Gestores</h1>
                    <p class="text-sm text-emerald-800 font-medium mt-1">Lista completa de administradores, agentes y personal de soporte técnico registrados en el sistema.</p>
                </div>
                <div class="flex items-center gap-3">
                    <div class="px-4 py-2 bg-emerald-100/80 text-emerald-800 rounded-xl text-sm font-semibold border border-emerald-200/80 flex items-center gap-2 shadow-sm">
                        <span class="material-symbols-outlined text-base">group</span>
                        <c:out value="${gestores != null ? gestores.size() : 0}" /> Gestores Activos
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/tickets" class="px-4 py-2 rounded-xl bg-emerald-500 text-white hover:bg-emerald-600 flex items-center gap-2 text-sm font-semibold shadow-sm transition-colors">
                        <span class="material-symbols-outlined text-base">arrow_back</span>
                        Volver al panel
                    </a>
                </div>
            </div>

            <!-- Grid de Tarjetas de Perfil (Gestores) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:choose>
                    <c:when test="${not empty gestores}">
                        <c:forEach var="gestor" items="${gestores}">
                            <div class="bg-white rounded-2xl shadow-sm border border-gray-200 hover:shadow-md hover:border-blue-300 transition-all p-6 flex flex-col justify-between">
                                <div>
                                    <!-- Avatar con iniciales y Rol -->
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="w-12 h-12 rounded-full bg-gradient-to-tr from-blue-500 to-indigo-600 text-white flex items-center justify-center font-bold text-lg shadow-sm uppercase">
                                            <c:out value="${fn:toUpperCase(fn:substring(gestor.nombre, 0, 2))}" />
                                        </div>
                                        <span class="px-3 py-1 rounded-full text-xs font-semibold 
                                            <c:choose>
                                                <c:when test="${gestor.rol == 'Administrador'}">bg-purple-100 text-purple-700</c:when>
                                                <c:when test="${fn:containsIgnoreCase(gestor.rol, 'agente')}">bg-blue-100 text-blue-700</c:when>
                                                <c:when test="${fn:containsIgnoreCase(gestor.rol, 'soporte')}">bg-emerald-100 text-emerald-700</c:when>
                                                <c:otherwise>bg-slate-100 text-slate-700</c:otherwise>
                                            </c:choose>">
                                            <c:out value="${gestor.rol}" />
                                        </span>
                                    </div>

                                    <!-- Datos Básicos -->
                                    <h3 class="text-lg font-bold text-gray-900 mb-1"><c:out value="${gestor.nombre}" /></h3>
                                    <p class="text-xs text-gray-400 font-mono">ID de Gestor: #<c:out value="${gestor.id}" /></p>
                                    
                                    <div class="mt-4 space-y-2 border-t pt-4 text-sm text-gray-600">
                                        <div class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-gray-400 text-lg">mail</span>
                                            <span class="truncate"><c:out value="${gestor.correo}" /></span>
                                        </div>
                                        <div class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-gray-400 text-lg">verified_user</span>
                                            <span>Estado: <span class="text-green-600 font-semibold">Activo</span></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-full bg-white rounded-2xl border border-dashed border-gray-300 p-8 text-center text-gray-500">
                            <span class="material-symbols-outlined text-4xl mb-2 text-gray-400">group_off</span>
                            <p class="text-lg font-medium">No se encontraron gestores en la base de datos</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </div>
    </div>

</body>
</html>
