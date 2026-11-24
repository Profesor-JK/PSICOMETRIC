package org.romero.Service;

import org.romero.dto.IntentoResumenDTO;

import java.util.List;

public interface IntentoPacienteService {
    List<IntentoResumenDTO> listarIntentos(Integer idPaciente);
}
