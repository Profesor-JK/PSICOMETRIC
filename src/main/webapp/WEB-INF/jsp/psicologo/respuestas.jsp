<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Respuestas de pacientes</title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="respuestas"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5">

    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Respuestas de pacientes</h1>
      <p class="text-muted mb-0">Consulta c&oacute;mo contestaron tus pacientes los tests que has creado.</p>
    </div>

    <section class="seccion-card">
      <div class="seccion-header flex-wrap">
        <div class="seccion-icono bg-primary-subtle text-primary"><i class="bi bi-clipboard2-data"></i></div>
        <div class="flex-grow-1">
          <h2 class="h6 fw-bold mb-0">Tests realizados</h2>
          <small class="text-muted"><span id="contador">${fn:length(intentos)}</span> resultado(s)</small>
        </div>

        <form method="get" action="${ctx}/psicologo/respuestas" class="d-flex gap-2 flex-wrap">
          <select name="idTest" class="form-select form-select-sm filtro" onchange="this.form.submit()">
            <option value="">Todos mis tests</option>
            <c:forEach var="t" items="${tests}">
              <option value="${t.idTest}" ${t.idTest == idTestSeleccionado ? 'selected' : ''}>
                <c:out value="${t.nombre}"/>
              </option>
            </c:forEach>
          </select>
          <input type="search" id="buscador" class="form-control form-control-sm filtro"
                 placeholder="Buscar paciente...">
        </form>
      </div>

      <div class="seccion-body p-0">
        <c:choose>
          <c:when test="${empty intentos}">
            <div class="estado-vacio py-5">
              <i class="bi bi-inbox"></i>
              <p class="mb-0">Todav&iacute;a no hay pacientes que hayan resuelto tus tests.</p>
            </div>
          </c:when>
          <c:otherwise>
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0" id="tablaIntentos">
                <thead class="table-light">
                  <tr>
                    <th>Paciente</th>
                    <th>Test</th>
                    <th>Fecha</th>
                    <th class="text-center">Puntaje</th>
                    <th>Interpretaci&oacute;n</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="i" items="${intentos}">
                    <tr data-paciente="<c:out value='${fn:toLowerCase(i.nombrePaciente)}'/>">
                      <td class="fw-semibold"><c:out value="${i.nombrePaciente}"/></td>
                      <td>
                        <c:out value="${i.nombreTest}"/>
                        <c:if test="${not empty i.categoriaTest}">
                          <div class="small text-muted"><c:out value="${i.categoriaTest}"/></div>
                        </c:if>
                      </td>
                      <td class="text-nowrap"><c:out value="${i.fechaTexto}"/></td>
                      <td class="text-center text-nowrap">
                        <fmt:formatNumber value="${i.puntaje}" maxFractionDigits="2"/>
                        <span class="text-muted small">/ <fmt:formatNumber value="${i.puntajeMax}" maxFractionDigits="2"/></span>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${not empty i.tituloRango}">
                            <span class="badge text-bg-${i.nivelRango}"><c:out value="${i.tituloRango}"/></span>
                          </c:when>
                          <c:otherwise><span class="text-muted small">Sin interpretaci&oacute;n</span></c:otherwise>
                        </c:choose>
                      </td>
                      <td class="text-end">
                        <a href="${ctx}/psicologo/respuestas/${i.idIntento}" class="btn btn-sm btn-primary">
                          Ver respuestas
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </section>
  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">
      Esta informaci&oacute;n es confidencial. La interpretaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
<script>
  (function () {
    var buscador = document.getElementById('buscador');
    var filas = document.querySelectorAll('#tablaIntentos tbody tr');
    var contador = document.getElementById('contador');
    if (!buscador) return;
    buscador.addEventListener('input', function () {
      var q = buscador.value.trim().toLowerCase();
      var visibles = 0;
      filas.forEach(function (f) {
        var ok = f.getAttribute('data-paciente').indexOf(q) !== -1;
        f.style.display = ok ? '' : 'none';
        if (ok) visibles++;
      });
      contador.textContent = visibles;
    });
    buscador.form.addEventListener('submit', function (e) { if (document.activeElement === buscador) e.preventDefault(); });
  })();
</script>
</body>
</html>
