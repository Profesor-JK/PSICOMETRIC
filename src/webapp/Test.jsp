<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menu Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-B/GM4XqrwHnWXNOWMbloTmrYXZg10cakYGmpfsR/bbzQ6JAJI4ihuyADKLnBgrCe" crossorigin="anonymous">
    <script type="module" src="https://cdn.jsdelivr.net/npm/bootstrap@6.0.0-alpha.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-1a/pXj49ZQ1aHEmrJ+gMw1otqoVsYwlEnlD8mIfY2TV03r20Y0CN7uqx1tQogjPL" crossorigin="anonymous"></script>
</head>
<body class="p-3 mb-2 bg-black fg-white min-vh-100">
<nav class="navbar" data-bs-theme="white">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Psicometric</a>
    <ul class="navbar-nav">
      <li class="nav-item" data-bs-theme="dark">
        <button class="btn-solid theme-secondary" data-bs-toggle="menu" aria-expanded="false">
          Menu
        </button>
        <div class="menu">
          <a class="menu-item" href="index.jsp">Men&uacute Principal</a>
          <a class="menu-item" href="login.jsp">Iniciar sesi&oacuten</a>
          <a class="menu-item" href="#"></a>
        </div>
      </li>
    </ul>
  </div>
</nav>
<br>

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
   <script src="https://jsdelivr.net"></script>
</body>
</html>
