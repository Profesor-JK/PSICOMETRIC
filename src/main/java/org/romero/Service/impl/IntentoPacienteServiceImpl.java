package org.romero.Service.impl;

import org.romero.Service.IntentoMapper;
import org.romero.Service.IntentoPacienteService;
import org.romero.dao.IntentoRepository;
import org.romero.dto.IntentoResumenDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class IntentoPacienteServiceImpl implements IntentoPacienteService {

    private final IntentoRepository intentoRepository;
    private final IntentoMapper mapper;

    public IntentoPacienteServiceImpl(IntentoRepository intentoRepository, IntentoMapper mapper) {
        this.intentoRepository = intentoRepository;
        this.mapper = mapper;
    }

    @Override
    @Transactional(readOnly = true)
    public List<IntentoResumenDTO> listarIntentos(Integer idPaciente) {
        return mapper.aResumenes(intentoRepository.findByIdPacienteOrderByFechaDesc(idPaciente));
    }
}
