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

        String correo = request.getParameter("username");
        String contraseña = request.getParameter("password");

        Usuario usuario = usuarioService.iniciarSesion(correo, contraseña);

        if (usuario == null) {
            request.setAttribute("error", "Correo o contraseña incorrectos");
            request.getRequestDispatcher("/iniciosesion.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();

        // 1. Guardamos el objeto usuario completo en la sesión
        session.setAttribute("usuario", usuario);

        List<Rol> roles = usuario.getRoles();

        // 2. Evaluamos el rol, lo guardamos en la sesión ("rolUsuario") y redireccionamos
        if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("ADMIN"))) {

            session.setAttribute("rolUsuario", "ADMIN");
            response.sendRedirect(request.getContextPath() + "/AdminTickets.jsp");

        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("AGENTE"))) {

            session.setAttribute("rolUsuario", "AGENTE");
            response.sendRedirect(request.getContextPath() + "/AgenteTickets.jsp");

        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("APRENDIZ"))) {

            session.setAttribute("rolUsuario", "APRENDIZ");
            response.sendRedirect(request.getContextPath() + "/RegistroTicket.jsp");

        } else if (roles.stream().anyMatch(rol -> rol.getTiporol().equalsIgnoreCase("FUNCIONARIO"))) {

            session.setAttribute("rolUsuario", "FUNCIONARIO");
            response.sendRedirect(request.getContextPath() + "/RegistroTicket.jsp");

        } else {

            session.setAttribute("rolUsuario", "SIN_ROL");
            response.sendRedirect(request.getContextPath() + "/sin-acceso.jsp");
        }
    }
}
