package org.romero.Service;

import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dao.TutorRepository;
import org.springframework.stereotype.Component;
@Component
public class CorreoUnicoValidator {

    private final PacienteRepository pacienteRepository;
    private final PsicologoRepository psicologoRepository;
    private final TutorRepository tutorRepository;

    public CorreoUnicoValidator(PacienteRepository pacienteRepository,
                                PsicologoRepository psicologoRepository,
                                TutorRepository tutorRepository) {
        this.pacienteRepository = pacienteRepository;
        this.psicologoRepository = psicologoRepository;
        this.tutorRepository = tutorRepository;
    }

    public void verificarLibre(String correo) {
        if (pacienteRepository.findByCorreoPac(correo) != null
                || psicologoRepository.findByCorreopsic(correo) != null
                || tutorRepository.findByCorreoTut(correo) != null) {
            throw new IllegalArgumentException("Ese correo ya está registrado.");
        }
    }

    /** Solo valida si el correo cambió respecto al actual. */
    public void verificarCambio(String actual, String nuevo) {
        if (actual == null || !actual.equalsIgnoreCase(nuevo)) verificarLibre(nuevo);
    }
}
