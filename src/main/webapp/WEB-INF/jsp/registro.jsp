<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear cuenta</title>
    <link rel="icon" type="image/png" href="/img/icon.png?v=2">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>
</head>
<body class="bg-light d-flex align-items-center justify-content-center min-vh-100 py-4">

    <div class="card shadow p-4" style="width: 100%; max-width: 440px;">
        <div class="card-body">
            <h3 class="card-title text-center mb-4">Crear Cuenta</h3>

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

                <button type="submit" class="btn btn-primary w-100">Crear cuenta</button>
                <p class="text-center small mt-3 mb-0">&iquest;Ya tienes cuenta? <a href="/login">Inicia sesi&oacute;n</a></p>
            </form>
        </div>
    </div>

</body>
</html>
