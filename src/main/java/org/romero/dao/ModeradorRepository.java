package org.romero.dao;

import org.romero.model.Moderador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ModeradorRepository extends JpaRepository<Moderador, Integer> {
    Moderador findByUsuario(String usuario);
}
