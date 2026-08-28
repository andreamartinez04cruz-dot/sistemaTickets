package co.edu.sena.mesa.web.system;

import co.edu.sena.mesa.dto.ChatDTO;
import co.edu.sena.mesa.modelo.MensajeChat;
import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.repositorio.MensajeChatRepositoryJdbc;
import co.edu.sena.mesa.servicio.MensajeChatService;
import co.edu.sena.mesa.servicio.MensajeChatServiceImpl;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.time.LocalDateTime;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@ServerEndpoint("/chat/{idTicket}")
public class ChatWebSocket {

    private static final Set<Session> sesiones = Collections.synchronizedSet(new HashSet<>());
    private static final MensajeChatService mensajeChatService
            = new MensajeChatServiceImpl(new MensajeChatRepositoryJdbc());
    private static final Pattern ID_USUARIO
            = Pattern.compile("\\\"idUsuario\\\"\\s*:\\s*(\\d+)");
    private static final Pattern MENSAJE
            = Pattern.compile("\\\"mensaje\\\"\\s*:\\s*\\\"((?:\\\\.|[^\\\"\\\\])*)\\\"");

    @OnOpen
    public void abrirConexion(Session session, @PathParam("idTicket") int idTicket) {
        sesiones.add(session);
        System.out.println("Usuario conectado al ticket: " + idTicket);
    }

    @OnMessage
    public void recibirMensaje(String mensajeJson, Session session, @PathParam("idTicket") int idTicket) {
        System.out.println("MENSAJE RECIBIDO: " + mensajeJson);

        try {
            Matcher idMatcher = ID_USUARIO.matcher(mensajeJson);
            Matcher mensajeMatcher = MENSAJE.matcher(mensajeJson);
            if (!idMatcher.find() || !mensajeMatcher.find()) {
                System.err.println("Formato de mensaje inválido.");
                return;
            }

            ChatDTO chatDto = new ChatDTO();
            chatDto.setIdUsuario(Integer.parseInt(idMatcher.group(1)));
            chatDto.setMensaje(mensajeMatcher.group(1)
                    .replace("\\\\", "\\")
                    .replace("\\\"", "\"")
                    .replace("\\n", "\n")
                    .trim());

            MensajeChat mensaje = new MensajeChat();
            mensaje.setMensaje(chatDto.getMensaje());
            mensaje.setFechaEnvio(LocalDateTime.now());

            Ticket ticket = new Ticket();
            ticket.setId(idTicket);
            mensaje.setTicket(ticket);

            Usuario usuario = new Usuario();
            usuario.setId(chatDto.getIdUsuario());
            mensaje.setUsuario(usuario);

            if (!mensajeChatService.RegistrarYEnviarMensaje(mensaje)) {
                System.err.println("El mensaje no pudo guardarse en la base de datos.");
                return;
            }
        } catch (Exception e) {
            System.err.println("Error guardando el mensaje del chat: " + e.getMessage());
            return;
        }

        // Se retransmite únicamente después de confirmar el guardado.
        synchronized (sesiones) {
            for (Session cliente : sesiones) {
                if (cliente.isOpen()) {
                    try {
                        cliente.getBasicRemote().sendText(mensajeJson);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @OnClose
    public void cerrarConexion(Session session) {
        sesiones.remove(session);
        System.out.println("Usuario desconectado");
    }
}
