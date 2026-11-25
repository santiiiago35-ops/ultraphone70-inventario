package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.Usuario;

@WebServlet("/entradas")
public class EntradaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/vistas/entradas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String proveedor = request.getParameter("proveedor");
        String producto = request.getParameter("producto");
        String cantidad = request.getParameter("cantidad");
        String fecha = request.getParameter("fecha");

        // Aquí se puede meter el  DAO/JDBC para guardar la entrada y actualizar stock en BD
        request.setAttribute(
            "mensaje",
            "Entrada recibida: " + cantidad + " ud(s) de " + producto + " (" + proveedor + ") - Fecha: " + fecha
        );

        request.getRequestDispatcher("/WEB-INF/vistas/entradas.jsp").forward(request, response);
    }
}