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

                <form action="login" method="post">

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
                        <label for="clave">
                          CONTRASEÑA
                         </label>
                        <div class="input-container">
                            <span>🔒</span>
                            <input
                                type="password"
                                id="clave"
                                name="clave"
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

                       <a href="login" class="forgot-password">
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
  