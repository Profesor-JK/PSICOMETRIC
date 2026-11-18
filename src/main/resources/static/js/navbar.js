// navbar.js -> abre / cierra el menú de la barra de navegación en móvil
document.addEventListener('DOMContentLoaded', function () {
  const toggler = document.getElementById('psicoToggler');
  const menu = document.getElementById('psicoMenu');
  if (!toggler || !menu) return;

  toggler.addEventListener('click', function () {
    const abierto = menu.classList.toggle('open');
    toggler.setAttribute('aria-expanded', abierto);
  });
});
