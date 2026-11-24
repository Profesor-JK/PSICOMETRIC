package org.romero.Service.impl;

import org.romero.Service.EliminadorTest;
import org.romero.Service.GestionService;
import org.romero.Service.Validaciones;
import org.romero.dao.IntentoRepository;
import org.romero.dao.PacienteRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dao.TestRepository;
import org.romero.dto.TestAdminDTO;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;

/** Consulta, cambio y baja de tests. El alta se hace con el constructor de tests (preguntas y resultados). */
@Service
public class GestionTestServiceImpl implements GestionService<Test, TestAdminDTO>, EliminadorTest {

    private final TestRepository testRepository;
    private final IntentoRepository intentoRepository;
    private final PsicologoRepository psicologoRepository;
    private final PacienteRepository pacienteRepository;

    public GestionTestServiceImpl(TestRepository testRepository,
                                  IntentoRepository intentoRepository,
                                  PsicologoRepository psicologoRepository,
                                  PacienteRepository pacienteRepository) {
        this.testRepository = testRepository;
        this.intentoRepository = intentoRepository;
        this.psicologoRepository = psicologoRepository;
        this.pacienteRepository = pacienteRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Test> consultar(String filtro) {
        return testRepository.findAll().stream()
                .filter(t -> Validaciones.coincide(filtro, t.getNombre(), t.getCategoria()))
                .sorted(Comparator.comparing(Test::getNombre, String.CASE_INSENSITIVE_ORDER))
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public Test obtener(Integer id) {
        return testRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos ese test."));
    }

    @Override
    @Transactional
    public void cambio(Integer id, TestAdminDTO form) {
        Test t = obtener(id);

        t.setNombre(Validaciones.requerido(form.nombre(), "El nombre", 150));
        t.setCategoria(Validaciones.opcional(form.categoria(), "La categoría", 150));
        t.setDescripcion(Validaciones.opcional(form.descripcion(), "La descripción", 2000));
        t.setInstrucciones(Validaciones.opcional(form.instrucciones(), "Las instrucciones", 2000));
        t.setDuracionMin(Validaciones.enteroOpcional(form.duracionMin(), "La duración"));
        t.setActivo("true".equals(Validaciones.limpiar(form.activo())));

        Integer cedula = Validaciones.entero(form.cedula(), "El psicólogo");
        if (!psicologoRepository.existsById(cedula)) {
            throw new IllegalArgumentException("El psicólogo elegido no existe.");
        }
        t.setCedula(cedula);

        Integer idPaciente = Validaciones.enteroOpcional(form.idPacienteExclusivo(), "El paciente");
        if (idPaciente != null && !pacienteRepository.existsById(idPaciente)) {
            throw new IllegalArgumentException("El paciente elegido no existe.");
        }
        t.setIdPacienteExclusivo(idPaciente);

        testRepository.save(t);
    }

    @Override
    @Transactional
    public void baja(Integer id) {
        obtener(id);
        eliminarConDependencias(id);
    }

    @Override
    @Transactional
    public void eliminarConDependencias(Integer idTest) {
        intentoRepository.deleteByTest_IdTest(idTest);
        intentoRepository.flush();
        testRepository.deleteById(idTest);
        testRepository.flush();
    }
}
