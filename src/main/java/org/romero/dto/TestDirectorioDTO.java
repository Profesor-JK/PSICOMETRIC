package org.romero.dto;


public class TestDirectorioDTO {

    private final Integer idTest;
    private final String nombre;
    private final Integer duracionMin;

    public TestDirectorioDTO(Integer idTest, String nombre, Integer duracionMin) {
        this.idTest = idTest;
        this.nombre = nombre;
        this.duracionMin = duracionMin;
    }

    public Integer getIdTest() { return idTest; }
    public String getNombre() { return nombre; }
    public Integer getDuracionMin() { return duracionMin; }
}
