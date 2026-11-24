package org.romero.Service.impl;

import org.romero.Service.CorreoUnicoValidator;
import org.romero.Service.GestionConAltaService;
import org.romero.Service.Validaciones;
import org.romero.dao.ConsultaRepository;
import org.romero.dao.PacienteRepository;
import org.romero.dao.TutorRepository;
import org.romero.dto.TutorAdminDTO;
import org.romero.model.Consulta;
import org.romero.model.Paciente;
import org.romero.model.Tutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;

@Service
public class GestionTutorServiceImpl implements GestionConAltaService<Tutor, TutorAdminDTO> {

    private final TutorRepository tutorRepository;
    private final PacienteRepository pacienteRepository;
    private final ConsultaRepository consultaRepository;
    private final CorreoUnicoValidator correos;

    public GestionTutorServiceImpl(TutorRepository tutorRepository,
                                   PacienteRepository pacienteRepository,
                                   ConsultaRepository consultaRepository,
                                   CorreoUnicoValidator correos) {
        this.tutorRepository = tutorRepository;
        this.pacienteRepository = pacienteRepository;
        this.consultaRepository = consultaRepository;
        this.correos = correos;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Tutor> consultar(String filtro) {
        return tutorRepository.findAll().stream()
                .filter(t -> Validaciones.coincide(filtro, t.getNombreTut(), t.getApellidosTut(), t.getCorreoTut()))
                .sorted(Comparator.comparing(Tutor::getNombreTut, String.CASE_INSENSITIVE_ORDER))
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public Tutor obtener(Integer id) {
        return tutorRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos a ese tutor."));
    }

    @Override
    @Transactional
    public void alta(TutorAdminDTO form) {
        Tutor t = new Tutor();
        llenar(t, form, true);
        correos.verificarLibre(t.getCorreoTut());
        tutorRepository.save(t);
    }

    @Override
    @Transactional
    public void cambio(Integer id, TutorAdminDTO form) {
        Tutor t = obtener(id);
        String correoActual = t.getCorreoTut();
        llenar(t, form, false);
        correos.verificarCambio(correoActual, t.getCorreoTut());
        tutorRepository.save(t);
    }

    @Override
    @Transactional
    public void baja(Integer id) {
        obtener(id);
        // Los pacientes y consultas no se borran: solo pierden al tutor.
        for (Paciente p : pacienteRepository.findByIdTutor(id)) {
            p.setIdTutor(null);
            pacienteRepository.save(p);
        }
        for (Consulta c : consultaRepository.findByIdTutor(id)) {
            c.setIdTutor(null);
            consultaRepository.save(c);
        }
        pacienteRepository.flush();
        tutorRepository.deleteById(id);
    }

    private void llenar(Tutor t, TutorAdminDTO f, boolean nuevo) {
        t.setNombreTut(Validaciones.requerido(f.nombre(), "El nombre", 50));
        t.setApellidosTut(Validaciones.requerido(f.apellidos(), "Los apellidos", 60));
        t.setFechaNacTutor(Validaciones.fecha(f.fechaNac(), "La fecha de nacimiento"));
        t.setCorreoTut(Validaciones.correo(f.correo()));
        String contra = Validaciones.contrasena(f.contrasena(), nuevo);
        if (contra != null) t.setContraTut(contra);
    }
}
