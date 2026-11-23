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

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="icon" type="image/png" href="/img/icon.png?v=2">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/styles/comun.css">
    <link rel="stylesheet" href="/styles/estilotest.css">
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
            <c:set var="tema" value="${st.index % 2 == 0 ? 'theme-accent' : 'theme-primary'}"/>
            <div class="col-auto animate-fade-up delay-${(st.index % 3) + 1}">
                <div class="card ${tema} hover-lift card-seleccionable" style="width: 18rem;"
                     data-bs-toggle="dialog"
                     data-bs-target="#modalDetalleTest"
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
                        <button type="button" class="btn-solid ${tema}">Ver detalles</button>
                    </div>
                    <div class="card-footer fg-3">
                        Publicado el ${t.fechaCreacion.toLocalDate()}
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

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

<script src="/js/navbar.js"></script>

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
</body>
</html>