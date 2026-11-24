package org.romero.Service;

public interface CambioEntidadService<F> {
    /** @throws IllegalArgumentException si los datos no son válidos o no existe */
    void cambio(Integer id, F form);
}
