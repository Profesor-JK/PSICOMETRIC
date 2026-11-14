package org.romero.Service.impl;

import org.romero.Service.ConsultaService;
import org.romero.dao.ConsultaRepository;
import org.romero.model.Consulta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ConsultaServiceImpl implements ConsultaService {
    @Autowired
    private ConsultaRepository consultaRepository;
    @Override
    public List<Consulta> getAllConsultas(){
        return consultaRepository.findAll();
    }
    @Override
    public Consulta findById(Integer idConsulta) {
        return consultaRepository.findById(idConsulta).orElse(null);
    }
    @Override
    public void save(Consulta consulta) {
        consultaRepository.save(consulta);
    }
    @Override
    public void deleteById(Integer id ) {
        consultaRepository.deleteById(id);
    }
    @Override
    public List<Consulta> obtenerfecha(LocalDateTime fechaconsulta) {
        return consultaRepository.findByFechaConsulta(fechaconsulta);
    }

}
