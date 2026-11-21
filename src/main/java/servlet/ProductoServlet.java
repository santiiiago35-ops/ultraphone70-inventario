package servlet;

import dao.ProductoDAO;
import modelo.Producto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();

    // CONSULTAR INVENTARIO - METODO GET
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Producto> productos = productoDAO.listarProductos();

        request.setAttribute("productos", productos);
        request.setAttribute("mensaje",
                "Inventario de celulares de UltraPhone70");

        request.getRequestDispatcher(
                "/WEB-INF/vistas/inventario.jsp"
        ).forward(request, response);
    }

    // PROCESAR FORMULARIOS - METODO POST
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        if ("consultar".equals(accion)) {

            response.sendRedirect(
                    request.getContextPath() + "/productos");

        } else {

            request.setAttribute("mensaje",
                    "La acción solicitada no está disponible.");

            doGet(request, response);
        }
    }
}
