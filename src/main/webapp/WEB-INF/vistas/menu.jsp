<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Menú principal | UltraPhone70</title>
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
        <a href="<%= ctx %>/menu" class="nav-link active">Inicio</a>
        <a href="<%= ctx %>/productos" class="nav-link">Inventario</a>
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
          <span><%= session.getAttribute("usuarioNombre") != null ? session.getAttribute("usuarioNombre") : "Usuario" %></span>
          <a href="<%= ctx %>/logout" class="btn-primary">Salir</a>
        </div>
      </header>

      <main class="content">
        <div class="page-header">
          <h1>Menú principal</h1>
          <p>Vista general del inventario de UltraPhone70</p>
        </div>

        <section class="kpi-grid">
          <div class="kpi-card">
            <span>Total de productos</span>
            <strong>${totalProductos != null ? totalProductos : 0}</strong>
            <small>Referencias registradas</small>
          </div>
          <div class="kpi-card">
            <span>Entradas</span>
            <strong>${totalEntradas != null ? totalEntradas : 0}</strong>
            <small>Movimientos de ingreso</small>
          </div>
          <div class="kpi-card">
            <span>Salidas</span>
            <strong>${totalSalidas != null ? totalSalidas : 0}</strong>
            <small>Movimientos de salida</small>
          </div>
          <div class="kpi-card alerta">
            <span>Alertas de stock bajo</span>
            <strong>${stockBajo != null ? stockBajo : 0}</strong>
            <small>Productos por debajo del mínimo</small>
          </div>
        </section>

        <section class="grid-2">
          <div class="card-panel">
            <h3>Resumen del inventario</h3>
            <div class="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Marca</th>
                    <th>Productos</th>
                    <th>Unidades</th>
                    <th>Estado</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Mantén aquí tu iteración JSTL/scriptlet desde tu DAO/Servlet sin cambiar nombres de columnas/atributos -->
                  <tr>
                    <td colspan="4">Conectado a tu Servlet/DAO actual</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <div class="card-panel">
            <h3>Stock bajo</h3>
            <p style="font-size: 13px; color: #64748B;">
              Revisa los equipos con pocas unidades disponibles en bodega.
            </p>
          </div>
        </section>
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