<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Psicometric | Inicio Psicólogo</title>
    <link rel="icon" type="image/png" href="/img/icon.png?v=2">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="/styles/estilos.css">
</head>

<body class="d-flex flex-column min-vh-100">

<nav class="psico-nav">
    <div class="container psico-bar">
        <a class="psico-brand" href="${ctx}/psicologo/inicio">
            <i class="bi bi-brain fs-4"></i>
            <span>Psicometric</span>
        </a>

        <button class="psico-toggler" id="psicoToggler" type="button" aria-controls="psicoMenu" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list"></i>
        </button>

        <div class="psico-menu" id="psicoMenu">
            <ul class="psico-links">
                <li><a class="psico-link active" aria-current="page" href="${ctx}/psicologo/inicio">Inicio</a></li>
                <li><a class="psico-link" href="${ctx}/directorio">Directorio de Tests</a></li>
                <li><a class="psico-link" href="${ctx}/creartest">Crear test</a></li>
                <li><a class="psico-link" href="${ctx}/psicologo/respuestas">Respuestas</a></li>
                <li><a class="psico-link" href="#comunidad">Psic&oacute;logos y Pacientes</a></li>
                <li><a class="psico-link" href="${ctx}/info">&iquest;Qui&eacute;nes somos?</a></li>
            </ul>

            <div class="psico-actions">
                <a href="${ctx}/creartest" class="psico-btn psico-btn-primary">Crear test</a>
                <form action="${ctx}/logout" method="post" class="d-inline m-0">
                    <button type="submit" class="psico-btn ">Cerrar sesi&oacute;n</button>
                </form>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow-1">

    <header class="py-5 bg-white border-bottom">
        <div class="container py-4 text-center">

            <h1 class="display-5 fw-bold mb-3">Bienvenido, psic&oacute;logo</h1>
            <p class="lead text-muted mx-auto mb-4 texto-intro">
                Gestiona pruebas cognitivas y de personalidad, conecta con tus pacientes y visualiza m&eacute;tricas en tiempo real.
            </p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="${ctx}/creartest" class="btn btn-primary px-4 py-2 d-inline-flex align-items-center gap-2">
                    <span>Crear test</span>
                    <i class="bi bi-plus-circle"></i>
                </a>
                <a href="${ctx}/psicologo/respuestas" class="btn btn-outline-secondary px-4 py-2 d-inline-flex align-items-center gap-2">
                    <span>Ver respuestas de pacientes</span>
                    <i class="bi bi-clipboard2-data"></i>
                </a>
                <a href="${ctx}/directorio" class="btn btn-outline-secondary px-4 py-2 d-inline-flex align-items-center gap-2">
                    <span>Explorar Directorio de Tests</span>
                    <i class="bi bi-arrow-right"></i>
                </a>
            </div>
        </div>
    </header>

    <section id="destacados" class="container py-5">
        <div class="d-flex justify-content-between align-items-end mb-4">
            <div>
                <p class="text-uppercase text-muted small fw-semibold mb-1">Selecci&oacute;n Principal</p>
                <h2 class="h3 fw-bold mb-0">Tests Destacados</h2>
            </div>
            <a href="${ctx}/directorio" class="text-decoration-none fw-semibold d-inline-flex align-items-center gap-1">
                <span>Ver todos los tests</span>
                <i class="bi bi-chevron-right"></i>
            </a>
        </div>

        <div class="row g-4">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100 tema-verde card-click"
                     data-abrir-detalle
                     data-tema="tema-verde"
                     data-titulo="Test Terman-Merril"
                     data-categoria="Inteligencia y Capacidad Cognitiva (CI)"
                     data-descripcion="Evalúa el coeficiente intelectual a través de 10 subtests que miden información general, juicio, vocabulario, síntesis, concentración, análisis, abstracción, planeación, organización y atención."
                     data-detalles="Duración: 40 min | 10 series de preguntas"
                     data-url="${ctx}/test/terman-merril">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge etiqueta tema-verde">Cognitivo (CI)</span>
                            <small class="text-muted"><i class="bi bi-clock me-1"></i>40 min</small>
                        </div>
                        <h4 class="card-title fw-bold mb-2">Test Terman-Merril</h4>
                        <p class="card-text text-muted small flex-grow-1">
                            Eval&uacute;a el coeficiente intelectual y la capacidad de adaptaci&oacute;n en puestos administrativos y de gerencia.
                        </p>
                        <div class="pt-3 border-top d-flex justify-content-between align-items-center">
                            <span class="small fw-semibold">Ver detalles</span>
                            <i class="bi bi-arrow-up-right"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100 tema-verde card-click"
                     data-abrir-detalle
                     data-tema="tema-verde"
                     data-titulo="Matrices Progresivas de Raven"
                     data-categoria="Inteligencia y Capacidad Cognitiva (CI)"
                     data-descripcion="Mide la inteligencia fluida, la capacidad de educción de relaciones y el razonamiento lógico-analítico mediante figuras geométricas abstractas sin sesgo cultural."
                     data-detalles="Duración: 45 min | 60 matrices en 5 series"
                     data-url="${ctx}/test/raven">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge etiqueta tema-verde">Razonamiento</span>
                            <small class="text-muted"><i class="bi bi-clock me-1"></i>45 min</small>
                        </div>
                        <h4 class="card-title fw-bold mb-2">Matrices de Raven</h4>
                        <p class="card-text text-muted small flex-grow-1">
                            Mide la inteligencia fluida y el razonamiento l&oacute;gico-anal&iacute;tico mediante figuras geom&eacute;tricas abstractas.
                        </p>
                        <div class="pt-3 border-top d-flex justify-content-between align-items-center">
                            <span class="small fw-semibold">Ver detalles</span>
                            <i class="bi bi-arrow-up-right"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-lg-4">
                <div class="card h-100 tema-azul card-click"
                     data-abrir-detalle
                     data-tema="tema-azul"
                     data-titulo="Test de Moss"
                     data-categoria="Aptitudes y Perfil Laboral"
                     data-descripcion="Evalúa el grado de adaptabilidad social frente a distintas situaciones laborales, analizando supervisión, relaciones humanas y sentido común."
                     data-detalles="Duración: 20 min | 30 situaciones prácticas"
                     data-url="${ctx}/test/moss">
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge etiqueta tema-azul">Perfil Laboral</span>
                            <small class="text-muted"><i class="bi bi-clock me-1"></i>20 min</small>
                        </div>
                        <h4 class="card-title fw-bold mb-2">Test de Moss</h4>
                        <p class="card-text text-muted small flex-grow-1">
                            Mide la adaptabilidad social, capacidad de supervisi&oacute;n y habilidades de liderazgo en contextos laborales.
                        </p>
                        <div class="pt-3 border-top d-flex justify-content-between align-items-center">
                            <span class="small fw-semibold">Ver detalles</span>
                            <i class="bi bi-arrow-up-right"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="comunidad" class="container pb-5">
        <div class="row g-4">

            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center rounded-top-4">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-person-badge fs-4 text-primary"></i>
                            <div>
                                <h3 class="h5 fw-bold mb-0">Psic&oacute;logos Activos</h3>
                                <small class="text-muted">Especialistas disponibles para evaluaci&oacute;n</small>
                            </div>
                        </div>
                        <span class="badge etiqueta tema-azul">3 en l&iacute;nea</span>
                    </div>
                    <div class="card-body p-3">
                        <div class="vstack gap-2">

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-azul">AM</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Dra. Ana Mart&iacute;nez</h6>
                                        <small class="text-muted">Psicolog&iacute;a Organizacional &bull; C&eacute;d. 849201</small>
                                    </div>
                                </div>
                                <a href="${ctx}/psicologo/1" class="btn btn-outline-secondary btn-sm">Perfil</a>
                            </div>

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-azul">CR</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Dr. Carlos Ruiz</h6>
                                        <small class="text-muted">Neuropsicolog&iacute;a Cl&iacute;nica &bull; C&eacute;d. 592014</small>
                                    </div>
                                </div>
                                <a href="${ctx}/psicologo/2" class="btn btn-outline-secondary btn-sm">Perfil</a>
                            </div>

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-azul">LG</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Mtra. Laura G&oacute;mez</h6>
                                        <small class="text-muted">Evaluaci&oacute;n Cognitiva &bull; C&eacute;d. 710394</small>
                                    </div>
                                </div>
                                <a href="${ctx}/psicologo/3" class="btn btn-outline-secondary btn-sm">Perfil</a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center rounded-top-4">
                        <div class="d-flex align-items-center gap-2">
                            <i class="bi bi-people fs-4 text-success"></i>
                            <div>
                                <h3 class="h5 fw-bold mb-0">Pacientes Recientes</h3>
                                <small class="text-muted">&Uacute;ltimas evaluaciones asignadas</small>
                            </div>
                        </div>
                        <a href="${ctx}/pacientes" class="small text-decoration-none fw-semibold">Ver todos</a>
                    </div>
                    <div class="card-body p-3">
                        <div class="vstack gap-2">

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-verde">JP</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Juan P&eacute;rez</h6>
                                        <small class="text-muted">Test: Terman-Merril</small>
                                    </div>
                                </div>
                                <span class="badge etiqueta tema-azul">Completado</span>
                            </div>

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-verde">MS</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Mar&iacute;a S&aacute;nchez</h6>
                                        <small class="text-muted">Test: Matrices de Raven</small>
                                    </div>
                                </div>
                                <span class="badge etiqueta tema-verde">En progreso</span>
                            </div>

                            <div class="user-row p-3 d-flex align-items-center justify-content-between">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="avatar-circle tema-verde">DL</div>
                                    <div>
                                        <h6 class="mb-0 fw-semibold">Diego L&oacute;pez</h6>
                                        <small class="text-muted">Test: Test de Moss</small>
                                    </div>
                                </div>
                                <span class="badge etiqueta tema-gris">Pendiente</span>
                            </div>

                        </div>
                    </div>
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
                <a href="${ctx}/directorio" class="text-muted text-decoration-none">Directorio</a>
                <a href="${ctx}/creartest" class="text-muted text-decoration-none">Crear test</a>
                <a href="${ctx}/info" class="text-muted text-decoration-none">&iquest;Qui&eacute;nes somos?</a>
            </div>
        </div>
        <p class="mb-0 mt-3 text-center text-md-start">
            Esta plataforma es &uacute;nicamente una herramienta de apoyo; la evaluaci&oacute;n y las decisiones profesionales son responsabilidad de la psic&oacute;loga a cargo.
        </p>
    </div>
</footer>

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

<script src="/js/detalle-test.js"></script>

<script src="/js/navbar.js"></script>

</body>
</html>
