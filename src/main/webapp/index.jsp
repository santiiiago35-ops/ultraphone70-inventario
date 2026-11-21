<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UltraPhone70 - Inicio de sesión</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #eef2ff;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #1f2937;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }

        .login-card {
            background-color: white;
            padding: 38px 24px 24px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .login-card h1 {
            font-size: 24px;
            margin-bottom: 6px;
            color: #111827;
        }

        .subtitle {
            font-size: 13px;
            color: #91a1c2;
            margin-bottom: 24px;
        }

        .alert-error {
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            color: #b91c1c;
            font-size: 12px;
            padding: 10px 12px;
            border-radius: 9px;
            margin-bottom: 16px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: bold;
            color: #50617d;
            margin-bottom: 6px;
        }

        .input-container {
            display: flex;
            align-items: center;
            border: 1px solid #dbe3f0;
            border-radius: 9px;
            height: 42px;
            padding: 0 12px;
            background-color: white;
        }

        .input-container span {
            margin-right: 9px;
            color: #8ca0bf;
        }

        .input-container input {
            border: none;
            outline: none;
            width: 100%;
            font-size: 13px;
            color: #374151;
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 4px 0 18px;
            font-size: 11px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #8291aa;
        }

        .remember input {
            accent-color: #20409a;
        }

        .forgot-password {
            color: #20409a;
            text-decoration: none;
            font-weight: bold;
        }

        .login-button {
            width: 100%;
            height: 42px;
            border: none;
            border-radius: 9px;
            background-color: #24429a;
            color: white;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-button:hover {
            background-color: #19357f;
        }

        .footer {
            text-align: center;
            margin-top: 18px;
            font-size: 10px;
            color: #9aa8c0;
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 15px;
            }

            .login-card {
                padding: 30px 20px 22px;
            }

            .login-card h1 {
                font-size: 22px;
            }
        }
    </style>
</head>

<body>

    <div class="login-container">

        <div class="login-card">

            <h1>Bienvenido</h1>

            <p class="subtitle">
                Ingresa tus credenciales para continuar
            </p>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert-error">
                    <%= error %>
                </div>
            <%
                }
            %>

            <form action="LoginServlet" method="post">

                <!-- CORREO ELECTRÓNICO -->
                <div class="form-group">
                    <label for="correo">
                        CORREO ELECTRÓNICO
                    </label>
                    <div class="input-container">
                        <span>✉</span>
                        <input
                            type="email"
                            id="correo"
                            name="correo"
                            placeholder="usuario@ultraphone70.com"
                            value="<%= request.getParameter("correo") != null ? request.getParameter("correo") : "" %>"
                            required
                        >
                    </div>
                </div>

                <!-- CONTRASEÑA -->
                <div class="form-group">
                    <label for="password">
                        CONTRASEÑA
                    </label>
                    <div class="input-container">
                        <span>🔒</span>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="••••••••"
                            required
                        >
                    </div>
                </div>

                <!-- RECORDAR Y RECUPERAR CONTRASEÑA -->
                <div class="options">
                    <label class="remember">
                        <input type="checkbox" name="recordarme" value="true">
                        Recordarme
                    </label>

                    <a href="LoginServlet" class="forgot-password">
                        ¿Olvidaste tu contraseña?
                    </a>
                </div>

                <!-- BOTÓN SUBMIT -->
                <button type="submit" class="login-button">
                    Iniciar sesión
                </button>

            </form>

        </div>

        <div class="footer">
            © 2026 UltraPhone70 — Todos los derechos reservados
        </div>

    </div>

</body>

</html>
```[cite: 5]

---

### 3. Código base de `LoginServlet.java` (con `doGet` y `doPost`)

Este ejemplo valida contra la tabla `usuario` de tu base `inventario_celulares` (fíjate en el uso de `` `contraseña` `` entre comillas invertidas porque así viene en tu SQL[cite: 6]):

```java
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/inventario_celulares?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = ""; // Cambia por tu clave de MySQL

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        if (correo == null || correo.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Debes ingresar tu correo y contraseña.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        String sql = "SELECT u.id_usuario, u.nombre, u.correo, r.nombre_rol " +
                     "FROM usuario u " +
                     "INNER JOIN rol r ON u.id_rol = r.id_rol " +
                     "WHERE u.correo = ? AND u.`contraseña` = ? AND u.estado = TRUE";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, correo.trim());
                ps.setString(2, password);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession sesion = request.getSession();
                        sesion.setAttribute("idUsuario", rs.getInt("id_usuario"));
                        sesion.setAttribute("nombreUsuario", rs.getString("nombre"));
                        sesion.setAttribute("correoUsuario", rs.getString("correo"));
                        sesion.setAttribute("rolUsuario", rs.getString("nombre_rol"));

                        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                    } else {
                        request.setAttribute("error", "Correo o contraseña incorrectos, o usuario inactivo.");
                        request.getRequestDispatcher("/index.jsp").forward(request, response);
                    }
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al conectar con la base de datos: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
```[cite: 6]

*(Nota: si tu proyecto usa `javax.servlet.*` en lugar de `jakarta.servlet.*` según la versión de Tomcat que tengas configurada en tu IDE, solo cambia los imports de `jakarta.servlet.*` a `javax.servlet.*`).*

---

¿Quieres que continuemos ahora con el **`dashboard.jsp`** para mostrar los datos reales del usuario en sesión o con el flujo de **Entradas/Salidas** usando `GET` para consultar/filtrar y `POST` para registrar un nuevo movimiento[cite: 1, 3, 4, 10]?