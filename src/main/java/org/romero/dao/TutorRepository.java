package org.romero.dao;

import org.romero.model.Tutor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TutorRepository extends JpaRepository<Tutor, Integer> {
    Tutor findByCorreoTut(String correoTut);
}
