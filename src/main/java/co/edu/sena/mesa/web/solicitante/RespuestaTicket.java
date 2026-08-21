package co.edu.sena.mesa.web.solicitante;

import co.edu.sena.mesa.dto.TicketDTO;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public final class RespuestaTicket {

    private RespuestaTicket() {
    }

    public static void escribirRegistroExitoso(
            HttpServletResponse response,
            TicketDTO ticket,
            String urlRedireccion) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html><head><meta charset='UTF-8'>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script></head><body>");
        out.println("<script>");
        out.println("Swal.fire({ icon: 'success', title: '¡Ticket registrado!', "
                + "text: 'Se ha asignado prioridad: " + ticket.getPrioridadNombre() + "', "
                + "confirmButtonText: 'Aceptar' }).then(() => { "
                + "window.location.href = '" + urlRedireccion + "'; });");
        out.println("</script></body></html>");
    }
}
