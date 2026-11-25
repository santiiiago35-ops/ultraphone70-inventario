package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.Usuario;

@WebServlet("/salidas")
public class SalidaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/vistas/salidas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String producto = request.getParameter("producto");
        String cantidadStr = request.getParameter("cantidad");
        String motivo = request.getParameter("motivo");
        String fecha = request.getParameter("fecha");

        String prodSeguro = (producto != null && !producto.trim().isEmpty()) ? producto.trim() : "Producto";
        String cantSegura = (cantidadStr != null && !cantidadStr.trim().isEmpty()) ? cantidadStr.trim() : "0";
        String motivoSeguro = (motivo != null && !motivo.trim().isEmpty()) ? motivo.trim() : "Sin motivo";
        String fechaSegura = (fecha != null && !fecha.trim().isEmpty()) ? fecha.trim() : "Sin fecha";

        // Aquí se puede meter el  DAO/JDBC para descontar stock y registrar la salida
        request.setAttribute(
            "mensaje",
            "Salida registrada: -" + cantSegura + " ud(s) de " + prodSeguro + " (" + motivoSeguro + ") - Fecha: " + fechaSegura
        );

        request.getRequestDispatcher("/WEB-INF/vistas/salidas.jsp").forward(request, response);
    }
}