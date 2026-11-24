package org.romero.Service.impl;

import org.romero.Service.TutorService;
import org.romero.dao.TutorRepository;
import org.romero.model.Tutor;
import org.springframework.stereotype.Service;

@Service
public class TutorServiceImpl implements TutorService {

    private final TutorRepository tutorRepository;

    public TutorServiceImpl(TutorRepository tutorRepository) {
        this.tutorRepository = tutorRepository;
    }

    @Override
    public Tutor obtenerPorCorreo(String correo) {
        return tutorRepository.findByCorreoTut(correo);
    }
}
