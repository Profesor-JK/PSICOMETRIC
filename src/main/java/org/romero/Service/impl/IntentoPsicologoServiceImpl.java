package org.romero.Service.impl;

import org.romero.Service.IntentoMapper;
import org.romero.Service.IntentoPsicologoService;
import org.romero.dao.IntentoRepository;
import org.romero.dao.TestRepository;
import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;
import org.romero.dto.TestFiltroDTO;
import org.romero.model.Intento;
import org.romero.model.Test;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class IntentoPsicologoServiceImpl implements IntentoPsicologoService {

    private final IntentoRepository intentoRepository;
    private final TestRepository testRepository;
    private final IntentoMapper mapper;

    public IntentoPsicologoServiceImpl(IntentoRepository intentoRepository,
                                       TestRepository testRepository,
                                       IntentoMapper mapper) {
        this.intentoRepository = intentoRepository;
        this.testRepository = testRepository;
        this.mapper = mapper;
    }

    @Override
    @Transactional(readOnly = true)
    public List<IntentoResumenDTO> listarIntentos(Integer cedulaPsicologo, Integer idTest) {
        List<Intento> intentos = (idTest == null)
                ? intentoRepository.findByTest_CedulaOrderByFechaDesc(cedulaPsicologo)
                : intentoRepository.findByTest_CedulaAndTest_IdTestOrderByFechaDesc(cedulaPsicologo, idTest);
        return mapper.aResumenes(intentos);
    }

    @Override
    @Transactional(readOnly = true)
    public IntentoDetalleDTO obtenerDetalle(Integer cedulaPsicologo, Integer idIntento) {
        Intento intento = intentoRepository.findById(idIntento)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos ese intento."));
        if (!cedulaPsicologo.equals(intento.getTest().getCedula())) {
            throw new IllegalArgumentException("No encontramos ese intento.");
        }
        return mapper.aDetalle(intento);
    }

    @Override
    @Transactional(readOnly = true)
    public List<TestFiltroDTO> listarTests(Integer cedulaPsicologo) {
        List<TestFiltroDTO> filtros = new ArrayList<>();
        for (Test t : testRepository.findByCedulaOrderByFechaCreacionDesc(cedulaPsicologo)) {
            filtros.add(new TestFiltroDTO(t.getIdTest(), t.getNombre()));
        }
        return filtros;
    }
}
