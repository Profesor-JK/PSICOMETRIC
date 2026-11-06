package org.romero.DAO;

import org.romero.model.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PacienteRepository extends JpaRepository<Paciente, Integer> {
    // Aquí puedes agregar métodos como: List<Paciente> findByNombrePac(String nombre);
}