<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Psicometric | Inicio</title>

    <!-- Bootstrap 6 Alpha & Iconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>

    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8fafc;
            overflow-x: hidden;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .animate-fade-up {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .delay-1 { animation-delay: 0.1s; opacity: 0; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; }

        .card-hover {
            cursor: pointer;
            transition: transform 0.28s cubic-bezier(0.22, 1, 0.36, 1), box-shadow 0.28s ease;
            border: 1px solid rgba(0, 0, 0, 0.06);
        }

        .card-hover:hover {
            transform: translateY(-6px);
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.08);
        }

        .user-row {
            transition: background-color 0.2s ease, transform 0.2s ease;
            border-radius: 0.75rem;
        }

        .user-row:hover {
            background-color: #f1f5f9;
            transform: translateX(4px);
        }

        .avatar-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.95rem;
            flex-shrink: 0;
        }

        .nav-minimal {
            position: relative;
            font-weight: 500;
        }

        .nav-minimal::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 4px;
            left: 50%;
            background-color: currentColor;
            transition: width 0.25s ease, left 0.25s ease;
        }

        .nav-minimal:hover::after {
            width: 80%;
            left: 10%;
        }
    </style>
</head>
<body>

<nav class="navbar md:navbar-expand bg-1 sticky-top shadow-sm" data-bs-theme="dark">
  <div class="container py-1">
    <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="/">
      <i class="bi bi-brain fs-4"></i>
      <span>Psicometric</span>
    </a>

    <button class="btn-icon navbar-toggler" type="button" data-bs-toggle="drawer" data-bs-target="#navbarDarkDrawer" aria-controls="navbarDarkDrawer" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon" aria-hidden="true"></span>
    </button>

    <dialog class="drawer drawer-end" tabindex="-1" id="navbarDarkDrawer" aria-labelledby="navbarDarkDrawerLabel">
      <div class="drawer-header">
        <h5 class="drawer-title" id="navbarDarkDrawerLabel">Psicometric</h5>
        <button type="button" class="btn-close" data-bs-dismiss="drawer" aria-label="Close"></button>
      </div>

      <div class="drawer-body d-flex flex-column flex-md-row align-items-md-center justify-content-between w-100 gap-3">
        <!-- Enlaces centrales minimalistas -->
        <ul class="nav navbar-nav mx-md-auto gap-md-3">
          <li class="nav-item">
            <a class="nav-link nav-minimal active" aria-current="page" href="/">Inicio</a>
          </li>
          <li class="nav-item">
            <a class="nav-link nav-minimal" href="/directorio">Directorio de Tests</a>
          </li>
          <li class="nav-item">
            <a class="nav-link nav-minimal" href="#comunidad">Psic&oacute;logos y Pacientes</a>
          </li>
        </ul>

        <div class="hstack gap-2">
          <a href="/login" class="btn-outline btn-sm">Iniciar Sesi&oacute;n</a>
          <a href="/registro" class="btn-solid theme-primary btn-sm">Crear Cuenta</a>
        </div>
      </div>
    </dialog>
  </div>
</nav>

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
    <a href="/test" class="text-decoration-none fw-semibold d-inline-flex align-items-center gap-1">
      <span>Ver todos los tests</span>
      <i class="bi bi-chevron-right"></i>
    </a>
  </div>

  <div class="row g-4">
    <div class="col-12 col-md-6 col-lg-4 animate-fade-up delay-1">
      <div class="card h-100 theme-accent card-hover rounded-4"
           data-bs-toggle="dialog"
           data-bs-target="#modalDetalleTest"
           data-tema="theme-accent"
           data-titulo="Test Terman-Merril"
           data-categoria="Inteligencia y Capacidad Cognitiva (CI)"
           data-descripcion="Evalúa el coeficiente intelectual a través de 10 subtests que miden información general, juicio, vocabulario, síntesis, concentración, análisis, abstracción, planeación, organización y atención."
           data-detalles="Duración: 40 min | 10 series de preguntas"
           data-url="/test/terman-merril">
        <div class="card-body p-4 d-flex flex-column">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="badge theme-subtle theme-accent">Cognitivo (CI)</span>
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

    <div class="col-12 col-md-6 col-lg-4 animate-fade-up delay-2">
      <div class="card h-100 theme-accent card-hover rounded-4"
           data-bs-toggle="dialog"
           data-bs-target="#modalDetalleTest"
           data-tema="theme-accent"
           data-titulo="Matrices Progresivas de Raven"
           data-categoria="Inteligencia y Capacidad Cognitiva (CI)"
           data-descripcion="Mide la inteligencia fluida, la capacidad de educción de relaciones y el razonamiento lógico-analítico mediante figuras geométricas abstractas sin sesgo cultural."
           data-detalles="Duración: 45 min | 60 matrices en 5 series"
           data-url="/test/raven">
        <div class="card-body p-4 d-flex flex-column">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="badge theme-subtle theme-accent">Razonamiento</span>
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

    <div class="col-12 col-md-6 col-lg-4 animate-fade-up delay-3">
      <div class="card h-100 theme-primary card-hover rounded-4"
           data-bs-toggle="dialog"
           data-bs-target="#modalDetalleTest"
           data-tema="theme-primary"
           data-titulo="Test de Moss"
           data-categoria="Aptitudes y Perfil Laboral"
           data-descripcion="Evalúa el grado de adaptabilidad social frente a distintas situaciones laborales, analizando supervisión, relaciones humanas y sentido común."
           data-detalles="Duración: 20 min | 30 situaciones prácticas"
           data-url="/test/moss">
        <div class="card-body p-4 d-flex flex-column">
          <div class="d-flex justify-content-between align-items-center mb-3">
            <span class="badge theme-subtle theme-primary">Perfil Laboral</span>
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

    <div class="col-12 col-lg-6 animate-fade-up delay-2">
      <div class="card border-0 shadow-sm rounded-4 h-100">
        <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center rounded-top-4">
          <div class="d-flex align-items-center gap-2">
            <i class="bi bi-person-badge fs-4 text-primary"></i>
            <div>
              <h3 class="h5 fw-bold mb-0">Psic&oacute;logos Activos</h3>
              <small class="text-muted">Especialistas disponibles para evaluaci&oacute;n</small>
            </div>
          </div>
          <span class="badge theme-subtle theme-primary">3 en l&iacute;nea</span>
        </div>
        <div class="card-body p-3">
          <div class="vstack gap-2">

            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-primary">AM</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Dra. Ana Mart&iacute;nez</h6>
                  <small class="text-muted">Psicolog&iacute;a Organizacional &bull; C&eacute;d. 849201</small>
                </div>
              </div>
              <a href="/psicologo/1" class="btn-outline btn-sm">Perfil</a>
            </div>

            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-primary">CR</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Dr. Carlos Ruiz</h6>
                  <small class="text-muted">Neuropsicolog&iacute;a Cl&iacute;nica &bull; C&eacute;d. 592014</small>
                </div>
              </div>
              <a href="/psicologo/2" class="btn-outline btn-sm">Perfil</a>
            </div>

            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-primary">LG</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Mtra. Laura G&oacute;mez</h6>
                  <small class="text-muted">Evaluaci&oacute;n Cognitiva &bull; C&eacute;d. 710394</small>
                </div>
              </div>
              <a href="/psicologo/3" class="btn-outline btn-sm">Perfil</a>
            </div>

          </div>
        </div>
      </div>
    </div>

    <div class="col-12 col-lg-6 animate-fade-up delay-3">
      <div class="card border-0 shadow-sm rounded-4 h-100">
        <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center rounded-top-4">
          <div class="d-flex align-items-center gap-2">
            <i class="bi bi-people fs-4 text-success"></i>
            <div>
              <h3 class="h5 fw-bold mb-0">Pacientes Recientes</h3>
              <small class="text-muted">&Uacute;ltimas evaluaciones asignadas</small>
            </div>
          </div>
          <a href="/pacientes" class="small text-decoration-none fw-semibold">Ver todos</a>
        </div>
        <div class="card-body p-3">
          <div class="vstack gap-2">


            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-accent">JP</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Juan P&eacute;rez</h6>
                  <small class="text-muted">Test: Terman-Merril</small>
                </div>
              </div>
              <span class="badge theme-subtle theme-primary">Completado</span>
            </div>

            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-accent">MS</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Mar&iacute;a S&aacute;nchez</h6>
                  <small class="text-muted">Test: Matrices de Raven</small>
                </div>
              </div>
              <span class="badge theme-subtle theme-accent">En progreso</span>
            </div>

            <div class="user-row p-3 d-flex align-items-center justify-content-between">
              <div class="d-flex align-items-center gap-3">
                <div class="avatar-circle theme-subtle theme-accent">DL</div>
                <div>
                  <h6 class="mb-0 fw-semibold">Diego L&oacute;pez</h6>
                  <small class="text-muted">Test: Test de Moss</small>
                </div>
              </div>
              <span class="badge theme-subtle theme-secondary">Pendiente</span>
            </div>

          </div>
        </div>
      </div>
    </div>

  </div>
</section>

<footer class="bg-white border-top py-4 mt-auto">
  <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center text-muted small gap-2">
    <span>&copy; 2026 Psicometric. Todos los derechos reservados.</span>
    <div class="hstack gap-3">
      <a href="/directorio" class="text-muted text-decoration-none">Directorio</a>
      <a href="/info" class="text-muted text-decoration-none">&iquest;Qui&eacute;nes somos?</a>
    </div>
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