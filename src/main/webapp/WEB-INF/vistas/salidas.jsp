<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Registrar salida | UltraPhone70</title>
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
                <a href="<%= ctx %>/productos" class="nav-link">Inventario</a>
                <a href="<%= ctx %>/entradas" class="nav-link">Registrar entrada</a>
                <a href="<%= ctx %>/salidas" class="nav-link active">Registrar salida</a>
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
                <div class="page-header">
                    <h1>Registro de Salidas</h1>
                    <p>Registrar mercancía que sale del inventario de UltraPhone70</p>
                </div>

                <%
                    String mensaje = (String) request.getAttribute("mensaje");
                    if (mensaje != null && !mensaje.trim().isEmpty()) {
                %>
                    <div class="card-panel">
                        <p style="font-weight:600; color:#0284C7; margin:0;"><%= mensaje %></p>
                    </div>
                <% } %>

                <div class="card-panel">
                    <h3>Formulario de salida</h3>

                    <% if (puedeGestionar) { %>
                        <form method="post" action="<%= ctx %>/salidas">
                            <div class="form-grid">
                                <div class="form-group">
                                    <label for="producto">Producto</label>
                                    <input type="text" id="producto" name="producto" class="input-control"
                                           placeholder="Ej. iPhone 15 Pro Max" required>
                                </div>

                                <div class="form-group">
                                    <label for="cantidad">Cantidad</label>
                                    <input type="number" id="cantidad" name="cantidad" min="1"
                                           class="input-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="motivo">Motivo</label>
                                    <select id="motivo" name="motivo" class="select-control" required>
                                        <option value="">Selecciona un motivo</option>
                                        <option value="Venta">Venta</option>
                                        <option value="Devolucion">Devolución</option>
                                        <option value="Despacho">Despacho</option>
                                        <option value="Ajuste">Ajuste de inventario</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="fecha">Fecha</label>
                                    <input type="date" id="fecha" name="fecha" class="input-control" required>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="submit" class="btn-primary">Guardar salida</button>
                                <a href="<%= ctx %>/menu" class="btn-secondary">Cancelar</a>
                            </div>
                        </form>
                    <% } else { %>
                        <p style="color:#64748B;">
                            Modo consulta: tu rol (<%= rol %>) no tiene permisos para registrar salidas.
                        </p>
                    <% } %>
                </div>
            </main>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById("sidebar").classList.toggle("open");
        }
    </script>

</body>
</html>