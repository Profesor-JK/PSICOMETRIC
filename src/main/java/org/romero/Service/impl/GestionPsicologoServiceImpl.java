package org.romero.Service.impl;

import org.romero.Service.CorreoUnicoValidator;
import org.romero.Service.EliminadorTest;
import org.romero.Service.GestionConAltaService;
import org.romero.Service.Validaciones;
import org.romero.dao.ConsultaRepository;
import org.romero.dao.PsicologoRepository;
import org.romero.dao.TestRepository;
import org.romero.dto.PsicologoAdminDTO;
import org.romero.model.Psicologo;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.List;

@Service
public class GestionPsicologoServiceImpl implements GestionConAltaService<Psicologo, PsicologoAdminDTO> {

    private final PsicologoRepository psicologoRepository;
    private final TestRepository testRepository;
    private final ConsultaRepository consultaRepository;
    private final EliminadorTest eliminadorTest;
    private final CorreoUnicoValidator correos;

    public GestionPsicologoServiceImpl(PsicologoRepository psicologoRepository,
                                       TestRepository testRepository,
                                       ConsultaRepository consultaRepository,
                                       EliminadorTest eliminadorTest,
                                       CorreoUnicoValidator correos) {
        this.psicologoRepository = psicologoRepository;
        this.testRepository = testRepository;
        this.consultaRepository = consultaRepository;
        this.eliminadorTest = eliminadorTest;
        this.correos = correos;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Psicologo> consultar(String filtro) {
        return psicologoRepository.findAll().stream()
                .filter(p -> Validaciones.coincide(filtro, p.getNombre(), p.getApellidospsic(),
                        p.getCorropsic(), String.valueOf(p.getCedula()), p.getTitulo(), p.getEscuela()))
                .sorted(Comparator.comparing(Psicologo::getNombre, String.CASE_INSENSITIVE_ORDER))
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public Psicologo obtener(Integer id) {
        return psicologoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos a ese psicólogo."));
    }

    @Override
    @Transactional
    public void alta(PsicologoAdminDTO form) {
        Integer cedula = Validaciones.entero(form.cedula(), "La cédula");
        if (psicologoRepository.existsById(cedula)) {
            throw new IllegalArgumentException("Ya existe un psicólogo con esa cédula.");
        }
        Psicologo p = new Psicologo();
        p.setCedula(cedula);
        llenar(p, form, true);
        correos.verificarLibre(p.getCorropsic());
        psicologoRepository.save(p);
    }

    @Override
    @Transactional
    public void cambio(Integer id, PsicologoAdminDTO form) {
        Psicologo p = obtener(id);
        String correoActual = p.getCorropsic();
        llenar(p, form, false);
        correos.verificarCambio(correoActual, p.getCorropsic());
        psicologoRepository.save(p);
    }

    @Override
    @Transactional
    public void baja(Integer id) {
        obtener(id);
        for (Test t : testRepository.findByCedulaOrderByFechaCreacionDesc(id)) {
            eliminadorTest.eliminarConDependencias(t.getIdTest());
        }
        consultaRepository.deleteByCedula(id);
        consultaRepository.flush();
        psicologoRepository.deleteById(id);
    }

    private void llenar(Psicologo p, PsicologoAdminDTO f, boolean nuevo) {
        p.setNombre(Validaciones.requerido(f.nombre(), "El nombre", 45));
        p.setApellidospsic(Validaciones.requerido(f.apellidos(), "Los apellidos", 50));
        p.setFechanacpsic(Validaciones.fecha(f.fechaNac(), "La fecha de nacimiento"));
        p.setGeneropsic(Validaciones.genero(f.genero()));
        p.setCorropsic(Validaciones.correo(f.correo()));
        p.setTitulo(Validaciones.requerido(f.titulo(), "El título", 30));
        p.setEscuela(Validaciones.requerido(f.escuela(), "La escuela", 50));
        String contra = Validaciones.contrasena(f.contrasena(), nuevo);
        if (contra != null) p.setContrapsic(contra);
    }
}
