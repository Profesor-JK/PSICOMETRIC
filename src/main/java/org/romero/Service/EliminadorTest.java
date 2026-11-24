package org.romero.Service;

/** Borra un test junto con los intentos que dependen de él. */
public interface EliminadorTest {
    void eliminarConDependencias(Integer idTest);
}
