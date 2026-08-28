<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="light" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Sala de Chat en Vivo - Mesa de Ayuda SENA</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700&display=swap" rel="stylesheet"/>
        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#226d00",
                            "primary-container": "#39a900",
                            background: "#f9f9f9",
                            surface: "#f9f9f9",
                            "surface-container": "#eeeeee",
                            "surface-container-low": "#f3f3f3",
                            "surface-container-high": "#e8e8e8",
                            "on-surface": "#1a1c1c",
                            "on-surface-variant": "#3f4a38",
                            "on-primary": "#ffffff",
                            outline: "#6f7b66",
                            "outline-variant": "#becbb3",
                            tertiary: "#5d5f5e"
                        },
                        fontFamily: {
                            body: ["Work Sans"],
                            headline: ["Work Sans"]
                        }
                    }
                }
            };
        </script>
        <style>
            body {
                font-family: 'Work Sans', sans-serif;
            }
        </style>
    </head>
    <body class="bg-background text-on-surface h-screen flex flex-col overflow-hidden">
        <!-- HEADER -->
        <header class="bg-white border-b border-outline-variant px-6 py-4 flex items-center justify-between shadow-sm">
            <div class="flex items-center gap-4">
                <a href="${pageContext.request.contextPath}/tickets/comentar?id=${idTicket}" class="text-on-surface-variant hover:text-primary">
                    <span class="material-symbols-outlined">
                        arrow_back
                    </span>
                </a>
                <div>
                    <div class="flex items-center gap-2">
                        <h2 class="text-lg font-bold">
                            Chat Ticket #TK-${idTicket}
                        </h2>
                        <span class="bg-green-100 text-green-800 text-xs font-medium px-2.5 py-0.5 rounded-full border border-green-300">
                            En Línea
                        </span>
                    </div>
                </div>
            </div>
            <div>
                <span class="text-xs text-on-surface-variant">
                    Participante:
                    <strong class="text-on-surface">
                        ${sessionScope.usuario.nombre}
                    </strong>
                </span>
            </div>
        </header>

        <!-- CONTENIDO PRINCIPAL -->
        <main class="flex-grow max-w-5xl mx-auto w-full p-4 md:p-6 flex flex-col">
            <!-- MENSAJES -->
            <div id="chat-container" class="flex-grow bg-white rounded-xl p-4 md:p-6 border border-outline-variant overflow-y-auto flex flex-col gap-4 shadow-sm mb-4">
                <!-- MENSAJE INFORMATIVO -->
                <div class="text-center my-2">
                    <span class="bg-surface-container text-on-surface-variant text-xs px-3 py-1 rounded-full">
                        Sala de soporte en tiempo real iniciada.
                    </span>
                </div>

                <!-- HISTORIAL -->
                <c:choose>
                    <c:when test="${not empty historial}">
                        <c:forEach var="msg" items="${historial}">
                            <c:set var="esmio" value="${msg.idUsuario == sessionScope.usuario.id}"/>
                            <div class="flex gap-3 ${esmio ? 'flex-row-reverse' : ''}">
                                <!-- AVATAR -->
                                <div class="flex-shrink-0">
                                    <div class="w-9 h-9 rounded-full ${esmio ? 'bg-primary text-white' : 'bg-surface-container-high text-on-surface'} flex items-center justify-center font-bold text-sm">
                                        ${not empty msg.nombreUsuario ? msg.nombreUsuario.substring(0,1).toUpperCase() : 'U'}
                                    </div>
                                </div>

                                <!-- MENSAJE -->
                                <div class="max-w-[75%] md:max-w-[65%] rounded-2xl p-4 ${esmio ? 'bg-primary text-white rounded-tr-none' : 'bg-surface-container-low text-on-surface border border-outline-variant rounded-tl-none'} shadow-sm">
                                    <div class="flex items-center justify-between gap-4 mb-1">
                                        <span class="text-xs font-semibold ${esmio ? 'text-green-100' : 'text-primary'}">
                                            ${esmio ? 'Tú' : msg.nombreUsuario}
                                        </span>
                                        <span class="text-[10px] ${esmio ? 'text-green-200' : 'text-on-surface-variant'}">
                                            ${msg.fechaEnvio}
                                        </span>
                                    </div>
                                    <p class="text-sm whitespace-pre-line leading-relaxed">
                                        ${msg.mensaje}
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div id="no-messages" class="m-auto text-center py-12">
                            <span class="material-symbols-outlined text-5xl text-outline-variant mb-2">
                                chat_bubble_outline
                            </span>
                            <p class="text-on-surface-variant font-medium">
                                Aún no hay mensajes en esta sala.
                            </p>
                            <p class="text-xs text-tertiary mt-1">
                                Escribe el primer mensaje abajo para comenzar.
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- FORMULARIO -->
            <div class="bg-white rounded-xl border border-outline-variant p-3 shadow-sm">
                <form id="chat-form" class="flex items-center gap-3">
                    <!-- DATOS PARA JAVASCRIPT -->
                    <input type="hidden" id="idTicket" value="${idTicket}"/>
                    <input type="hidden" id="idUsuario" value="${sessionScope.usuario.id}"/>
                    <input type="hidden" id="nombreUsuario" value="${sessionScope.usuario.nombre}"/>

                    <!-- MENSAJE -->
                    <div class="flex-grow">
                        <textarea id="mensaje-input" rows="1" placeholder="Escribe tu mensaje aquí..." class="w-full rounded-lg border border-outline-variant bg-surface-container-low px-4 py-3 text-sm focus:border-primary focus:bg-white focus:ring-1 focus:ring-primary outline-none resize-none"></textarea>
                    </div>

                    <!-- BOTÓN -->
                    <button type="button" id="btn-enviar" class="bg-primary hover:bg-primary-container text-white p-3 rounded-lg">
                        <span class="material-symbols-outlined">
                            send
                        </span>
                    </button>
                </form>
            </div>
        </main>

        <!-- JAVASCRIPT -->
        <script>
            console.log("JAVASCRIPT DEL CHAT CARGADO");
            const contextPath = "${pageContext.request.contextPath}";
            const chatContainer = document.getElementById("chat-container");
            const chatForm = document.getElementById("chat-form");
            const mensajeInput = document.getElementById("mensaje-input");
            const btnEnviar = document.getElementById("btn-enviar");
            const ticketId = document.getElementById("idTicket").value;
            const currentUserId = parseInt(document.getElementById("idUsuario").value);

            function scrollToBottom() {
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }
            window.onload = scrollToBottom;

            const wsProtocol = window.location.protocol === "https:" ? "wss:" : "ws:";
            const wsUrl = wsProtocol + "//" + window.location.host + contextPath + "/chat/" + ticketId;
            console.log("URL WEBSOCKET:", wsUrl);
            const socket = new WebSocket(wsUrl);

            socket.onopen = function () {
                console.log("Conectado a la sala de chat en tiempo real.");
            };
            socket.onmessage = function (event) {
                console.log("MENSAJE RECIBIDO DEL WEBSOCKET:", event.data);
                const data = JSON.parse(event.data);
                agregarMensajeDinamico(data);
            };
            socket.onclose = function () {
                console.log("Conexión de chat cerrada.");
            };
            socket.onerror = function (error) {
                console.error("ERROR EN WEBSOCKET:", error);
            };

            function enviarMensaje() {
                console.log("SE PRESIONÓ ENVIAR");
                const texto = mensajeInput.value.trim();
                if (texto === "") {
                    return;
                }
                const payload = {
                    idTicket: parseInt(ticketId),
                    idUsuario: currentUserId,
                    nombreUsuario: document.getElementById("nombreUsuario").value,
                    mensaje: texto
                };
                console.log("MENSAJE:", payload);
                console.log("ESTADO WEBSOCKET:", socket.readyState);
                if (socket.readyState === WebSocket.OPEN) {
                    socket.send(JSON.stringify(payload));
                    mensajeInput.value = "";
                } else {
                    console.error("El WebSocket no está conectado.");
                    alert("La conexión con el chat se ha perdido. Recarga la página.");
                }
            }

            btnEnviar.addEventListener("click", enviarMensaje);
            chatForm.addEventListener("submit", function (e) {
                e.preventDefault();
            });
            mensajeInput.addEventListener("keydown", function (e) {
                if (e.key === "Enter" && !e.shiftKey) {
                    e.preventDefault();
                    enviarMensaje();
                }
            });

            function agregarMensajeDinamico(data) {
                const noMsg = document.getElementById("no-messages");
                if (noMsg) {
                    noMsg.remove();
                }
                let mensajeObj = data;
                if (typeof data === "string") {
                    try {
                        mensajeObj = JSON.parse(data);
                    } catch (e) {
                        mensajeObj = {mensaje: data, idUsuario: 0, nombreUsuario: "Usuario"};
                    }
                }
                const textoMensaje = mensajeObj.mensaje || "";
                const emisorId = Number(mensajeObj.idUsuario || 0);
                const esmio = emisorId === Number(currentUserId);
                const nombre = mensajeObj.nombreUsuario || "Soporte";
                const inicial = nombre.charAt(0).toUpperCase();
                const horaActual = new Date().toLocaleTimeString([], {
                    hour: "2-digit",
                    minute: "2-digit"
                });
                const div = document.createElement("div");
                div.style.display = "flex";
                div.style.gap = "12px";
                div.style.marginBottom = "12px";
                div.style.flexDirection = esmio ? "row-reverse" : "row";
                div.innerHTML = `
                    <div style="flex-shrink: 0; width: 36px; height: 36px; background-color: \${esmio ? '#226d00' : '#e0e0e0'}; color: \${esmio ? '#fff' : '#333'}; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 14px;">
                        \${inicial}
                    </div>
                    <div style="max-width: 70%; background-color: \${esmio ? '#39a900' : '#f1f1f1'}; color: \${esmio ? '#ffffff' : '#1a1c1c'}; padding: 12px 16px; border-radius: 16px; \${esmio ? 'border-top-right-radius: 0;' : 'border-top-left-radius: 0;'} box-shadow: 0 1px 2px rgba(0,0,0,0.1);">
                        <div style="display: flex; justify-content: space-between; gap: 12px; margin-bottom: 4px; font-size: 11px; opacity: 0.8;">
                            <span style="font-weight: bold;">\${esmio ? "Tú" : nombre}</span>
                            <span>\${horaActual}</span>
                        </div>
                        <div style="font-size: 14px; word-break: break-word; white-space: pre-line;" class="contenido-texto"></div>
                    </div>
                `;
                div.querySelector(".contenido-texto").textContent = textoMensaje;
                chatContainer.appendChild(div);
                scrollToBottom();
            }
        </script>
    </body>
</html>