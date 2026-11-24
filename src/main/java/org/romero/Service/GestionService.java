package org.romero.Service;

/** Consultas, cambios y bajas. */
public interface GestionService<E, F>
        extends ConsultaEntidadService<E>, CambioEntidadService<F>, BajaEntidadService {
}
