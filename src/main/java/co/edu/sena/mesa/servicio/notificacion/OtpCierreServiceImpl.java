package co.edu.sena.mesa.servicio.notificacion;

import co.edu.sena.mesa.repositorio.AgenteTicketRepository;
import co.edu.sena.mesa.repositorio.OtpCierreRepository;
import co.edu.sena.mesa.util.RegistroErrores;

import java.security.SecureRandom;

public class OtpCierreServiceImpl implements OtpCierreService {

    private static final int MINUTOS_VIGENCIA = 10;

    private final OtpCierreRepository otpCierreRepository;
    private final AgenteTicketRepository agenteTicketRepository;
    private final Notificador notificador;
    private final SecureRandom aleatorio = new SecureRandom();

    public OtpCierreServiceImpl(
            OtpCierreRepository otpCierreRepository,
            AgenteTicketRepository agenteTicketRepository,
            Notificador notificador) {
        this.otpCierreRepository = otpCierreRepository;
        this.agenteTicketRepository = agenteTicketRepository;
        this.notificador = notificador;
    }

    @Override
    public void generarYEnviar(int idTicket) {
        try {
            String correo = agenteTicketRepository.obtenerCorreoSolicitante(idTicket);
            if (correo == null || correo.trim().isEmpty()) {
                return;
            }

            String codigo = String.format("%06d", aleatorio.nextInt(1_000_000));
            otpCierreRepository.guardar(idTicket, codigo, MINUTOS_VIGENCIA);

            String asunto = "Codigo para confirmar el cierre del ticket #" + idTicket;
            String mensaje = "Tu ticket #" + idTicket + " fue marcado como RESUELTO.\n\n"
                + "Para confirmar el cierre ingresa este codigo en la seccion Notificaciones:\n\n"
                + "    " + codigo + "\n\n"
                + "El codigo vence en " + MINUTOS_VIGENCIA + " minutos y solo puede usarse una vez.\n"
                + "Si vence, pide uno nuevo con el boton Enviar codigo.\n"
                + "Si el problema no quedo resuelto, usa la opcion Reabrir ticket.";

            notificador.enviar(correo.trim(), asunto, mensaje);
        } catch (Exception e) {
            // Nunca debe impedir que el ticket quede resuelto
            RegistroErrores.registrar("Error generando el codigo de cierre del ticket " + idTicket, e);
        }
    }

    @Override
    public boolean validar(int idTicket, String codigo) {
        return otpCierreRepository.validarYConsumir(idTicket, codigo);
    }
}
