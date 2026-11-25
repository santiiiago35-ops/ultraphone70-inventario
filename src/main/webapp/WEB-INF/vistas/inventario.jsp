<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>
<%@ page import="modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String rol = usuario.getNombreRol();
    boolean esAdmin = "Administrador".equals(rol);
    boolean esEmpleado = "Empleado".equals(rol);
    boolean puedeGestionar = esAdmin || esEmpleado;
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario | UltraPhone70</title>
    <link rel="stylesheet" href="<%= ctx %>/css/estilos.css">
</head>
<body>

    <div class="app">
        <aside class="sidebar" id="sidebar">
            <div class="brand">
                <h2>UltraPhone70</h2>
                <span>Control de Inventarios</span>
            </div>
            <nav class="nav-menu">
                <a href="<%= ctx %>/menu" class="nav-link">Inicio</a>
                <a href="<%= ctx %>/productos" class="nav-link active">Inventario</a>
                <a href="<%= ctx %>/entradas" class="nav-link">Registrar entrada</a>
                <a href="<%= ctx %>/salidas" class="nav-link">Registrar salida</a>
                <a href="<%= ctx %>/kardex" class="nav-link">Kardex</a>
                <a href="<%= ctx %>/reportes" class="nav-link">Reportes</a>
                <a href="<%= ctx %>/usuarios" class="nav-link">Gestión de usuarios</a>
                <a href="<%= ctx %>/perfil" class="nav-link">Perfil</a>
                <a href="<%= ctx %>/configuracion" class="nav-link">Configuración</a>
                <a href="<%= ctx %>/notificaciones" class="nav-link">Notificaciones</a>
            </nav>
        </aside>

        <div class="main-area">
            <header class="topbar">
                <button type="button" class="menu-toggle" onclick="toggleSidebar()">Menú</button>
                <span class="topbar-title">Sistema de control de inventarios</span>
                <div class="topbar-right">
                    <span><strong><%= usuario.getNombre() %></strong> (<%= rol %>)</span>
                    <a href="<%= ctx %>/menu" class="btn-secondary">Menú principal</a>
                    <a href="<%= ctx %>/logout" class="btn-primary">Salir</a>
                </div>
            </header>

            <main class="content">
                <div class="toolbar">
                    <div class="page-header" style="margin-bottom:0;">
                        <h1>Inventario de celulares</h1>
                        <p>Módulo de control de inventario — UltraPhone70</p>
                    </div>
                    <form action="<%= ctx %>/productos" method="get" style="margin:0;">
                        <button type="submit" class="btn-primary">Consultar inventario</button>
                    </form>
                </div>

                <div class="card-panel">
                    <p style="margin-bottom:8px;">
                        Usuario: <strong><%= usuario.getNombre() %></strong> | Rol: <strong><%= rol %></strong>
                    </p>

                    <% if (puedeGestionar) { %>
                        <p style="font-size:13px; color:#64748B;">
                            Permisos activos para gestión de inventario (<%= rol %>).
                        </p>
                    <% } else { %>
                        <p style="font-size:13px; color:#64748B;">
                            Modo consulta: solo visualización de inventario.
                        </p>
                    <% } %>

                    <%
                        String mensaje = (String) request.getAttribute("mensaje");
                        if (mensaje != null && !mensaje.trim().isEmpty()) {
                    %>
                        <p style="margin-top:10px; font-weight:600; color:#0284C7;"><%= mensaje %></p>
                    <% } %>
                </div>

                <%
                    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
                    if (productos != null) {
                %>
                    <div class="card-panel">
                        <h3>Celulares registrados (<%= productos.size() %>)</h3>

                        <% if (productos.isEmpty()) { %>
                            <p style="color:#64748B;">No hay celulares registrados en el inventario.</p>
                        <% } else { %>
                            <div class="filters-row">
                                <input type="text" id="filtroInventario" class="input-control"
                                       style="flex:1; min-width:220px;"
                                       placeholder="Filtrar en tabla por marca, modelo o IMEI..."
                                       onkeyup="filtrarTabla()">
                            </div>

                            <div class="table-wrap">
                                <table id="tablaProductos">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Marca</th>
                                            <th>Modelo</th>
                                            <th>IMEI</th>
                                            <th>Precio compra</th>
                                            <th>Precio venta</th>
                                            <th>Stock</th>
                                            <th>Proveedor</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Producto producto : productos) { %>
                                            <tr>
                                                <td><%= producto.getIdCelular() %></td>
                                                <td><%= producto.getMarca() %></td>
                                                <td><%= producto.getModelo() %></td>
                                                <td><%= producto.getImei() %></td>
                                                <td>$<%= producto.getPrecioCompra() %></td>
                                                <td>$<%= producto.getPrecioVenta() %></td>
                                                <td><strong><%= producto.getStock() %></strong></td>
                                                <td><%= producto.getIdProveedor() %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </main>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById("sidebar").classList.toggle("open");
        }

        function filtrarTabla() {
            const texto = document.getElementById("filtroInventario").value.toLowerCase();
            const filas = document.querySelectorAll("#tablaProductos tbody tr");
            filas.forEach(fila => {
                const contenido = fila.textContent.toLowerCase();
                fila.style.display = contenido.includes(texto) ? "" : "none";
            });
        }
    </script>

</body>
</html>