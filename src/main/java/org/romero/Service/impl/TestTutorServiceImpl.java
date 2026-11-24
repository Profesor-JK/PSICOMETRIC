package org.romero.Service.impl;

import org.romero.Service.TestTutorService;
import org.romero.dao.IntentoRepository;
import org.romero.dao.PacienteRepository;
import org.romero.dao.TestRepository;
import org.romero.dto.TestTutorDTO;
import org.romero.model.Paciente;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class TestTutorServiceImpl implements TestTutorService {

    private final PacienteRepository pacienteRepository;
    private final TestRepository testRepository;
    private final IntentoRepository intentoRepository;

    public TestTutorServiceImpl(PacienteRepository pacienteRepository,
                                TestRepository testRepository,
                                IntentoRepository intentoRepository) {
        this.pacienteRepository = pacienteRepository;
        this.testRepository = testRepository;
        this.intentoRepository = intentoRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<TestTutorDTO> listarTests(Integer idTutor) {
        List<TestTutorDTO> resultado = new ArrayList<>();
        for (Paciente p : pacienteRepository.findByIdTutor(idTutor)) {
            String nombre = (p.getNombrePac() + " " + p.getApellidosPac()).trim();
            for (Test t : testRepository.findDisponiblesParaPaciente(p.getIdPaciente())) {
                resultado.add(new TestTutorDTO(
                        t.getIdTest(), t.getNombre(), t.getCategoria(), t.getDuracionMin(),
                        t.esExclusivo(), p.getIdPaciente(), nombre,
                        intentoRepository.countByIdPacienteAndTest_IdTest(p.getIdPaciente(), t.getIdTest())));
            }
        }
        return resultado;
    }
}
