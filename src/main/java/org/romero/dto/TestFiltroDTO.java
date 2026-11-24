package org.romero.dto;

public class TestFiltroDTO {

    private final Integer idTest;
    private final String nombre;

    public TestFiltroDTO(Integer idTest, String nombre) {
        this.idTest = idTest;
        this.nombre = nombre;
    }

    public Integer getIdTest() { return idTest; }
    public String getNombre() { return nombre; }
}
