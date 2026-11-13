<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>
<style>
body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f8fafc;
            overflow-x: hidden;
        }

        /* Animación de entrada suave */
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

        /* Efecto hover en tarjetas */
        .card-hover {
            cursor: pointer;
            transition: transform 0.28s cubic-bezier(0.22, 1, 0.36, 1), box-shadow 0.28s ease;
            border: 1px solid rgba(0, 0, 0, 0.06);
        }

        .card-hover:hover {
            transform: translateY(-6px);
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.08);
        }

        /* Efecto hover en listas de usuarios */
        .user-row {
            transition: background-color 0.2s ease, transform 0.2s ease;
            border-radius: 0.75rem;
        }

        .user-row:hover {
            background-color: #f1f5f9;
            transform: translateX(4px);
        }

        /* Avatares circulares */
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

        /* Subrayado minimalista en el menú */
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

        .card-seleccionable {
            cursor: pointer;
        }
    </style>
</head>
<body class="bg-white">

<<nav class="navbar md:navbar-expand bg-1 sticky-top shadow-sm" data-bs-theme="dark">
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

<!-- Contenedor principal que agrupa las cartas -->
<div class="row g-4 p-3">

    <!-- Primera Carta (Terman-Merril) -->
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

    <!-- Segunda Carta (Raven) -->
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


     <!-- Tercera Carta (Moss) --!>
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


    </div>
 </div>
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