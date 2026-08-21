package co.edu.sena.mesa.config;

import java.util.logging.Level;
import java.util.logging.Logger;

public final class RegistroErrores {

    private static final Logger LOGGER = Logger.getLogger(RegistroErrores.class.getName());

    private RegistroErrores() {
    }

    public static void registrar(String contexto, Exception exception) {
        LOGGER.log(Level.SEVERE, contexto, exception);
    }
}
