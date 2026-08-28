package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.util.RegistroErrores;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

/**
 * Implementacion del Notificador que envia el mensaje por correo real usando
 * JavaMail (Jakarta Mail) sobre un servidor SMTP con STARTTLS.
 */
public class NotificadorCorreo implements Notificador {

    private final ConfiguracionCorreo configuracion;
    private final Session sesion;

    public NotificadorCorreo(ConfiguracionCorreo configuracion) {
        this.configuracion = configuracion;
        this.sesion = crearSesion(configuracion);
    }

    private static Session crearSesion(ConfiguracionCorreo config) {
        boolean sslDirecto = "465".equals(config.getPuerto());

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.host", config.getHost());
        propiedades.put("mail.smtp.port", config.getPuerto());
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        propiedades.put("mail.smtp.connectiontimeout", "10000");
        propiedades.put("mail.smtp.timeout", "10000");
        propiedades.put("mail.smtp.writetimeout", "10000");

        if (sslDirecto) {
            propiedades.put("mail.smtp.ssl.enable", "true");
            propiedades.put("mail.smtp.socketFactory.port", config.getPuerto());
            propiedades.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        } else {
            propiedades.put("mail.smtp.starttls.enable", "true");
            propiedades.put("mail.smtp.starttls.required", "true");
        }

        return Session.getInstance(propiedades, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(config.getUsuario(), config.getContrasena());
            }
        });
    }

    @Override
    public void enviar(String destinatario, String asunto, String mensaje) {
        if (destinatario == null || destinatario.trim().isEmpty()) {
            RegistroErrores.registrar("No se envio el correo: destinatario vacio",
                new IllegalArgumentException("destinatario nulo o vacio"));
            return;
        }
        try {
            MimeMessage correo = new MimeMessage(sesion);
            correo.setFrom(new InternetAddress(configuracion.getRemitente()));
            correo.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario.trim(), false));
            correo.setSubject(asunto, "UTF-8");
            correo.setText(mensaje, "UTF-8");
            correo.setSentDate(new java.util.Date());

            Transport.send(correo);
        } catch (Exception e) {
            // El fallo del correo no debe interrumpir la operacion sobre el ticket
            RegistroErrores.registrar("Error enviando notificacion por correo a " + destinatario, e);
        }
    }
}
