<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Producto" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventario | UltraPhone70</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

    <header class="encabezado">
        <h1>UltraPhone70</h1>
        <p>Módulo de control de inventario</p>
    </header>

    <main class="contenedor">

        <section class="bienvenida">

            <h2>Inventario de celulares</h2>

            <p>${mensaje}</p>

            <form action="${pageContext.request.contextPath}/productos" method="get">
                <button type="submit" class="boton">
                    Consultar inventario
                </button>
            </form>

            <br>

            <%
                List<Producto> productos =
                    (List<Producto>) request.getAttribute("productos");

                if (productos != null) {
            %>

                <h3>Celulares registrados</h3>

                <% if (productos.isEmpty()) { %>

                    <p>No hay celulares registrados en el inventario.</p>

                <% } else { %>

                    <div style="overflow-x:auto;">

                        <table border="1" cellpadding="8" cellspacing="0"
                               style="width:100%; border-collapse:collapse;">

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
                                        <td><%= producto.getStock() %></td>
                                        <td><%= producto.getIdProveedor() %></td>
                                    </tr>

                                <% } %>

                            </tbody>

                        </table>

                    </div>

                <% } %>

            <% } %>

            <br>

            <a href="${pageContext.request.contextPath}/menu">
                Volver al menú principal
            </a>

        </section>

    </main>

    <footer>
        <p>UltraPhone70 - Sistema de Inventario</p>
    </footer>

</body>
</html>
