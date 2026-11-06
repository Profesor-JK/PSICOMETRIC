<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menu Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>
</head>
<body class="bg-white">
<!-- Barra de Navegacion --!>
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

<!-- Contenedor principal que agrupa las cartas -->
<div class="row g-4 p-3">

    <!-- Primera Carta (Terman-Merril) -->
    <div class="col-auto">
        <div class="card theme-accent" style="width: 18rem;">
            <div class="card-header">
                Evaluaci&oacuten de Inteligencia y Capacidad Cognitiva (CI)
            </div>
            <div class="card-body">
                <h4 class="card-title">Test Terman-Merril </h4>
                <p class="card-text">Eval&uacute;a el coeficiente intelectual y la capacidad de adaptaci&oacute;n en puestos administrativos, de supervisi&oacute;n y gerencia.</p>
                <a href="#" class="btn-solid theme-primary">Ir a test</a>
            </div>
            <div class="card-footer text-muted">
                2 days ago
            </div>
        </div>
    </div>

    <!-- Segunda Carta (Raven) -->
    <div class="col-auto">
        <div class="card theme-accent" style="width: 18rem;">
            <div class="card-header">
                Evaluaci&oacuten de Inteligencia y Capacidad Cognitiva (CI)
            </div>
            <div class="card-body">
                <h4 class="card-title">Test de Matrices Progresivas de Raven</h4>
                <p class="card-text">Mide la inteligencia fluida y la capacidad de razonamiento anal&aacutegico sin carga cultural.</p>
                <a href="#" class="btn-solid theme-primary">Ir a test</a>
            </div>
            <div class="card-footer text-muted">
                2 days ago
            </div>
        </div>
    </div>

     <!-- Tercera Carta (Moss) --!>
         <div class="col-auto">
             <div class="card theme-primary" style="width: 18rem;">
                 <div class="card-header">
                    Aptitudes, Habilidades y Perfil Laboral
                 </div>
                 <div class="card-body">
                     <h4 class="card-title">Test de Moss</h4>
                     <p class="card-text">Mide la adaptabilidad social, capacidad de supervisi&oacuten y habilidades de liderazgo en contextos gerenciales.</p>
                     <a href="#" class="btn-solid theme-primary">Ir a test</a>
                 </div>
                 <div class="card-footer fg-2">
                     2 days ago
                 </div>
             </div>
         </div>



    </div>

 </div>

</body>
</html>
