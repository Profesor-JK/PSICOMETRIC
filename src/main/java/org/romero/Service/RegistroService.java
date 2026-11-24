package org.romero.Service;

import org.romero.dto.RegistroPacienteDTO;
import org.romero.model.Paciente;

public interface RegistroService {
    /** Crea la cuenta de un paciente. Lanza IllegalArgumentException con un mensaje listo para mostrar. */
    Paciente registrarPaciente(RegistroPacienteDTO dto);
}
