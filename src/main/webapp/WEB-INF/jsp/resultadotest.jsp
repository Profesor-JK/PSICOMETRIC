<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Resultado</title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="test"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-5 ancho-form">

    <div class="text-center mb-4">
      <p class="text-uppercase text-muted small fw-semibold mb-1">Resultado</p>
      <h1 class="h3 fw-bold mb-0"><c:out value="${test.nombre}"/></h1>
    </div>

    <section class="seccion-card mb-4">
      <div class="seccion-body text-center">
        <div class="text-muted small mb-1">Tu puntaje</div>
        <div class="display-3 fw-bold">
          <fmt:formatNumber value="${intento.puntaje}" maxFractionDigits="2"/>
        </div>
        <div class="text-muted small">
          de <fmt:formatNumber value="${test.puntajeMin}" maxFractionDigits="2"/>
          a <fmt:formatNumber value="${test.puntajeMax}" maxFractionDigits="2"/> puntos posibles
        </div>
      </div>
    </section>

    <c:choose>
      <c:when test="${not empty intento.rango}">
        <div class="alert alert-<c:out value='${intento.rango.nivel}'/>" role="alert">
          <h2 class="h5 fw-bold"><c:out value="${intento.rango.titulo}"/></h2>
          <p class="mb-0 texto-pre"><c:out value="${intento.rango.descripcion}"/></p>
        </div>
      </c:when>
      <c:otherwise>
        <div class="alert alert-secondary" role="alert">
          Este test no tiene una interpretaci&oacute;n para tu puntaje. Comenta tu resultado con tu psic&oacute;logo.
        </div>
      </c:otherwise>
    </c:choose>

    <div class="d-flex gap-2 justify-content-center flex-wrap mt-4">
      <a href="${ctx}/test" class="btn btn-primary">Ver m&aacute;s tests</a>
      <a href="${ctx}/paciente/historial" class="btn btn-outline-primary">Mis tests realizados</a>
      <a href="${ctx}/paciente/inicio" class="btn btn-outline-secondary">Ir al inicio</a>
    </div>
  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <p class="mb-0 text-center text-md-start">
      Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
</body>
</html>
