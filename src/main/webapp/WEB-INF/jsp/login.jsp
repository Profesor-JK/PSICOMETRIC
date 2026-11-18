<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión | Psicometric</title>

    <!-- Bootstrap 5 y Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8fafc;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            width: 100%;
            max-width: 420px;
        }

        .login-header {
            background-color: #212529; /* Color oscuro igual al navbar */
            color: white;
            padding: 2rem 2rem 1.5rem;
            text-align: center;
        }

        .login-body {
            background-color: white;
            padding: 2rem;
        }

        .form-control {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
        }

        .btn-primary {
            border-radius: 0.5rem;
            padding: 0.75rem;
            font-weight: 600;
            background-color: #0d6efd;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

    <div class="card login-card">
        <!-- Encabezado -->
        <div class="login-header">
            <i class="bi bi-brain fs-1 mb-2 d-block"></i>
            <h4 class="fw-bold mb-1">Psicometric</h4>
            <p class="text-white-50 small mb-0">Ingresa a tu cuenta</p>
        </div>

        <!-- Cuerpo del Formulario -->
        <div class="login-body">

            <!-- Mensaje de Error (Si las credenciales fallan) -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div><%= request.getAttribute("error") %></div>
                </div>
            <% } %>

            <!-- Mensaje de Éxito (Si acaba de registrarse) -->
            <% if (request.getAttribute("exito") != null) { %>
                <div class="alert alert-success d-flex align-items-center" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <div><%= request.getAttribute("exito") %></div>
                </div>
            <% } %>
            <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">Correo o contraseña incorrectos</div>
            <% } %>

            <form action="/login" method="POST">

                <!-- Campo Correo (Spring Security lo leerá como "username") -->
                <div class="mb-3">
                    <label for="username" class="form-label">Correo Electrónico</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                        <!-- OJO: el name debe ser "username" -->
                        <input type="email" class="form-control border-start-0" id="username" name="username" placeholder="tu@correo.com" required>
                    </div>
                </div>

                <!-- Campo Contraseña (Spring Security lo leerá como "password") -->
                <div class="mb-4">
                    <label for="password" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock"></i></span>
                        <!-- OJO: el name debe ser "password" -->
                        <input type="password" class="form-control border-start-0" id="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-3">Iniciar Sesión</button>
            </form>

            <!-- Enlace a Registro -->
            <div class="text-center mt-3">
                <span class="text-muted small">¿No tienes cuenta? </span>
                <a href="/registro" class="text-decoration-none fw-semibold small">Regístrate aquí</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>