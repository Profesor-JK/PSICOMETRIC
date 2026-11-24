package org.romero.dto;

import java.util.List;
public class FilaListado {
    private final Integer id;
    private final List<String> celdas;

    public FilaListado(Integer id, List<String> celdas) {
        this.id = id;
        this.celdas = celdas;
    }

    public Integer getId() { return id; }
    public List<String> getCeldas() { return celdas; }
}
