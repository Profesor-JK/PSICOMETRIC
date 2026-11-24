package org.romero.Service;

import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;
import org.romero.dto.TestFiltroDTO;

import java.util.List;

public interface IntentoPsicologoService {
    List<IntentoResumenDTO> listarIntentos(Integer cedulaPsicologo, Integer idTest);

    /** @throws IllegalArgumentException  */
    IntentoDetalleDTO obtenerDetalle(Integer cedulaPsicologo, Integer idIntento);

    List<TestFiltroDTO> listarTests(Integer cedulaPsicologo);
}
