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

    /*
     * Guarda las sesiones de los usuarios que están conectados
     * al WebSocket.
     *
     * Se utiliza Set para evitar sesiones duplicadas.
     *
     * synchronizedSet permite trabajar de forma más segura
     * cuando varios usuarios se conectan o desconectan al mismo tiempo.
     */
    private static final Set<Session> sesiones
            = Collections.synchronizedSet(new HashSet<>());


    /*
     * Servicio encargado de registrar los mensajes del chat.
     *
     * El servicio utiliza MensajeChatRepositoryJdbc para
     * comunicarse con la base de datos.
     */
    private static final MensajeChatService mensajeChatService
            = new MensajeChatServiceImpl(
                    new MensajeChatRepositoryJdbc());


    /*
     * Patrón utilizado para encontrar el idUsuario
     * dentro del JSON recibido.
     *
     * Ejemplo:
     *
     * {"idUsuario": 4, "mensaje": "Hola"}
     *
     * Este patrón permite obtener el número 4.
     */
    private static final Pattern ID_USUARIO
            = Pattern.compile(
                    "\\\"idUsuario\\\"\\s*:\\s*(\\d+)");


    /*
     * Patrón utilizado para encontrar el contenido
     * del mensaje dentro del JSON.
     *
     * Ejemplo:
     *
     * {"idUsuario": 4, "mensaje": "Hola"}
     *
     * Permite obtener:
     *
     * Hola
     */
    private static final Pattern MENSAJE
            = Pattern.compile(
                    "\\\"mensaje\\\"\\s*:\\s*\\\"((?:\\\\.|[^\\\"\\\\])*)\\\"");


    /*
     * @OnOpen se ejecuta automáticamente cuando
     * un usuario establece una conexión con el WebSocket.
     */
    @OnOpen
    public void abrirConexion(
            Session session,
            @PathParam("idTicket") int idTicket) {

        /*
         * Se agrega la sesión del usuario a la lista
         * de usuarios conectados.
         */
        sesiones.add(session);

        /*
         * Se muestra en consola el ticket al que
         * se conectó el usuario.
         */
        System.out.println(
                "Usuario conectado al ticket: " + idTicket);
    }


    /*
     * @OnMessage se ejecuta automáticamente cada vez
     * que el servidor recibe un mensaje desde un cliente.
     *
     * mensajeJson -> contiene el mensaje enviado en formato JSON.
     * session -> representa la conexión del usuario.
     * idTicket -> identifica el ticket al que pertenece el chat.
     */
    @OnMessage
    public void recibirMensaje(
            String mensajeJson,
            Session session,
            @PathParam("idTicket") int idTicket) {

        /*
         * Muestra en consola el mensaje recibido.
         * Es útil para comprobar que el WebSocket está recibiendo
         * correctamente la información.
         */
        System.out.println(
                "MENSAJE RECIBIDO: " + mensajeJson);


        /*
         * Se utiliza try-catch para controlar posibles errores
         * durante el procesamiento y guardado del mensaje.
         */
        try {

            /*
             * Aplica el patrón ID_USUARIO sobre el JSON
             * para buscar el identificador del usuario.
             */
            Matcher idMatcher
                    = ID_USUARIO.matcher(mensajeJson);


            /*
             * Aplica el patrón MENSAJE sobre el JSON
             * para buscar el contenido del mensaje.
             */
            Matcher mensajeMatcher
                    = MENSAJE.matcher(mensajeJson);


            /*
             * Verifica que se haya encontrado tanto el usuario
             * como el contenido del mensaje.
             *
             * Si alguno no existe, significa que el formato
             * recibido no es válido.
             */
            if (!idMatcher.find()
                    || !mensajeMatcher.find()) {

                System.err.println(
                        "Formato de mensaje inválido.");

                return;
            }


            /*
             * Se crea un ChatDTO para transportar
             * temporalmente la información obtenida del JSON.
             */
            ChatDTO chatDto = new ChatDTO();


            /*
             * Obtiene el ID del usuario desde el JSON.
             *
             * group(1) contiene el valor encontrado
             * por el primer grupo de la expresión regular.
             *
             * Integer.parseInt convierte el texto a entero.
             */
            chatDto.setIdUsuario(
                    Integer.parseInt(idMatcher.group(1)));


            /*
             * Obtiene el contenido del mensaje desde el JSON.
             *
             * Después se realizan algunas conversiones para
             * interpretar correctamente caracteres especiales.
             *
             * replace("\\\\", "\\") -> corrige barras invertidas.
             *
             * replace("\\\"", "\"") -> convierte comillas escapadas
             * en comillas normales.
             *
             * replace("\\n", "\n") -> convierte el texto \n
             * en un salto de línea.
             *
             * trim() -> elimina espacios innecesarios
             * al inicio y al final.
             */
            chatDto.setMensaje(
                    mensajeMatcher.group(1)
                            .replace("\\\\", "\\")
                            .replace("\\\"", "\"")
                            .replace("\\n", "\n")
                            .trim());


            /*
             * Se crea la entidad MensajeChat.
             *
             * Esta es la entidad que posteriormente
             * se utilizará para guardar el mensaje en la BD.
             */
            MensajeChat mensaje = new MensajeChat();


            /*
             * Se establece el contenido del mensaje.
             */
            mensaje.setMensaje(
                    chatDto.getMensaje());


            /*
             * Se registra automáticamente la fecha y hora actual
             * en la que se está procesando el mensaje.
             */
            mensaje.setFechaEnvio(
                    LocalDateTime.now());


            /*
             * Se crea un objeto Ticket únicamente para establecer
             * la relación entre el mensaje y el ticket.
             */
            Ticket ticket = new Ticket();


            /*
             * Se asigna al ticket el ID obtenido desde la URL
             * del WebSocket.
             *
             * Por ejemplo:
             *
             * /chat/5
             *
             * idTicket = 5
             */
            ticket.setId(idTicket);


            /*
             * Se relaciona el ticket con el mensaje.
             */
            mensaje.setTicket(ticket);


            /*
             * Se crea un objeto Usuario para establecer
             * quién envió el mensaje.
             */
            Usuario usuario = new Usuario();


            /*
             * Se asigna el ID del usuario obtenido
             * anteriormente desde el JSON.
             */
            usuario.setId(
                    chatDto.getIdUsuario());


            /*
             * Se relaciona el usuario con el mensaje.
             */
            mensaje.setUsuario(usuario);


            /*
             * Se llama al servicio para registrar el mensaje
             * en la base de datos.
             *
             * Si devuelve false significa que el mensaje
             * no pudo guardarse.
             */
            if (!mensajeChatService.RegistrarYEnviarMensaje(mensaje)) {

                System.err.println(
                        "El mensaje no pudo guardarse en la base de datos.");

                /*
                 * Si no se pudo guardar, se detiene el método.
                 * Por lo tanto, tampoco se retransmite el mensaje.
                 */
                return;
            }

        } catch (Exception e) {

            /*
             * Si ocurre cualquier error durante el procesamiento
             * del mensaje, se muestra el error en consola.
             */
            System.err.println(
                    "Error guardando el mensaje del chat: "
                    + e.getMessage());

            /*
             * Se detiene la ejecución para evitar
             * continuar con un mensaje que pudo fallar.
             */
            return;
        }


        /*
         * El mensaje solamente se retransmite después
         * de confirmar que fue guardado correctamente
         * en la base de datos.
         */
        synchronized (sesiones) {

            /*
             * Se recorren todas las sesiones de los usuarios
             * que están conectados al WebSocket.
             */
            for (Session cliente : sesiones) {

                /*
                 * Se verifica que la conexión del cliente
                 * todavía esté abierta.
                 */
                if (cliente.isOpen()) {

                    try {

                        /*
                         * Se envía el mensaje JSON al cliente.
                         *
                         * De esta manera los usuarios conectados
                         * reciben el mensaje en tiempo real,
                         * sin necesidad de recargar la página.
                         */
                        cliente.getBasicRemote()
                                .sendText(mensajeJson);

                    } catch (IOException e) {

                        /*
                         * Si ocurre un problema al enviar el mensaje,
                         * se muestra el error.
                         */
                        e.printStackTrace();
                    }
                }
            }
        }
    }


    /*
     * @OnClose se ejecuta automáticamente cuando
     * un usuario cierra o pierde la conexión.
     */
    @OnClose
    public void cerrarConexion(Session session) {

        /*
         * Se elimina la sesión del usuario de la lista
         * de conexiones activas.
         */
        sesiones.remove(session);


        /*
         * Se informa en consola que el usuario
         * se desconectó.
         */
        System.out.println(
                "Usuario desconectado");
    }
}
