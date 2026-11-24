package org.romero.Service;

import org.romero.dto.RegistroPacienteDTO;
import org.romero.model.Paciente;

public interface RegistroService {
    Paciente registrarPaciente(RegistroPacienteDTO dto);
}
