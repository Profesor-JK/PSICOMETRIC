(function () {
  const ventana = document.getElementById('modalDetalleTest');
  if (!ventana) return;

  const poner = (id, texto) => { document.getElementById(id).textContent = texto || ''; };

  document.addEventListener('click', function (e) {
    const tarjeta = e.target.closest('[data-abrir-detalle]');

    if (tarjeta) {
      const d = tarjeta.dataset;
      poner('modalTitulo', d.titulo);
      poner('modalCategoria', d.categoria);
      poner('modalDescripcion', d.descripcion);
      poner('modalDetalles', d.detalles);

      const boton = document.getElementById('modalBtnIniciar');
      boton.href = d.url || '#';
      if (d.boton) boton.textContent = d.boton;

      ventana.className = 'detalle ' + (d.tema || 'tema-azul');
      ventana.showModal();
      return;
    }
    if (e.target.closest('[data-cerrar]') || e.target === ventana) ventana.close();
  });
})();
