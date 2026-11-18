<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Psicometric | Crear Test</title>
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

<nav class="psico-nav">
  <div class="container psico-bar">
    <a class="psico-brand" href="/">
      <i class="bi bi-brain fs-4"></i>
      <span>Psicometric</span>
    </a>

    <button class="psico-toggler" id="psicoToggler" type="button" aria-controls="psicoMenu" aria-expanded="false" aria-label="Toggle navigation">
      <i class="bi bi-list"></i>
    </button>

    <div class="psico-menu" id="psicoMenu">
      <ul class="psico-links">
        <li><a class="psico-link" href="/">Inicio</a></li>
        <li><a class="psico-link" href="/directorio">Directorio de Tests</a></li>
        <li><a class="psico-link active" aria-current="page" href="/psicologo/crear-test">Crear Test</a></li>
        <li><a class="psico-link" href="/#comunidad">Psic&oacute;logos y Pacientes</a></li>
        <li><a class="psico-link" href="/info">&iquest;Qui&eacute;nes somos?</a></li>
      </ul>

      <div class="psico-actions">
        <a href="/login" class="psico-btn psico-btn-outline">Iniciar Sesi&oacute;n</a>
        <a href="/registro" class="psico-btn psico-btn-primary">Crear Cuenta</a>
      </div>
    </div>
  </div>
</nav>

<main class="flex-grow-1">
  <div class="container my-4">

    <div class="mb-4">
      <h1 class="h3 fw-bold mb-1">Creaci&oacute;n de test</h1>
      <p class="text-muted mb-0">Define las preguntas, las respuestas y el resultado que ver&aacute; el usuario seg&uacute;n su puntaje. No hay l&iacute;mite de preguntas ni de respuestas.</p>
    </div>


    <form id="formTest" method="post" action="/psicologo/tests/guardar" data-demo="true" novalidate>
      <input type="hidden" name="testJson" id="testJson">

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
              Test validado. <strong>Modo demostraci&oacute;n:</strong> a&uacute;n no se env&iacute;a al servidor; abajo puedes ver los datos que se guardar&iacute;an.
            </div>

            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-primary btn-lg">
                <i class="bi bi-save me-1"></i>Guardar test
              </button>
              <button type="button" id="btnVistaJson" class="btn btn-outline-secondary">
                <i class="bi bi-code-slash me-1"></i>Ver datos del test (JSON)
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
        <a href="/directorio" class="text-muted text-decoration-none">Directorio</a>
        <a href="/info" class="text-muted text-decoration-none">&iquest;Qui&eacute;nes somos?</a>
      </div>
    </div>
    <p class="mb-0 mt-3 text-center text-md-start">
      Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
    </p>
  </div>
</footer>

<script src="/js/navbar.js"></script>
<script src="/js/creartest.js"></script>

</body>
</html>
