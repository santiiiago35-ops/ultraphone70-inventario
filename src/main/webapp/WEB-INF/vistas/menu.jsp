<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Usuario" %>

<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String rol = usuario.getNombreRol();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú principal | UltraPhone70</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <header class="encabezado">
        <h1>UltraPhone70</h1>
        <p>Sistema de control de inventario</p>
    </header>

    <main class="contenedor">
        <section class="bienvenida">

            <h2>¡Bienvenido, <%= usuario.getNombre() %>!</h2>

            <p>Rol: <strong><%= rol %></strong></p>

            <h3>Menú principal</h3>

            <% if ("Administrador".equals(rol)) { %>

                <p><a href="${pageContext.request.contextPath}/productos">
                    Gestión de inventario</a></p>

                <p>Gestión de proveedores</p>
                <p>Gestión de usuarios</p>
                <p>Movimientos de inventario</p>

            <% } else if ("Empleado".equals(rol)) { %>

                <p><a href="${pageContext.request.contextPath}/productos">
                    Consultar inventario</a></p>

                <p>Registrar entradas y salidas</p>

            <% } else if ("Consulta".equals(rol)) { %>

                <p><a href="${pageContext.request.contextPath}/productos">
                    Consultar inventario</a></p>

            <% } %>

            <br>

            <form action="${pageContext.request.contextPath}/logout"
                  method="post">

                <button type="submit" class="login-boton">
                    Cerrar sesión
                </button>

            </form>

        </section>
    </main>

    <footer>
        <p>UltraPhone70 © 2026</p>
    </footer>

</body>
</html>
