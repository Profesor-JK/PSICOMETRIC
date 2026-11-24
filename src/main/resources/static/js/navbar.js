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

// Menús desplegables (moderador): se abren al hacer clic y se cierran al hacer clic fuera.
document.addEventListener('DOMContentLoaded', function () {
  const menus = document.querySelectorAll('.psico-dropdown');
  if (!menus.length) return;

  menus.forEach(function (menu) {
    const toggle = menu.querySelector('.psico-dropdown-toggle');
    toggle.addEventListener('click', function (e) {
      e.preventDefault();
      const abrir = !menu.classList.contains('open');
      menus.forEach(function (m) { m.classList.remove('open'); });
      menu.classList.toggle('open', abrir);
      toggle.setAttribute('aria-expanded', abrir);
    });
  });

  document.addEventListener('click', function (e) {
    if (!e.target.closest('.psico-dropdown')) {
      menus.forEach(function (m) { m.classList.remove('open'); });
    }
  });
});
