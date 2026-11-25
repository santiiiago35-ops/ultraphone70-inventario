<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String rol = usuario.getNombreRol();
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kardex | UltraPhone70</title>
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
                <a href="<%= ctx %>/salidas" class="nav-link">Registrar salida</a>
                <a href="<%= ctx %>/kardex" class="nav-link active">Kardex</a>
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
                    <h1>Kardex - Historial de Movimientos</h1>
                    <p>Consulta el historial de entradas, salidas y saldo de productos</p>
                </div>

                <section class="kpi-grid">
                    <div class="kpi-card">
                        <span>Entradas</span>
                        <strong>${totalEntradasKardex != null ? totalEntradasKardex : 0}</strong>
                        <small>Unidades ingresadas</small>
                    </div>
                    <div class="kpi-card">
                        <span>Salidas</span>
                        <strong>${totalSalidasKardex != null ? totalSalidasKardex : 0}</strong>
                        <small>Unidades retiradas</small>
                    </div>
                    <div class="kpi-card">
                        <span>Saldo actual</span>
                        <strong>${saldoKardex != null ? saldoKardex : 0}</strong>
                        <small>Unidades disponibles</small>
                    </div>
                    <div class="kpi-card">
                        <span>Registros</span>
                        <strong>${totalRegistrosKardex != null ? totalRegistrosKardex : 0}</strong>
                        <small>Movimientos en consulta</small>
                    </div>
                </section>

                <div class="card-panel">
                    <h3>Consulta de Kardex</h3>
                    <form method="get" action="<%= ctx %>/kardex" class="filters-row">
                        <input type="text" name="producto" class="input-control" style="flex:1; min-width:200px;"
                               placeholder="Producto o referencia..." value="${param.producto}">
                        <input type="date" name="desde" class="input-control" value="${param.desde}">
                        <input type="date" name="hasta" class="input-control" value="${param.hasta}">
                        <button type="submit" class="btn-primary">Consultar</button>
                    </form>

                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Tipo</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Stock anterior</th>
                                    <th>Stock actual</th>
                                    <th>Referencia</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- podemos conectar aquí tu lista de movimientos desde el Servlet/DAO -->
                                <tr>
                                    <td colspan="7">aqui queda Listo para conectar con el historial de movimientos desde la base de datos</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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