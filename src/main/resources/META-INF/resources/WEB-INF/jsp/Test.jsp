<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Psicometric | Tests</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="/styles/comun.css">
    <link rel="stylesheet" href="/styles/estilotest.css">
</head>
<body class="bg-white">

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

<div class="container my-4">
    <div class="row g-4 p-3">

        <!-- primera cartita -->
        <div class="col-auto">
            <div class="card theme-accent hover-lift card-seleccionable" style="width: 18rem;"
                 data-bs-toggle="dialog"
                 data-bs-target="#modalDetalleTest"
                 data-tema="theme-accent"
                 data-titulo="Test Terman-Merril"
                 data-categoria="Evaluación de Inteligencia y Capacidad Cognitiva (CI)"
                 data-descripcion="Evalúa el coeficiente intelectual a través de 10 subtests que miden información general, juicio, vocabulario, síntesis, concentración, análisis, abstracción, planeación, organización y atención. Es ideal para puestos administrativos, de supervisión y alta gerencia."
                 data-detalles="Duración aproximada: 40 minutos | 10 series de preguntas"
                 data-url="/test/terman-merril">
                <div class="card-header">
                    Evaluaci&oacute;n de Inteligencia y Capacidad Cognitiva (CI)
                </div>
                <div class="card-body">
                    <h4 class="card-title">Test Terman-Merril</h4>
                    <p class="card-text">Eval&uacute;a el coeficiente intelectual y la capacidad de adaptaci&oacute;n en puestos administrativos, de supervisi&oacute;n y gerencia.</p>
                    <button type="button" class="btn-solid theme-accent">Ver detalles</button>
                </div>
                <div class="card-footer fg-3">
                    2 days ago
                </div>
            </div>
        </div>

        <!-- segunda cartita -->
        <div class="col-auto">
            <div class="card theme-accent hover-lift card-seleccionable" style="width: 18rem;"
                 data-bs-toggle="dialog"
                 data-bs-target="#modalDetalleTest"
                 data-tema="theme-accent"
                 data-titulo="Test de Matrices Progresivas de Raven"
                 data-categoria="Evaluación de Inteligencia y Capacidad Cognitiva (CI)"
                 data-descripcion="Mide la inteligencia fluida, la capacidad de educción de relaciones y el razonamiento lógico-analítico mediante figuras geométricas abstractas. Al ser una prueba no verbal, elimina el sesgo educativo o cultural."
                 data-detalles="Duración aproximada: 45 minutos | 60 matrices divididas en 5 series"
                 data-url="/test/raven">
                <div class="card-header">
                    Evaluaci&oacute;n de Inteligencia y Capacidad Cognitiva (CI)
                </div>
                <div class="card-body">
                    <h4 class="card-title">Test de Matrices Progresivas de Raven</h4>
                    <p class="card-text">Mide la inteligencia fluida y la capacidad de razonamiento anal&iacute;tico sin carga cultural.</p>
                    <button type="button" class="btn-solid theme-accent">Ver detalles</button>
                </div>
                <div class="card-footer fg-3">
                    2 days ago
                </div>
            </div>
        </div>

        <!-- tercera cartita -->
        <div class="col-auto">
            <div class="card theme-primary hover-lift card-seleccionable" style="width: 18rem;"
                 data-bs-toggle="dialog"
                 data-bs-target="#modalDetalleTest"
                 data-tema="theme-primary"
                 data-titulo="Test de Moss"
                 data-categoria="Aptitudes, Habilidades y Perfil Laboral"
                 data-descripcion="Evalúa el grado de adaptabilidad social de una persona frente a distintas situaciones laborales. Analiza cinco dimensiones clave: habilidad en supervisión, capacidad de decisión en relaciones humanas, evaluación de problemas interpersonales, habilidad para establecer relaciones y sentido común."
                 data-detalles="Duración aproximada: 20 minutos | 30 situaciones prácticas"
                 data-url="/test/moss">
                <div class="card-header">
                    Aptitudes, Habilidades y Perfil Laboral
                </div>
                <div class="card-body">
                    <h4 class="card-title">Test de Moss</h4>
                    <p class="card-text">Mide la adaptabilidad social, capacidad de supervisi&oacute;n y habilidades de liderazgo en contextos gerenciales.</p>
                    <button type="button" class="btn-solid theme-primary">Ver detalles</button>
                </div>
                <div class="card-footer fg-2">
                    2 days ago
                </div>
            </div>
        </div>

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

<script src="/static/js/navbar.js"></script>

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
