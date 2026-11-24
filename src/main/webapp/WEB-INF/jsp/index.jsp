<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Inicio</title>
  <link rel="icon" type="image/png" href="/img/icon.png?v=2">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>

  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estiloindex.css">
</head>


<body class="d-flex flex-column min-vh-100">


<c:set var="esPaciente" value="${pageContext.request.isUserInRole('PACIENTE')}" />
<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="inicio"/>
</jsp:include>

<main class="flex-grow-1">

  <header class="py-5 bg-white border-bottom">
    <div class="container py-4 text-center animate-fade-up">

      <h1 class="display-5 fw-bold mb-3">Evaluaciones precisas, resultados claros</h1>
      <p class="lead text-muted mx-auto mb-4" style="max-width: 620px;">
        Gestiona pruebas cognitivas y de personalidad, conecta especialistas con pacientes y visualiza m&eacute;tricas en tiempo real.
      </p>
      <div class="d-flex justify-content-center gap-3 flex-wrap">
        <a href="/directorio" class="btn-solid theme-primary px-4 py-2 d-inline-flex align-items-center gap-2">
          <span>Explorar Directorio de Tests</span>
          <i class="bi bi-arrow-right"></i>
        </a>
        <a href="#destacados" class="btn-outline theme-secondary px-4 py-2">
          Ver Destacados
        </a>
      </div>
    </div>
  </header>

  <section id="destacados" class="container py-5">
    <div class="d-flex justify-content-between align-items-end mb-4 animate-fade-up delay-1">
      <div>
        <p class="text-uppercase text-muted small fw-semibold mb-1">Selecci&oacute;n Principal</p>
        <h2 class="h3 fw-bold mb-0">Tests Destacados</h2>
      </div>
      <a href="/directorio" class="text-decoration-none fw-semibold d-inline-flex align-items-center gap-1">
        <span>Ver todos los tests</span>
        <i class="bi bi-chevron-right"></i>
      </a>
    </div>

    <c:if test="${empty tests}">
      <div class="text-center text-muted py-4">
        <i class="bi bi-journal-x fs-1 d-block mb-2"></i>
        <p class="mb-0">A&uacute;n no hay tests publicados. Vuelve pronto.</p>
      </div>
    </c:if>

    <div class="row g-4">
      <c:forEach var="t" items="${tests}" varStatus="st">
        <c:set var="tema" value="${st.index % 2 == 0 ? 'theme-accent' : 'theme-primary'}"/>
        <div class="col-12 col-md-6 col-lg-4 animate-fade-up delay-${st.index + 1}">
          <div class="card h-100 ${tema} card-hover rounded-4"
               data-bs-toggle="dialog"
               data-bs-target="#modalDetalleTest"
               data-tema="${tema}"
               data-titulo="<c:out value='${t.nombre}'/>"
               data-categoria="<c:out value='${t.categoria}'/>"
               data-descripcion="<c:out value='${t.descripcion}'/>"
               data-detalles="<c:if test='${t.duracionMin gt 0}'>Duración: ${t.duracionMin} min | </c:if>${fn:length(t.preguntas)} preguntas"
               data-url="${esPaciente ? '/test/' : '/login'}${esPaciente ? t.idTest : ''}"
               data-boton="${esPaciente ? 'Comenzar Test' : 'Inicia sesión para comenzar'}">
            <div class="card-body p-4 d-flex flex-column">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <span class="badge theme-subtle ${tema}"><c:out value="${empty t.categoria ? 'Sin categoría' : t.categoria}"/></span>
                <c:if test="${t.duracionMin gt 0}">
                  <small class="text-muted"><i class="bi bi-clock me-1"></i>${t.duracionMin} min</small>
                </c:if>
              </div>
              <h4 class="card-title fw-bold mb-2"><c:out value="${t.nombre}"/></h4>
              <p class="card-text text-muted small flex-grow-1">
                <c:out value="${fn:substring(t.descripcion, 0, 120)}"/><c:if test="${fn:length(t.descripcion) gt 120}">&hellip;</c:if>
              </p>
              <div class="pt-3 border-top d-flex justify-content-between align-items-center">
                <span class="small fw-semibold">Ver detalles</span>
                <i class="bi bi-arrow-up-right"></i>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <section id="comunidad" class="container pb-5">
    <div class="card border-0 shadow-sm rounded-4 animate-fade-up delay-2">
      <div class="card-header bg-white border-bottom p-4 d-flex align-items-center gap-2 rounded-top-4">
        <i class="bi bi-person-badge fs-4 text-primary"></i>
        <div>
          <h3 class="h5 fw-bold mb-0">Psic&oacute;logos</h3>
          <small class="text-muted">Especialistas registrados en la plataforma</small>
        </div>
      </div>
      <div class="card-body p-3">
        <c:if test="${empty psicologos}">
          <p class="text-muted text-center my-3">A&uacute;n no hay psic&oacute;logos registrados.</p>
        </c:if>
        <div class="vstack gap-2">
          <c:forEach var="p" items="${psicologos}">
            <div class="user-row p-3 d-flex align-items-center gap-3">
              <div class="avatar-circle theme-subtle theme-primary"><i class="bi bi-person"></i></div>
              <div>
                <h6 class="mb-0 fw-semibold"><c:out value="${p.nombre} ${p.apellidospsic}"/></h6>
                <small class="text-muted"><c:out value="${p.titulo}"/> &bull; <c:out value="${p.escuela}"/> &bull; C&eacute;d. <c:out value="${p.cedula}"/></small>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
    </div>
  </section>

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

<dialog class="dialog dialog-slide-up" id="modalDetalleTest" aria-labelledby="modalTitulo">
  <div class="dialog-header theme-subtle" id="modalHeader">
    <div>
      <span class="badge mb-1" id="modalCategoria">Categor&iacute;a</span>
      <h5 class="dialog-title fs-lg fw-bold" id="modalTitulo">Nombre del Test</h5>
    </div>
    <button type="button" class="btn-close" data-bs-dismiss="dialog" aria-label="Cerrar"></button>
  </div>
  <div class="dialog-body">
    <p id="modalDescripcion" class="mb-3">Descripci&oacute;n detallada del test...</p>
    <div class="alert mb-0" id="modalAlerta">
      <small id="modalDetalles" class="fw-medium">Duraci&oacute;n y estructura</small>
    </div>
  </div>
  <div class="dialog-footer">
    <button type="button" class="btn-outline theme-secondary" data-bs-dismiss="dialog">Cerrar</button>
    <a href="#" id="modalBtnIniciar" class="btn-solid">Comenzar Test</a>
  </div>
</dialog>

<script>
  const modal = document.getElementById('modalDetalleTest');

  if (modal) {
    modal.addEventListener('show.bs.dialog', function (event) {
      const carta = event.relatedTarget;
      if (!carta) return;

      const tema = carta.getAttribute('data-tema') || 'theme-primary';
      const titulo = carta.getAttribute('data-titulo') || '';
      const categoria = carta.getAttribute('data-categoria') || '';
      const descripcion = carta.getAttribute('data-descripcion') || '';
      const detalles = carta.getAttribute('data-detalles') || '';
      const url = carta.getAttribute('data-url') || '#';

      document.getElementById('modalTitulo').textContent = titulo;
      document.getElementById('modalCategoria').textContent = categoria;
      document.getElementById('modalDescripcion').textContent = descripcion;
      document.getElementById('modalDetalles').textContent = detalles;
      document.getElementById('modalBtnIniciar').setAttribute('href', url);
      document.getElementById('modalBtnIniciar').textContent = carta.getAttribute('data-boton') || 'Comenzar Test';

      const elementosTematizados = [
        modal,
        document.getElementById('modalHeader'),
        document.getElementById('modalCategoria'),
        document.getElementById('modalAlerta'),
        document.getElementById('modalBtnIniciar')
      ];

      elementosTematizados.forEach(el => {
        if (el) {
          el.classList.remove('theme-accent', 'theme-primary');
          el.classList.add(tema);
        }
      });

      modal.classList.add('theme-border');
    });
  }
</script>

<script src="/js/navbar.js"></script>

</body>
</html>
