package org.romero.Service;

import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;
import org.romero.model.Intento;

import java.util.List;

public interface IntentoMapper {
    List<IntentoResumenDTO> aResumenes(List<Intento> intentos);
    IntentoDetalleDTO aDetalle(Intento intento);
}
