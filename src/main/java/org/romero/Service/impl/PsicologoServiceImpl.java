package org.romero.Service.impl;

import org.romero.Service.PsicologoService;
import org.romero.dao.PsicologoRepository;
import org.romero.model.Psicologo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PsicologoServiceImpl implements PsicologoService {
    @Autowired
    private PsicologoRepository psicologoRepository;
    @Override
    public List<Psicologo> findAll() {
        return psicologoRepository.findAll();
    }
    @Override
    public Psicologo findByCedula(Integer cedula) {
        return psicologoRepository.findByCedula(cedula);
    }
    @Override
    public void save(Psicologo psicologo) {
        psicologoRepository.save(psicologo);
    }
    @Override
    public void deleteById(Integer id ) {
        psicologoRepository.deleteById(id);
    }
    @Override
    public void update(Psicologo psicologo){
        psicologoRepository.save(psicologo);
    }
    @Override
    public Psicologo obtenerCorreopsic(String correo){return psicologoRepository.findByCorreopsic(correo);}

}

