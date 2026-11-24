<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Alta de test</title>
  <link rel="icon" type="image/png" href="/img/icon.png">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>

<body class="bg-white d-flex flex-column min-vh-100">

<jsp:include page="/WEB-INF/jsp/fragments/navbar.jsp">
  <jsp:param name="activo" value="adminTests"/>
</jsp:include>
    
<main class="flex-grow-1">
  <div class="container my-4">

    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Creaci&oacute;n de test</h1>
      <p class="text-muted mb-0">Define las preguntas, las respuestas y el resultado que ver&aacute; el usuario seg&uacute;n su puntaje. No hay l&iacute;mite de preguntas ni de respuestas.</p>
    </div>


    <form id="formTest" method="post" action="/admin/tests/alta" novalidate>

      <div class="row g-4">

        <div class="col-lg-8">

          <section class="seccion-card mb-4">
            <header class="seccion-header">
              <span class="seccion-icono bg-primary-subtle text-primary"><i class="bi bi-info-circle"></i></span>
              <div>
                <h2 class="h5 fw-bold mb-0">1. Informaci&oacute;n general</h2>
                <small class="text-muted">Datos que identifican al test</small>
              </div>
            </header>
            <div class="seccion-body">
              <div class="row g-3">
                <div class="col-12">
                  <label for="adminPsicologo" class="form-label fw-semibold">Psic&oacute;logo responsable <span class="text-danger">*</span></label>
                  <select class="form-select" id="adminPsicologo">
                    <option value="">Selecciona un psic&oacute;logo</option>
                    <c:forEach var="p" items="${psicologos}">
                      <option value="${p.cedula}"><c:out value="${p.nombre}"/> <c:out value="${p.apellidospsic}"/> (c&eacute;dula ${p.cedula})</option>
                    </c:forEach>
                  </select>
                  <div class="form-text">El test quedar&aacute; a nombre de este psic&oacute;logo.</div>
                </div>
                <div class="col-12">
                  <label for="testNombre" class="form-label fw-semibold">Nombre del test <span class="text-danger">*</span></label>
                  <input type="text" class="form-control campo-info" id="testNombre" >
                </div>
                <div class="col-md-8">
                  <label for="testCategoria" class="form-label fw-semibold">Categor&iacute;a</label>
                  <input type="text" class="form-control campo-info" id="testCategoria" list="listaCategorias" placeholder="Elige una o escribe la tuya">
                  <datalist id="listaCategorias">
                    <option value="Aptitudes, Habilidades y Perfil Laboral">
                    <option value="Evaluación de Inteligencia y Capacidad Cognitiva (CI)">
                    <option value="Personalidad">
                    <option value="Estado emocional">
                  </datalist>
                </div>
                <div class="col-md-4">
                  <label for="testDuracion" class="form-label fw-semibold">Duraci&oacute;n (min)</label>
                  <input type="number" min="0" class="form-control campo-info" id="testDuracion" placeholder="Ej. 20">
                </div>
                <div class="col-12">
                  <label for="testDescripcion" class="form-label fw-semibold">Descripci&oacute;n</label>
                  <textarea class="form-control campo-info" id="testDescripcion" rows="2" placeholder="Qu&eacute; mide el test y para qui&eacute;n es"></textarea>
                </div>
                <div class="col-12">
                  <label for="testInstrucciones" class="form-label fw-semibold">Instrucciones para el usuario</label>
                  <textarea class="form-control campo-info" id="testInstrucciones" rows="2" placeholder="Qu&eacute; debe saber el usuario antes de empezar"></textarea>
                </div>
                <div class="col-12">
                  <div class="form-check form-switch">
                    <input class="form-check-input campo-info" type="checkbox" role="switch" id="testExclusivo">
                    <label class="form-check-label fw-semibold" for="testExclusivo">Test EXCLUSIVO PARA UN PACIENTE</label>
                  </div>
                  <div id="bloqueExclusivo" class="d-none mt-2">
                    <label for="testPaciente" class="form-label fw-semibold">Paciente <span class="text-danger">*</span></label>
                    <div class="input-group">
                      <select class="form-select campo-info" id="testPaciente">
                        <option value="">Selecciona un paciente</option>
                      </select>
                      <button type="button" class="btn btn-outline-secondary" id="btnRecargarPacientes" title="Actualizar lista de pacientes">
                        <i class="bi bi-arrow-clockwise"></i>
                      </button>
                    </div>
                    <div class="form-text">Solo este paciente ver&aacute; el test: no aparece en el directorio ni para los dem&aacute;s pacientes.</div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <section class="seccion-card mb-4">
            <header class="seccion-header">
              <span class="seccion-icono bg-success-subtle text-success"><i class="bi bi-ui-checks-grid"></i></span>
              <div>
                <h2 class="h5 fw-bold mb-0">2. Preguntas y respuestas</h2>
                <small class="text-muted">Cada respuesta puede sumar (o restar) puntos</small>
              </div>
            </header>
            <div class="seccion-body">
              <div id="sinPreguntas" class="estado-vacio d-none">
                <i class="bi bi-question-circle"></i>
                <p class="mb-0">A&uacute;n no hay preguntas. Agrega la primera.</p>
              </div>

              <div id="listaPreguntas"></div>

              <button type="button" id="btnAddPregunta" class="btn btn-primary">
                <i class="bi bi-plus-lg me-1"></i>Agregar pregunta
              </button>
            </div>
          </section>

          <section class="seccion-card mb-4">
            <header class="seccion-header">
              <span class="seccion-icono bg-warning-subtle text-warning-emphasis"><i class="bi bi-bar-chart-line"></i></span>
              <div>
                <h2 class="h5 fw-bold mb-0">3. Resultados seg&uacute;n el puntaje</h2>
                <small class="text-muted">Lo que ver&aacute; el usuario al terminar, seg&uacute;n sus respuestas</small>
              </div>
            </header>
            <div class="seccion-body">
              <div class="alert alert-info d-flex align-items-start gap-2 py-2 small" role="alert">
                <i class="bi bi-lightbulb mt-1"></i>
                <div>
                  El puntaje del usuario es la suma de los puntos de sus respuestas.
                  Crea un rango por cada resultado posible y usa rangos consecutivos
                  (por ejemplo 0&ndash;10 y 11&ndash;20) para que ning&uacute;n puntaje se quede sin resultado.
                  <strong id="infoRangoPosible">Puntaje posible: 0 a 0 puntos</strong>
                </div>
              </div>

              <div id="listaResultados"></div>

              <button type="button" id="btnAddResultado" class="btn btn-outline-primary">
                <i class="bi bi-plus-lg me-1"></i>Agregar rango de resultado
              </button>
            </div>
          </section>

        </div>

        <aside class="col-lg-4">
          <div class="panel-lateral">

            <div class="seccion-card mb-3">
              <div class="seccion-body">
                <h2 class="h6 fw-bold mb-3">Resumen del test</h2>
                <div class="row g-2 text-center">
                  <div class="col-6"><div class="stat-box"><div class="stat-num" id="resPreguntas">0</div><div class="stat-label">Preguntas</div></div></div>
                  <div class="col-6"><div class="stat-box"><div class="stat-num" id="resRangos">0</div><div class="stat-label">Resultados</div></div></div>
                  <div class="col-6"><div class="stat-box"><div class="stat-num" id="resMin">0</div><div class="stat-label">Puntaje m&iacute;nimo</div></div></div>
                  <div class="col-6"><div class="stat-box"><div class="stat-num" id="resMax">0</div><div class="stat-label">Puntaje m&aacute;ximo</div></div></div>
                </div>
              </div>
            </div>

            <div class="seccion-card mb-3">
              <div class="seccion-body">
                <h2 class="h6 fw-bold mb-3">Revisi&oacute;n</h2>
                <div id="revision"></div>
              </div>
            </div>

            <div id="alertaGuardado" class="alert alert-success small d-none" role="alert">
              <i class="bi bi-check-circle-fill me-1"></i>
              <span id="msgGuardado">Test guardado.</span>
              <div class="mt-2 d-flex gap-2 flex-wrap">
                <a href="/creartest" class="btn btn-sm btn-success">Crear otro test</a>
                <a href="/psicologo/inicio" class="btn btn-sm btn-outline-success">Ir al inicio</a>
              </div>
            </div>

            <div id="alertaError" class="alert alert-danger small d-none" role="alert">
              <i class="bi bi-x-circle-fill me-1"></i>
              <span id="msgError"></span>
            </div>

            <div class="d-grid gap-2">
              <button type="submit" id="btnGuardar" class="btn btn-primary btn-lg">
                <i class="bi bi-save me-1"></i>Guardar test
              </button>
            </div>

            <pre id="jsonPreview" class="json-preview d-none mt-3"></pre>

          </div>
        </aside>

      </div>
    </form>
  </div>
</main>

<footer class="bg-white border-top py-4">
  <div class="container text-muted small">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
      <span>&copy; 2026 Psicometric. Todos los derechos reservados.</span>
      <div class="hstack gap-3">
        <a href="/admin/tests" class="text-muted text-decoration-none">Ver tests</a>
      </div>
    </div>
    <p class="mb-0 mt-3 text-center text-md-start">
      Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
<script src="/js/creartest.js"></script>
<script>
  // el servidor necesita saber a qué psicólogo pertenece el test
  (function () {
    var sel = document.getElementById('adminPsicologo');
    var form = document.getElementById('formTest');
    function actualizar() { form.setAttribute('action', '/admin/tests/alta?cedula=' + encodeURIComponent(sel.value)); }
    sel.addEventListener('change', actualizar);
    actualizar();
  })();
</script>

</body>
</html>
