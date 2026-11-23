<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | <c:out value="${test.nombre}"/></title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="/styles/comun.css">
  <link rel="stylesheet" href="/styles/estilocrear.css">
  <style>
    .escala-fila { display: flex; flex-wrap: wrap; gap: .5rem; }
    .escala-fila .form-check-inline { margin: 0; text-align: center; }
    .escala-etiquetas { display: flex; justify-content: space-between; font-size: .8rem; color: #6c757d; margin-top: .35rem; }
    .grupo-error { outline: 2px solid #dc3545; outline-offset: 4px; border-radius: .5rem; }
    .texto-pre { white-space: pre-line; }
  </style>
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="test"/>
</jsp:include>

<main class="flex-grow-1">
  <div class="container my-4" style="max-width: 860px;">

    <c:if test="${not empty error}">
      <div class="alert alert-danger" role="alert"><c:out value="${error}"/></div>
    </c:if>
    <div id="alertaValidacion" class="alert alert-danger d-none" role="alert"></div>

    <div class="mb-4">
      <c:if test="${not empty test.categoria}">
        <span class="badge text-bg-primary mb-2"><c:out value="${test.categoria}"/></span>
      </c:if>
      <h1 class="h3 fw-bold mb-1"><c:out value="${test.nombre}"/></h1>
      <p class="text-muted mb-2 texto-pre"><c:out value="${test.descripcion}"/></p>
      <div class="small text-muted d-flex gap-3 flex-wrap">
        <c:if test="${test.duracionMin gt 0}">
          <span><i class="bi bi-clock me-1"></i>${test.duracionMin} min aprox.</span>
        </c:if>
        <span><i class="bi bi-list-check me-1"></i>${fn:length(test.preguntas)} preguntas</span>
      </div>
    </div>

    <c:if test="${not empty test.instrucciones}">
      <div class="alert alert-info d-flex align-items-start gap-2" role="alert">
        <i class="bi bi-info-circle mt-1"></i>
        <div class="texto-pre"><c:out value="${test.instrucciones}"/></div>
      </div>
    </c:if>

    <form id="formResolver" method="post" action="${ctx}/test/${test.idTest}/enviar">

      <c:forEach var="p" items="${test.preguntas}">
        <section class="seccion-card mb-4">
          <div class="seccion-body">
            <div class="d-flex align-items-start gap-3 mb-3">
              <span class="pregunta-num">${p.orden}</span>
              <div class="flex-grow-1">
                <h2 class="h6 fw-semibold mb-0 texto-pre"><c:out value="${p.texto}"/></h2>
                <c:if test="${p.obligatoria}"><small class="text-danger">* Obligatoria</small></c:if>
              </div>
            </div>

            <c:choose>

              <%-- Opción única --%>
              <c:when test="${p.tipo == 'unica'}">
                <c:forEach var="o" items="${p.opciones}" varStatus="so">
                  <div class="form-check mb-2">
                    <input class="form-check-input" type="radio" name="p_${p.idPregunta}"
                           id="o_${o.idOpcion}" value="${o.idOpcion}" ${p.obligatoria and so.first ? 'required' : ''}>
                    <label class="form-check-label" for="o_${o.idOpcion}"><c:out value="${o.texto}"/></label>
                  </div>
                </c:forEach>
              </c:when>

              <%-- Selección múltiple --%>
              <c:when test="${p.tipo == 'multiple'}">
                <div class="grupo-multiple" data-obligatoria="${p.obligatoria}" data-orden="${p.orden}">
                  <c:forEach var="o" items="${p.opciones}">
                    <div class="form-check mb-2">
                      <input class="form-check-input" type="checkbox" name="p_${p.idPregunta}"
                             id="o_${o.idOpcion}" value="${o.idOpcion}">
                      <label class="form-check-label" for="o_${o.idOpcion}"><c:out value="${o.texto}"/></label>
                    </div>
                  </c:forEach>
                  <small class="text-muted">Puedes elegir varias respuestas.</small>
                </div>
              </c:when>

              <%-- Escala numérica --%>
              <c:when test="${p.tipo == 'escala'}">
                <c:choose>
                  <c:when test="${p.escalaCompacta}">
                    <div class="escala-fila">
                      <c:forEach var="v" begin="${p.escalaMinEntero}" end="${p.escalaMaxEntero}" varStatus="sv">
                        <div class="form-check form-check-inline">
                          <input class="form-check-input mx-auto d-block" type="radio" name="p_${p.idPregunta}"
                                 id="e_${p.idPregunta}_${v}" value="${v}" ${p.obligatoria and sv.first ? 'required' : ''}>
                          <label class="form-check-label d-block" for="e_${p.idPregunta}_${v}">${v}</label>
                        </div>
                      </c:forEach>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <input type="number" class="form-control w-auto" name="p_${p.idPregunta}"
                           min="${p.escalaMin}" max="${p.escalaMax}" step="any" ${p.obligatoria ? 'required' : ''}>
                  </c:otherwise>
                </c:choose>
                <div class="escala-etiquetas">
                  <span><c:out value="${p.etiquetaMin}"/></span>
                  <span><c:out value="${p.etiquetaMax}"/></span>
                </div>
              </c:when>

              <%-- Respuesta abierta --%>
              <c:otherwise>
                <textarea class="form-control" rows="3" name="p_${p.idPregunta}" maxlength="2000"
                          placeholder="Escribe tu respuesta" ${p.obligatoria ? 'required' : ''}></textarea>
              </c:otherwise>

            </c:choose>
          </div>
        </section>
      </c:forEach>

      <div class="d-flex gap-2 justify-content-end mb-5">
        <a href="${ctx}/test" class="btn btn-outline-secondary">Cancelar</a>
        <button type="submit" class="btn btn-primary btn-lg"><i class="bi bi-send me-1"></i>Enviar respuestas</button>
      </div>
    </form>
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
<script>
  // Las preguntas de selección múltiple obligatorias no se pueden validar con "required" de HTML
  document.getElementById('formResolver').addEventListener('submit', function (e) {
    const aviso = document.getElementById('alertaValidacion');
    let primero = null;
    const faltan = [];

    document.querySelectorAll('.grupo-multiple').forEach(function (g) {
      g.classList.remove('grupo-error');
      if (g.dataset.obligatoria === 'true' && !g.querySelector('input:checked')) {
        g.classList.add('grupo-error');
        faltan.push(g.dataset.orden);
        if (!primero) primero = g;
      }
    });

    if (faltan.length) {
      e.preventDefault();
      aviso.textContent = 'Falta responder la pregunta ' + faltan.join(', ') + '.';
      aviso.classList.remove('d-none');
      primero.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
      aviso.classList.add('d-none');
    }
  });
</script>

</body>
</html>
