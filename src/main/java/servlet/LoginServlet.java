package servlet;

import dao.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String correo = request.getParameter("correo");
        String clave = request.getParameter("clave");

        if (correo == null || clave == null
                || correo.isBlank() || clave.isBlank()) {

            request.setAttribute("error",
                    "Debes ingresar el correo y la contraseña.");

            request.getRequestDispatcher("/index.jsp")
                    .forward(request, response);

            return;
        }

        Usuario usuario = usuarioDAO.autenticar(correo.trim(), clave);

        if (usuario != null) {

            HttpSession sesion = request.getSession();

            sesion.setAttribute("usuario", usuario);
            sesion.setAttribute("nombre", usuario.getNombre());
            sesion.setAttribute("rol", usuario.getNombreRol());

            response.sendRedirect(
                    request.getContextPath() + "/menu");

        } else {

            request.setAttribute("error",
                    "Correo o contraseña incorrectos.");

            request.getRequestDispatcher("/index.jsp")
                    .forward(request, response);
        }
    }
}
  