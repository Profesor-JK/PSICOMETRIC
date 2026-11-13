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
        </style>
</head>
<body class="bg-white">
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


<div class="accordion" id="accordionTests">

  <!-- CATEGORÍA 1: Laboral (Azul) -->
  <div class="accordion-item border-primary-subtle">
    <h2 class="accordion-header" id="headingUno">
      <button class="accordion-button fw-bold bg-primary-subtle text-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUno" aria-expanded="true" aria-controls="collapseUno">
        Aptitudes, Habilidades y Perfil Laboral
      </button>
    </h2>
    <div id="collapseUno" class="accordion-collapse collapse show" aria-labelledby="headingUno" data-bs-parent="#accordionTests">
      <div class="accordion-body p-0">
        <div class="list-group list-group-flush">
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Moss</span>
            <span class="badge bg-primary text-white rounded-pill">15 min</span>
          </a>
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>XXXX-XXXX-XXXX</span>
            <span class="badge bg-primary text-white rounded-pill">20 min</span>
          </a>
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>XXXX-XXXX-XXXX</span>
            <span class="badge bg-primary text-white rounded-pill">10 min</span>
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- CATEGORÍA 2: Inteligencia y Capacidad Cognitiva (Morado) -->
  <div class="accordion-item" style="border-color: #e8dbf8;">
    <h2 class="accordion-header" id="headingDos">
      <button class="accordion-button collapsed fw-bold text-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDos" aria-expanded="false" aria-controls="collapseDos" style="--bs-accordion-active-bg: #f3ebfd; --bs-accordion-active-color: #6f42c1; --bs-accordion-btn-focus-box-shadow: 0 0 0 0.25rem rgba(111, 66, 193, 0.25);">
        Evaluación de Inteligencia y Capacidad Cognitiva (CI)
      </button>
    </h2>
    <div id="collapseDos" class="accordion-collapse collapse" aria-labelledby="headingDos" data-bs-parent="#accordionTests">
      <div class="accordion-body p-0">
        <div class="list-group list-group-flush">
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Terman-Merril</span>
            <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">25 min</span>
          </a>
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Matrices Progresivas de Raven</span>
            <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">15 min</span>
          </a>
          <a href="/test" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>XXXX-XXXX-XXXX</span>
            <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">30 min</span>
          </a>
        </div>
      </div>
    </div>
  </div>

</div>



 </div>

</body>
</html>