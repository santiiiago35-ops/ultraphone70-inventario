package servlet;

import dao.ProductoDAO;
import modelo.Producto;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();

    private Usuario obtenerUsuarioAutenticado(HttpServletRequest request,
                                             HttpServletResponse response)
            throws IOException {

        HttpSession sesion = request.getSession(false);

        if (sesion == null || sesion.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return null;
        }

        return (Usuario) sesion.getAttribute("usuario");
    }

    private boolean puedeConsultar(String rol) {
        return "Administrador".equals(rol)
                || "Empleado".equals(rol)
                || "Consulta".equals(rol);
    }

    private boolean puedeGestionar(String rol) {
        return "Administrador".equals(rol) || "Empleado".equals(rol);
    }

    // CONSULTAR INVENTARIO - METODO GET
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = obtenerUsuarioAutenticado(request, response);
        if (usuario == null) {
            return;
        }

        String rol = usuario.getNombreRol();

        if (!puedeConsultar(rol)) {
            response.sendRedirect(request.getContextPath() + "/menu");
            return;
        }

        List<Producto> productos = productoDAO.listarProductos();

        request.setAttribute("usuarioActual", usuario);
        request.setAttribute("rolUsuario", rol);
        request.setAttribute("puedeGestionar", puedeGestionar(rol));
        request.setAttribute("productos", productos);
        request.setAttribute("mensaje", "Inventario de celulares de UltraPhone70");

        request.getRequestDispatcher("/WEB-INF/vistas/inventario.jsp")
                .forward(request, response);
    }

    // PROCESAR FORMULARIOS - METODO POST
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Usuario usuario = obtenerUsuarioAutenticado(request, response);
        if (usuario == null) {
            return;
        }

        String rol = usuario.getNombreRol();
        String accion = request.getParameter("accion");

        if ("consultar".equals(accion)) {
            if (!puedeConsultar(rol)) {
                response.sendRedirect(request.getContextPath() + "/menu");
                return;
            }
            response.sendRedirect(request.getContextPath() + "/productos");
            return;
        }

        if (!puedeGestionar(rol)) {
            request.setAttribute("mensaje",
                    "Tu rol (" + rol + ") solo permite consultar el inventario.");
            doGet(request, response);
            return;
        }

        request.setAttribute("mensaje",
                "La acción solicitada aún no está disponible.");
        doGet(request, response);
    }
}