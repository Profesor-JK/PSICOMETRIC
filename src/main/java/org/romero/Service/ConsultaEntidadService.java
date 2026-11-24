package org.romero.Service;

import java.util.List;

public interface ConsultaEntidadService<E> {
    /** @param filtro texto a buscar; vacío o null = todos */
    List<E> consultar(String filtro);

    /** @throws IllegalArgumentException si no existe */
    E obtener(Integer id);
}
