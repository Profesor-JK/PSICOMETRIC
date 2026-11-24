<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear cuenta</title>
    <link rel="icon" type="image/png" href="/img/icon.png?v=2">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>
<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

<div class="card shadow p-4 w-100 ancho-login">
    <div class="card-body">
        <h3 class="card-title text-center mb-1">Crear Cuenta</h3>
        <p class="text-center mb-4"><span class="badge text-bg-primary fs-6 fw-semibold">Registro como paciente</span></p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
        </c:if>

        <form action="/registro" method="post">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" maxlength="45"
                       value="<c:out value='${form.nombre}'/>" required>
            </div>
            <div class="mb-3">
                <label for="apellidos" class="form-label">Apellidos</label>
                <input type="text" class="form-control" id="apellidos" name="apellidos" maxlength="50"
                       value="<c:out value='${form.apellidos}'/>" required>
            </div>
            <div class="mb-3">
                <label for="fechaNac" class="form-label">Fecha de nacimiento</label>
                <input type="date" class="form-control" id="fechaNac" name="fechaNac"
                       value="<c:out value='${form.fechaNac}'/>" required>
            </div>
            <div class="mb-3">
                <label for="genero" class="form-label">G&eacute;nero</label>
                <select class="form-select" id="genero" name="genero" required>
                    <option value="">Selecciona</option>
                    <option value="Masculino" ${form.genero == 'Masculino' ? 'selected' : ''}>Masculino</option>
                    <option value="Femenino" ${form.genero == 'Femenino' ? 'selected' : ''}>Femenino</option>
                    <option value="Otro" ${form.genero == 'Otro' ? 'selected' : ''}>Otro</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="correo" class="form-label">Correo electr&oacute;nico</label>
                <input type="email" class="form-control" id="correo" name="correo" maxlength="50"
                       placeholder="nombre@ejemplo.com" value="<c:out value='${form.correo}'/>" required>
            </div>
            <div class="mb-3">
                <label for="contrasena" class="form-label">Contrase&ntilde;a</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena"
                       minlength="6" maxlength="30" placeholder="De 6 a 30 caracteres" required>
            </div>
            <div class="mb-3">
                <label for="confirmar" class="form-label">Confirmar contrase&ntilde;a</label>
                <input type="password" class="form-control" id="confirmar" name="confirmar"
                       minlength="6" maxlength="30" placeholder="Confirma tu contrase&ntilde;a" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Registrarme como paciente</button>
            <p class="text-center small mt-3 mb-0">&iquest;Ya tienes cuenta? <a href="/login">Inicia sesi&oacute;n</a></p>
        </form>
    </div>
</div>


<script>
    (function () {
        var hoy = new Date();
        var iso = hoy.getFullYear() + '-' + String(hoy.getMonth() + 1).padStart(2, '0') + '-' + String(hoy.getDate()).padStart(2, '0');
        document.querySelectorAll('input[type="date"]').forEach(function (el) {
            el.max = iso;
            el.min = '1900-01-01';
        });
    })();
</script>
</body>
</html>
