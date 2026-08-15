package co.edu.sena.mesa.web;

import co.edu.sena.mesa.modelo.Rol;
import co.edu.sena.mesa.modelo.Usuario;
import co.edu.sena.mesa.repositorio.UsuarioRepository;
import co.edu.sena.mesa.repositorio.UsuarioRepositoryJdbc;
import co.edu.sena.mesa.servicio.UsuarioService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UsuarioService usuarioService;

    @Override
    public void init() {
        UsuarioRepository usuarioRepository = new UsuarioRepositoryJdbc();
        usuarioService = new UsuarioService(usuarioRepository);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String correo = request.getParameter("username");
        String contraseña = request.getParameter("password");

        Usuario usuario = usuarioService.iniciarSesion(correo, contraseña);

        // 1. SI EL USUARIO NO EXISTE EN LA BD O EL CORREO/CONTRASEÑA ES INCORRECTO
        if (usuario == null) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<script>");
            out.println("  Swal.fire({");
            out.println("    title: '¡Error de acceso!',");
            out.println("    text: 'El correo o la contraseña son incorrectos, o el usuario no esta registrado.',");
            out.println("    icon: 'error',");
            out.println("    confirmButtonText: 'Intentar de nuevo',");
            out.println("    confirmButtonColor: '#ba1a1a'");
            out.println("  }).then(() => {");
            out.println("    window.location.href = '" + request.getContextPath() + "/iniciosesion.jsp';");
            out.println("  });");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");
            return;
        }

        // 2. SI LAS CREDENCIALES SON CORRECTAS
        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuario);

        List<Rol> roles = usuario.getRoles();
        String redirectUrl = request.getContextPath() + "/sin-acceso.jsp";
        String rolUsuario = "SIN_ROL";

        if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("ADMIN"))) {
            rolUsuario = "ADMIN";
            redirectUrl = request.getContextPath() + "/AdminTickets.jsp";
        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("AGENTE"))) {
            rolUsuario = "AGENTE";
            redirectUrl = request.getContextPath() + "/AgenteTickets.jsp";
        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("APRENDIZ"))) {
            rolUsuario = "APRENDIZ";
            redirectUrl = request.getContextPath() + "/RegistroTicket.jsp";
        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("FUNCIONARIO"))) {
            rolUsuario = "FUNCIONARIO";
            redirectUrl = request.getContextPath() + "/tickets/registrar";
        }

        session.setAttribute("rolUsuario", rolUsuario);

        String nombreMostrar = (usuario.getNombre() != null) ? usuario.getNombre() : "Usuario";

        // Muestra la alerta de Bienvenida y luego redirecciona a la página según el rol
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head>");
        out.println("<body>");
        out.println("<script>");
        out.println("  Swal.fire({");
        out.println("    title: '¡Bienvenido(a), " + nombreMostrar + "!',");
        out.println("    text: 'Sesión iniciada correctamente.',");
        out.println("    icon: 'success',");
        out.println("    timer: 2000,");
        out.println("    showConfirmButton: false,");
        out.println("    timerProgressBar: true");
        out.println("  }).then(() => {");
        out.println("    window.location.href = '" + redirectUrl + "';");
        out.println("  });");
        out.println("</script>");
        out.println("</body>");
        out.println("</html>");
    }

}
