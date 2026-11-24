<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="r" value="${detalle.resumen}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Actividad de <c:out value="${r.nombrePaciente}"/></title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="tutorActividad"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5 ancho-medio">

    <a href="${ctx}/tutor/actividad" class="text-decoration-none small">
      <i class="bi bi-arrow-left"></i> Volver a la actividad
    </a>

    <div class="mt-3 mb-4">
      <p class="text-uppercase text-muted small fw-semibold mb-1">Respuestas del paciente</p>
      <h1 class="h3 fw-bold mb-1"><c:out value="${r.nombrePaciente}"/></h1>
      <p class="text-muted mb-0">
        <c:out value="${r.nombreTest}"/> &middot; <c:out value="${r.fechaTexto}"/>
      </p>
    </div>

    <section class="seccion-card mb-4">
      <div class="seccion-body">
        <div class="row g-3 align-items-center">
          <div class="col-md-4 text-center">
            <div class="text-muted small">Puntaje</div>
            <div class="display-5 fw-bold"><fmt:formatNumber value="${r.puntaje}" maxFractionDigits="2"/></div>
            <div class="text-muted small">
              de <fmt:formatNumber value="${r.puntajeMin}" maxFractionDigits="2"/>
              a <fmt:formatNumber value="${r.puntajeMax}" maxFractionDigits="2"/>
            </div>
          </div>
          <div class="col-md-8">
            <c:choose>
              <c:when test="${not empty r.tituloRango}">
                <div class="alert alert-${r.nivelRango} mb-0" role="alert">
                  <h2 class="h6 fw-bold"><c:out value="${r.tituloRango}"/></h2>
                  <p class="mb-0 texto-pre"><c:out value="${detalle.descripcionRango}"/></p>
                </div>
              </c:when>
              <c:otherwise>
                <div class="alert alert-secondary mb-0" role="alert">
                  Este test no tiene una interpretaci&oacute;n para este puntaje.
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </section>

    <h2 class="h5 fw-bold mb-3">Respuestas por pregunta</h2>

    <c:forEach var="p" items="${detalle.respuestas}">
      <div class="pregunta-card">
        <div class="d-flex gap-3">
          <span class="pregunta-num">${p.orden}</span>
          <div class="flex-grow-1">
            <div class="d-flex justify-content-between flex-wrap gap-2">
              <p class="fw-semibold mb-2"><c:out value="${p.textoPregunta}"/></p>
              <div class="d-flex gap-2 align-items-start">
                <span class="badge text-bg-light border">
                  <c:choose>
                    <c:when test="${p.tipo == 'unica'}">Opci&oacute;n &uacute;nica</c:when>
                    <c:when test="${p.tipo == 'multiple'}">Opci&oacute;n m&uacute;ltiple</c:when>
                    <c:when test="${p.tipo == 'escala'}">Escala</c:when>
                    <c:otherwise>Abierta</c:otherwise>
                  </c:choose>
                </span>
                <c:if test="${p.respondida && p.tipo != 'abierta'}">
                  <span class="badge text-bg-primary"><fmt:formatNumber value="${p.puntos}" maxFractionDigits="2"/> pts</span>
                </c:if>
              </div>
            </div>

            <c:choose>
              <c:when test="${not p.respondida}">
                <p class="text-muted fst-italic mb-0">Sin respuesta</p>
              </c:when>
              <c:when test="${p.tipo == 'abierta'}">
                <div class="bg-light rounded p-2 texto-pre"><c:out value="${p.respuestas[0]}"/></div>
              </c:when>
              <c:otherwise>
                <ul class="mb-0 ps-3">
                  <c:forEach var="resp" items="${p.respuestas}">
                    <li><c:out value="${resp}"/></li>
                  </c:forEach>
                </ul>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </c:forEach>

  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">
      Esta informaci&oacute;n es confidencial. La interpretaci&oacute;n y las decisiones profesionales son responsabilidad de el profesional a cargo.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
</body>
</html>
