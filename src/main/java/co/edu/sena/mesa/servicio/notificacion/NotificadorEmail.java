package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.util.RegistroErrores;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

// Implementación real del Notificador usando JavaMail (SMTP)
public class NotificadorEmail implements Notificador {

    // TODO: reemplazar por las credenciales reales del correo remitente
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String CORREO_REMITENTE = "dorisita201911b@gmail.com";
    private static final String CLAVE_APLICACION = "vprkdvlruhdorqge";

    @Override
    public void enviar(String destinatario, String asunto, String mensaje) {
        if (destinatario == null || destinatario.isBlank()) {
            return;
        }

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.starttls.enable", "true");
        propiedades.put("mail.smtp.host", SMTP_HOST);
        propiedades.put("mail.smtp.port", SMTP_PORT);

        Session sesion = Session.getInstance(propiedades, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(CORREO_REMITENTE, CLAVE_APLICACION);
            }
        });

        try {
            Message mensajeCorreo = new MimeMessage(sesion);
            mensajeCorreo.setFrom(new InternetAddress(CORREO_REMITENTE));
            mensajeCorreo.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensajeCorreo.setSubject(asunto);
            mensajeCorreo.setText(mensaje);

            Transport.send(mensajeCorreo);
            System.out.println("[Notificador Email] Correo enviado a " + destinatario);
        } catch (MessagingException e) {
            RegistroErrores.registrar("Error enviando correo de notificación a " + destinatario, e);
        }
    }
}
