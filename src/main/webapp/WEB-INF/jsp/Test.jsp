<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Psicometric | Tests</title>

    <link rel="icon" type="image/png" href="/img/icon.png?v=2">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>
<body class="bg-white">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
    <jsp:param name="activo" value="directorio"/>
</jsp:include>

<div class="container my-4">

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>

    <div class="px-3">
        <h1 class="h3 fw-bold mb-1">Tests disponibles</h1>
        <p class="text-muted mb-0">Elige un test, revisa sus detalles y comienza cuando est&eacute;s listo.</p>
    </div>

    <c:if test="${empty tests}">
        <div class="text-center text-muted py-5">
            <i class="bi bi-journal-x fs-1 d-block mb-2"></i>
            <p class="mb-0">A&uacute;n no hay tests publicados. Vuelve pronto.</p>
        </div>
    </c:if>

    <div class="row g-4 p-3">
        <c:forEach var="t" items="${tests}" varStatus="st">
            <c:set var="tema" value="${st.index % 2 == 0 ? 'tema-verde' : 'tema-azul'}"/>
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100 ${tema} card-click"
                     data-abrir-detalle
                     data-tema="${tema}"
                     data-titulo="<c:out value='${t.nombre}'/>"
                     data-categoria="<c:out value='${t.categoria}'/>"
                     data-descripcion="<c:out value='${t.descripcion}'/>"
                     data-detalles="<c:if test='${t.duracionMin gt 0}'>Duración aproximada: ${t.duracionMin} minutos | </c:if>${fn:length(t.preguntas)} preguntas"
                     data-url="${ctx}/test/${t.idTest}">
                    <div class="card-header">
                        <c:out value="${t.categoria}"/>
                    </div>
                    <div class="card-body">
                        <h4 class="card-title"><c:out value="${t.nombre}"/></h4>
                        <p class="card-text">
                            <c:out value="${fn:substring(t.descripcion, 0, 110)}"/><c:if test="${fn:length(t.descripcion) gt 110}">&hellip;</c:if>
                        </p>
                        <button type="button" class="btn btn-primary">Ver detalles</button>
                    </div>
                    <div class="card-footer text-muted small">
                        Publicado el ${t.fechaCreacion.toLocalDate()}
                        <c:if test="${t.esExclusivo()}"> &middot; Exclusivo para ti</c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<dialog class="detalle tema-azul" id="modalDetalleTest" aria-labelledby="modalTitulo">
  <div class="detalle-cabecera">
    <div>
      <span class="badge etiqueta mb-1" id="modalCategoria">Categor&iacute;a</span>
      <h5 class="fw-bold mb-0" id="modalTitulo">Nombre del Test</h5>
    </div>
    <button type="button" class="btn-close" data-cerrar aria-label="Cerrar"></button>
  </div>
  <div class="detalle-cuerpo">
    <p id="modalDescripcion" class="mb-3">Descripci&oacute;n detallada del test...</p>
    <div class="nota"><span id="modalDetalles">Duraci&oacute;n y estructura</span></div>
  </div>
  <div class="detalle-pie">
    <button type="button" class="btn btn-outline-secondary" data-cerrar>Cerrar</button>
    <a href="#" id="modalBtnIniciar" class="btn btn-primary">Comenzar Test</a>
  </div>
</dialog>

<script src="/js/navbar.js"></script>

<script src="/js/detalle-test.js"></script>
</body>
</html>