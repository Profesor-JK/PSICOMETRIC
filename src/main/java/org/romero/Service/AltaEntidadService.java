package org.romero.Service;

public interface AltaEntidadService<F> {
    /** @throws IllegalArgumentException si los datos no son válidos */
    void alta(F form);
}
