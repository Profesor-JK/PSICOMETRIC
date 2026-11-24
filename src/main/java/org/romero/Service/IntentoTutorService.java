package org.romero.Service;

import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;

import java.util.List;

/** Actividad (tests contestados) de los pacientes a cargo de un tutor. */
public interface IntentoTutorService {

    List<IntentoResumenDTO> listarActividad(Integer idTutor);

    /** @throws IllegalArgumentException si el intento no existe o no es de un paciente del tutor */
    IntentoDetalleDTO obtenerDetalle(Integer idTutor, Integer idIntento);
}
