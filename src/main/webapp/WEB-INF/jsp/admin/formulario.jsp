<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Administraci&oacute;n: <c:out value="${titulo}"/></title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estilocrear.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="${seccion}"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5" style="max-width: 760px;">

    <c:if test="${not empty exito}">
      <div class="alert alert-success" role="alert"><c:out value="${exito}"/></div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <a href="${ctx}${ruta}${modo == 'cambios' ? '?modo=cambios' : ''}" class="text-decoration-none small"><i class="bi bi-arrow-left"></i> Volver</a>

    <div class="mt-3 mb-4">
      <p class="text-uppercase text-muted small fw-semibold mb-1"><c:choose><c:when test="${not empty idEdicion}">Cambios</c:when><c:otherwise>Altas</c:otherwise></c:choose></p>
      <h1 class="h3 fw-bold mb-0"><c:out value="${titulo}"/></h1>
    </div>

    <section class="seccion-card">
      <div class="seccion-body">
        <form method="post" action="${ctx}${ruta}/guardar" autocomplete="off">
          <c:if test="${not empty idEdicion}"><input type="hidden" name="id" value="${idEdicion}"></c:if>
          <div class="row g-3">
            <c:forEach var="c" items="${campos}">
              <div class="${c.tipo == 'textarea' ? 'col-12' : 'col-md-6'}">
                <label for="c_${c.nombre}" class="form-label fw-semibold"><c:out value="${c.etiqueta}"/><c:if test="${c.requerido}"> <span class="text-danger">*</span></c:if></label>
                <c:choose>
                  <c:when test="${c.tipo == 'select'}">
                    <select class="form-select" id="c_${c.nombre}" name="${c.nombre}" ${c.requerido ? 'required' : ''}>
                      <c:forEach var="o" items="${c.opciones}">
                        <option value="<c:out value='${o.valor}'/>" ${o.valor == c.valor ? 'selected' : ''}><c:out value="${o.texto}"/></option>
                      </c:forEach>
                    </select>
                  </c:when>
                  <c:when test="${c.tipo == 'textarea'}">
                    <textarea class="form-control" id="c_${c.nombre}" name="${c.nombre}" rows="3" ${c.requerido ? 'required' : ''}><c:out value="${c.valor}"/></textarea>
                  </c:when>
                  <c:otherwise>
                    <input type="${c.tipo}" class="form-control" id="c_${c.nombre}" name="${c.nombre}" value="<c:out value='${c.valor}'/>"
                      ${c.requerido ? 'required' : ''} ${c.soloLectura ? 'readonly' : ''} ${c.tipo == 'password' ? 'autocomplete="new-password"' : ''}>
                    <%-- un campo de solo lectura no se envía como "disabled", pero sí como readonly --%>
                  </c:otherwise>
                </c:choose>
                <c:if test="${not empty c.ayuda}"><div class="form-text"><c:out value="${c.ayuda}"/></div></c:if>
              </div>
            </c:forEach>
          </div>
          <div class="d-flex gap-2 mt-4">
            <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty idEdicion}">Guardar cambios</c:when><c:otherwise>Dar de alta</c:otherwise></c:choose></button>
            <a href="${ctx}${ruta}${modo == 'cambios' ? '?modo=cambios' : ''}" class="btn btn-outline-secondary">Cancelar</a>
          </div>
        </form>
      </div>
    </section>

  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">Panel del moderador. Los cambios y bajas afectan directamente a los datos de la plataforma.</p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
<script>
  // La fecha de nacimiento no puede ser futura ni anterior a 1900.
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
