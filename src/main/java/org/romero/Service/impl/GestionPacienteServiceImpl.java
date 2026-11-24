package org.romero.Service.impl;

import org.romero.Service.CorreoUnicoValidator;
import org.romero.Service.EliminadorTest;
import org.romero.Service.GestionConAltaService;
import org.romero.Service.Validaciones;
import org.romero.dao.ConsultaRepository;
import org.romero.dao.IntentoRepository;
import org.romero.dao.PacienteRepository;
import org.romero.dao.TestRepository;
import org.romero.dao.TutorRepository;
import org.romero.dto.PacienteAdminDTO;
import org.romero.model.Paciente;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;

@Service
public class GestionPacienteServiceImpl implements GestionConAltaService<Paciente, PacienteAdminDTO> {

    private final PacienteRepository pacienteRepository;
    private final TutorRepository tutorRepository;
    private final TestRepository testRepository;
    private final IntentoRepository intentoRepository;
    private final ConsultaRepository consultaRepository;
    private final EliminadorTest eliminadorTest;
    private final CorreoUnicoValidator correos;

    public GestionPacienteServiceImpl(PacienteRepository pacienteRepository,
                                      TutorRepository tutorRepository,
                                      TestRepository testRepository,
                                      IntentoRepository intentoRepository,
                                      ConsultaRepository consultaRepository,
                                      EliminadorTest eliminadorTest,
                                      CorreoUnicoValidator correos) {
        this.pacienteRepository = pacienteRepository;
        this.tutorRepository = tutorRepository;
        this.testRepository = testRepository;
        this.intentoRepository = intentoRepository;
        this.consultaRepository = consultaRepository;
        this.eliminadorTest = eliminadorTest;
        this.correos = correos;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Paciente> consultar(String filtro) {
        return pacienteRepository.findAll().stream()
                .filter(p -> Validaciones.coincide(filtro, p.getNombrePac(), p.getApellidosPac(), p.getCorreoPac()))
                .sorted(Comparator.comparing(Paciente::getNombrePac, String.CASE_INSENSITIVE_ORDER))
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public Paciente obtener(Integer id) {
        return pacienteRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos a ese paciente."));
    }

    @Override
    @Transactional
    public void alta(PacienteAdminDTO form) {
        Paciente p = new Paciente();
        llenar(p, form, true);
        correos.verificarLibre(p.getCorreoPac());
        pacienteRepository.save(p);
    }

    @Override
    @Transactional
    public void cambio(Integer id, PacienteAdminDTO form) {
        Paciente p = obtener(id);
        String correoActual = p.getCorreoPac();
        llenar(p, form, false);
        correos.verificarCambio(correoActual, p.getCorreoPac());
        pacienteRepository.save(p);
    }

    @Override
    @Transactional
    public void baja(Integer id) {
        obtener(id);
        for (Test t : testRepository.findByIdPacienteExclusivo(id)) {
            eliminadorTest.eliminarConDependencias(t.getIdTest());
        }
        intentoRepository.deleteByIdPaciente(id);
        consultaRepository.deleteByIdPaciente(id);
        intentoRepository.flush();
        pacienteRepository.deleteById(id);
    }

    private void llenar(Paciente p, PacienteAdminDTO f, boolean nuevo) {
        p.setNombrePac(Validaciones.requerido(f.nombre(), "El nombre", 45));
        p.setApellidosPac(Validaciones.requerido(f.apellidos(), "Los apellidos", 50));
        p.setFechaNacPac(Validaciones.fecha(f.fechaNac(), "La fecha de nacimiento"));
        p.setGeneroPsc(Validaciones.genero(f.genero()));
        p.setCorreoPac(Validaciones.correo(f.correo()));
        String contra = Validaciones.contrasena(f.contrasena(), nuevo);
        if (contra != null) p.setContraPac(contra);

        Integer idTutor = Validaciones.enteroOpcional(f.idTutor(), "El tutor");
        if (idTutor != null && !tutorRepository.existsById(idTutor)) {
            throw new IllegalArgumentException("El tutor elegido no existe.");
        }
        p.setIdTutor(idTutor);
    }
}
