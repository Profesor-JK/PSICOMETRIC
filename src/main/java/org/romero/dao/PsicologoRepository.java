package org.romero.dao;

import org.romero.model.Psicologo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PsicologoRepository extends JpaRepository<Psicologo, Integer> {
    @Override
    List<Psicologo> findAll();
    Psicologo findByCedula(Integer cedula);
    Psicologo save(Psicologo psicologo);
    void deleteById(Integer id);
    Psicologo findByCorreopsic(String correopsic);
}