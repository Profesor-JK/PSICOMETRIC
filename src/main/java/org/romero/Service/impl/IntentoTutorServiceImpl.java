package org.romero.Service.impl;

import org.romero.Service.IntentoMapper;
import org.romero.Service.IntentoTutorService;
import org.romero.dao.IntentoRepository;
import org.romero.dao.PacienteRepository;
import org.romero.dto.IntentoDetalleDTO;
import org.romero.dto.IntentoResumenDTO;
import org.romero.model.Intento;
import org.romero.model.Paciente;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class IntentoTutorServiceImpl implements IntentoTutorService {

    private final IntentoRepository intentoRepository;
    private final PacienteRepository pacienteRepository;
    private final IntentoMapper mapper;

    public IntentoTutorServiceImpl(IntentoRepository intentoRepository,
                                   PacienteRepository pacienteRepository,
                                   IntentoMapper mapper) {
        this.intentoRepository = intentoRepository;
        this.pacienteRepository = pacienteRepository;
        this.mapper = mapper;
    }

    @Override
    @Transactional(readOnly = true)
    public List<IntentoResumenDTO> listarActividad(Integer idTutor) {
        List<Integer> ids = idsPacientes(idTutor);
        if (ids.isEmpty()) return List.of();
        return mapper.aResumenes(intentoRepository.findByIdPacienteInOrderByFechaDesc(ids));
    }

    @Override
    @Transactional(readOnly = true)
    public IntentoDetalleDTO obtenerDetalle(Integer idTutor, Integer idIntento) {
        Intento intento = intentoRepository.findById(idIntento)
                .orElseThrow(() -> new IllegalArgumentException("No encontramos ese intento."));
        // Un tutor solo ve intentos de sus pacientes; mismo mensaje para no revelar si existe.
        if (!idsPacientes(idTutor).contains(intento.getIdPaciente())) {
            throw new IllegalArgumentException("No encontramos ese intento.");
        }
        return mapper.aDetalle(intento);
    }

    private List<Integer> idsPacientes(Integer idTutor) {
        return pacienteRepository.findByIdTutor(idTutor).stream().map(Paciente::getIdPaciente).toList();
    }
}
