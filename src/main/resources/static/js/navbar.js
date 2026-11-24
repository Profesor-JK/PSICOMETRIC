document.addEventListener('DOMContentLoaded', function () {
  const boton = document.getElementById('psicoToggler');
  const menu = document.getElementById('psicoMenu');
  const desplegables = document.querySelectorAll('.psico-dropdown');
  if (boton && menu) {
    boton.addEventListener('click', function () {
      boton.setAttribute('aria-expanded', menu.classList.toggle('open'));
    });
  }
  desplegables.forEach(function (item) {
    const enlace = item.querySelector('.psico-dropdown-toggle');
    enlace.addEventListener('click', function (e) {
      e.preventDefault();
      const abrir = !item.classList.contains('open');
      desplegables.forEach(function (otro) { otro.classList.remove('open'); });
      item.classList.toggle('open', abrir);
      enlace.setAttribute('aria-expanded', abrir);
    });
  });

  document.addEventListener('click', function (e) {
    if (!e.target.closest('.psico-dropdown')) {
      desplegables.forEach(function (item) { item.classList.remove('open'); });
    }
  });
});
