package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.util.RegistroErrores;

import java.io.InputStream;
import java.util.Properties;

/**
 * Datos de conexion SMTP. Se leen de variables de entorno, propiedades del
 * sistema o del archivo correo.properties, para no dejar el usuario ni la
 * contrasena escritos en el codigo fuente.
 */
public class ConfiguracionCorreo {

    private static final Properties ARCHIVO = cargarArchivo();

    private final String host;
    private final String puerto;
    private final String usuario;
    private final String contrasena;
    private final String remitente;

    public ConfiguracionCorreo(String host, String puerto, String usuario, String contrasena, String remitente) {
        this.host = host;
        this.puerto = puerto;
        this.usuario = usuario;
        this.contrasena = contrasena;
        this.remitente = remitente;
    }

    public static ConfiguracionCorreo desdeVariablesDeEntorno() {
        String host = valor("MAIL_SMTP_HOST", "smtp.gmail.com");
        String puerto = valor("MAIL_SMTP_PORT", "587");
        String usuario = valor("MAIL_USERNAME", null);
        String contrasena = sinEspacios(valor("MAIL_PASSWORD", null));
        String remitente = valor("MAIL_FROM", usuario);
        return new ConfiguracionCorreo(host, puerto, usuario, contrasena, remitente);
    }

    /** Google muestra la contrasena de aplicacion en bloques separados por espacios. */
    private static String sinEspacios(String texto) {
        return texto == null ? null : texto.replaceAll("\\s", "");
    }

    private static String valor(String clave, String porDefecto) {
        String v = System.getenv(clave);
        if (v == null || v.trim().isEmpty()) {
            v = System.getProperty(clave);
        }
        if (v == null || v.trim().isEmpty()) {
            v = ARCHIVO.getProperty(clave);
        }
        if (v == null || v.trim().isEmpty()) {
            return porDefecto;
        }
        return v.trim();
    }

    private static Properties cargarArchivo() {
        Properties propiedades = new Properties();
        try (InputStream entrada = ConfiguracionCorreo.class.getClassLoader()
                .getResourceAsStream("correo.properties")) {
            if (entrada != null) {
                propiedades.load(entrada);
            }
        } catch (Exception e) {
            RegistroErrores.registrar("No se pudo leer correo.properties", e);
        }
        return propiedades;
    }

    public boolean estaCompleta() {
        return noVacio(host) && noVacio(puerto) && noVacio(usuario)
            && noVacio(contrasena) && noVacio(remitente);
    }

    private static boolean noVacio(String texto) {
        return texto != null && !texto.trim().isEmpty();
    }

    public String getHost() {
        return host;
    }

    public String getPuerto() {
        return puerto;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public String getRemitente() {
        return remitente;
    }
}
