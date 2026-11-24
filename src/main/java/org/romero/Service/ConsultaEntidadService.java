package org.romero.Service;

import java.util.List;

public interface ConsultaEntidadService<E> {
    List<E> consultar(String filtro);

    /** @throws IllegalArgumentException si no existe */
    E obtener(Integer id);
}
