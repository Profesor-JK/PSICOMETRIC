<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Ver tests</title>
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
  <jsp:param name="activo" value="tutorTests"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5" style="max-width: 900px;">

    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Tests del paciente</h1>
      <p class="text-muted mb-0">Tests disponibles para los pacientes que tienes a tu cargo.</p>
    </div>

    <c:choose>
      <c:when test="${empty tests}">
        <section class="seccion-card">
          <div class="seccion-body">
            <div class="estado-vacio">
              <i class="bi bi-journal-text"></i>
              <p class="mb-0">No hay tests disponibles para tus pacientes.</p>
            </div>
          </div>
        </section>
      </c:when>
      <c:otherwise>
        <c:forEach var="t" items="${tests}">
          <div class="resultado-card nivel-primary">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
              <div>
                <h2 class="h6 fw-bold mb-1"><c:out value="${t.nombre}"/></h2>
                <div class="small text-muted">
                  <i class="bi bi-person"></i> <c:out value="${t.nombrePaciente}"/>
                  <c:if test="${not empty t.categoria}"> &middot; <c:out value="${t.categoria}"/></c:if>
                  <c:if test="${not empty t.duracionMin}"> &middot; <i class="bi bi-clock"></i> ${t.duracionMin} min</c:if>
                </div>
              </div>
              <div class="text-end">
                <c:if test="${t.exclusivo}"><span class="badge text-bg-warning">Exclusivo del paciente</span></c:if>
                <div class="small text-muted mt-1">
                  <c:choose>
                    <c:when test="${t.vecesRealizado == 0}">A&uacute;n no lo realiza</c:when>
                    <c:otherwise>Realizado ${t.vecesRealizado} ${t.vecesRealizado == 1 ? 'vez' : 'veces'}</c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>

  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">
      Esta informaci&oacute;n es confidencial y solo es visible para el tutor del paciente.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
</body>
</html>
