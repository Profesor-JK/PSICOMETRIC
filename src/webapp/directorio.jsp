<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>
</head>
<body class="bg-white">
<nav class="navbar md:navbar-expand bg-1" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Psicometric</a>
    <button class="btn-icon navbar-toggler" type="button" data-bs-toggle="drawer" data-bs-target="#navbarDarkDrawer" aria-controls="navbarDarkDrawer" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon" aria-hidden="true"></span>
    </button>
    <dialog class="drawer drawer-end" tabindex="-1" id="navbarDarkDrawer" aria-labelledby="navbarDarkDrawerLabel">
      <div class="drawer-header">
        <h5 class="drawer-title" id="navbarDarkDrawerLabel">Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="drawer" aria-label="Close"></button>
      </div>
      <div class="drawer-body mb-2 md:mb-0">
        <ul class="nav navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Test.jsp">Tests</a>
          </li>
          <li class="nav-item">
            <button class="nav-link" type="button" data-bs-toggle="menu" aria-expanded="false">
              Menu
            </button>
            <div class="menu">
              <a class="menu-item" href="login.jsp">Iniciar Sesi&oacute;n</a>
              <a class="menu-item" href="info.jsp">&iquest;Quien&eacutes somos?</a>
              <a class="menu-item" href="directorio.jsp">Nuestros tests</a>
              <hr class="menu-divider">
              <a class="menu-item" href="registro.jsp">Crear Cuenta</a>
            </div>
          </li>
        </ul>
        <form class="hstack gap-2" role="search">
          <input class="form-control" type="search" placeholder="Search" aria-label="Search"/>
          <button class="btn-solid btn-icon theme-secondary" type="submit">
            <svg class="bi" width="16" height="16"><use href="#search" /></svg>
          </button>
        </form>
      </div>
    </dialog>
  </div>
</nav>

<!-- Directorio de tests --!>

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
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Moss</span>
            <span class="badge bg-primary text-white rounded-pill">15 min</span>
          </a>
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>XXXX-XXXX-XXXX</span>
            <span class="badge bg-primary text-white rounded-pill">20 min</span>
          </a>
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
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
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Terman-Merril</span>
            <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">25 min</span>
          </a>
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span>Test de Matrices Progresivas de Raven</span>
            <span class="badge text-white rounded-pill" style="background-color: #6f42c1;">15 min</span>
          </a>
          <a href="Test.jsp" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
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
