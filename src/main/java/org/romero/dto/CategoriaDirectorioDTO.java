package org.romero.dto;

import java.util.List;

public class CategoriaDirectorioDTO {

    private final String nombre;
    private final List<TestDirectorioDTO> tests;

    public CategoriaDirectorioDTO(String nombre, List<TestDirectorioDTO> tests) {
        this.nombre = nombre;
        this.tests = tests;
    }

    public String getNombre() { return nombre; }
    public List<TestDirectorioDTO> getTests() { return tests; }
    public int getTotal() { return tests.size(); }
}
