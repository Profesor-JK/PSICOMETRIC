<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Actividad del paciente</title>
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

    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Actividad del paciente</h1>
      <p class="text-muted mb-0">Tests que han contestado los pacientes a tu cargo y su resultado.</p>
    </div>

    <c:choose>
      <c:when test="${empty intentos}">
        <section class="seccion-card">
          <div class="seccion-body">
            <div class="estado-vacio">
              <i class="bi bi-journal-check"></i>
              <p class="mb-0">Todav&iacute;a no hay actividad registrada.</p>
            </div>
          </div>
        </section>
      </c:when>
      <c:otherwise>
        <c:forEach var="i" items="${intentos}">
          <div class="resultado-card nivel-${i.nivelRango}">
            <div class="d-flex justify-content-between align-items-start flex-wrap gap-2">
              <div>
                <h2 class="h6 fw-bold mb-1"><c:out value="${i.nombreTest}"/></h2>
                <div class="small text-muted">
                  <i class="bi bi-person"></i> <c:out value="${i.nombrePaciente}"/> &middot;
                  <i class="bi bi-calendar-event"></i> <c:out value="${i.fechaTexto}"/>
                  <c:if test="${not empty i.categoriaTest}"> &middot; <c:out value="${i.categoriaTest}"/></c:if>
                </div>
              </div>
              <div class="text-end">
                <div class="fs-4 fw-bold lh-1"><fmt:formatNumber value="${i.puntaje}" maxFractionDigits="2"/></div>
                <div class="small text-muted">de <fmt:formatNumber value="${i.puntajeMax}" maxFractionDigits="2"/> pts</div>
              </div>
            </div>

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mt-3">
              <c:choose>
                <c:when test="${not empty i.tituloRango}">
                  <span class="badge text-bg-${i.nivelRango}"><c:out value="${i.tituloRango}"/></span>
                </c:when>
                <c:otherwise><span class="text-muted small">Sin interpretaci&oacute;n</span></c:otherwise>
              </c:choose>
              <a href="${ctx}/tutor/actividad/${i.idIntento}" class="btn btn-sm btn-outline-primary">Ver respuestas</a>
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
