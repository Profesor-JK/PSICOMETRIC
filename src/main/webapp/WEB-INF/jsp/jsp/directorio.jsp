<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="esPaciente" value="${pageContext.request.isUserInRole('PACIENTE')}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Directorio de Tests</title>

  <link rel="icon" type="image/png" href="/img/icon.png?v=2">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estilodire.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="directorio"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-4 animate-fade-up">
    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Directorio de tests</h1>
      <p class="text-muted mb-0">Los tests publicados, organizados por categor&iacute;a.</p>
    </div>

    <c:if test="${empty categorias}">
      <div class="text-center text-muted py-5">
        <i class="bi bi-journal-x fs-1 d-block mb-2"></i>
        <p class="mb-0">A&uacute;n no hay tests publicados. Vuelve pronto.</p>
      </div>
    </c:if>

    <div class="accordion" id="accordionTests">
      <c:forEach var="cat" items="${categorias}" varStatus="st">
        <c:choose>
          <c:when test="${st.index % 3 == 0}">
            <c:set var="colorBorde" value="var(--bs-primary-border-subtle)"/>
            <c:set var="colorFondo" value="var(--bs-primary-bg-subtle)"/>
            <c:set var="colorTexto" value="#052c65"/>
            <c:set var="colorBadge" value="#0d6efd"/>
            <c:set var="colorFoco" value="rgba(13, 110, 253, 0.25)"/>
          </c:when>
          <c:when test="${st.index % 3 == 1}">
            <c:set var="colorBorde" value="#e8dbf8"/>
            <c:set var="colorFondo" value="#f3ebfd"/>
            <c:set var="colorTexto" value="#6f42c1"/>
            <c:set var="colorBadge" value="#6f42c1"/>
            <c:set var="colorFoco" value="rgba(111, 66, 193, 0.25)"/>
          </c:when>
          <c:otherwise>
            <c:set var="colorBorde" value="#f8d7da"/>
            <c:set var="colorFondo" value="#fdecea"/>
            <c:set var="colorTexto" value="#dc3545"/>
            <c:set var="colorBadge" value="#dc3545"/>
            <c:set var="colorFoco" value="rgba(220, 53, 69, 0.25)"/>
          </c:otherwise>
        </c:choose>

        <div class="accordion-item mb-3 animate-fade-up delay-${(st.index % 3) + 1}" style="border-color: ${colorBorde};">
          <h2 class="accordion-header" id="heading${st.index}">
            <button class="accordion-button fw-bold text-dark ${st.first ? '' : 'collapsed'}" type="button"
                    data-bs-toggle="collapse" data-bs-target="#collapse${st.index}"
                    aria-expanded="${st.first}" aria-controls="collapse${st.index}"
                    style="--bs-accordion-active-bg: ${colorFondo}; --bs-accordion-active-color: ${colorTexto}; --bs-accordion-btn-focus-box-shadow: 0 0 0 0.25rem ${colorFoco};">
              <span class="me-2"><c:out value="${cat.nombre}"/></span>
              <span class="badge rounded-pill text-white" style="background-color: ${colorBadge};">${cat.total}</span>
            </button>
          </h2>
          <div id="collapse${st.index}" class="accordion-collapse collapse ${st.first ? 'show' : ''}"
               aria-labelledby="heading${st.index}" data-bs-parent="#accordionTests">
            <div class="accordion-body p-0">
              <div class="list-group list-group-flush">
                <c:forEach var="t" items="${cat.tests}">
                  <c:choose>
                    <c:when test="${esPaciente}">
                      <a href="${ctx}/test/${t.idTest}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                        <span><c:out value="${t.nombre}"/></span>
                        <c:if test="${t.duracionMin gt 0}">
                          <span class="badge text-white rounded-pill" style="background-color: ${colorBadge};">${t.duracionMin} min</span>
                        </c:if>
                      </a>
                    </c:when>
                    <c:otherwise>
                      <div class="list-group-item d-flex justify-content-between align-items-center">
                        <span><c:out value="${t.nombre}"/></span>
                        <c:if test="${t.duracionMin gt 0}">
                          <span class="badge text-white rounded-pill" style="background-color: ${colorBadge};">${t.duracionMin} min</span>
                        </c:if>
                      </div>
                    </c:otherwise>
                  </c:choose>
                </c:forEach>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
      <span>&copy; 2026 Psicometric. Todos los derechos reservados.</span>
      <div class="hstack gap-3">
        <a href="/directorio" class="text-muted text-decoration-none">Directorio</a>
        <a href="/info" class="text-muted text-decoration-none">&iquest;Qui&eacute;nes somos?</a>
      </div>
    </div>
    <p class="mb-0 mt-3 text-center text-md-start">
      Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="/js/navbar.js"></script>

</body>
</html>