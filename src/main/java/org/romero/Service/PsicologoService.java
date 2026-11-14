package org.romero.Service;
import org.romero.model.Psicologo;
import java.util.List;

public interface PsicologoService {
    List<Psicologo> findAll();
    Psicologo findByCedula(Integer cedula);
    void save(Psicologo psicologo);
    void deleteById(Integer id);
    void update(Psicologo psicologo);
    Psicologo obtenerCorreopsic(String correo);
}
