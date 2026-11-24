package org.romero.dto;

/** Un test disponible para un paciente a cargo del tutor. */
public class TestTutorDTO {

    private final Integer idTest;
    private final String nombre;
    private final String categoria;
    private final Integer duracionMin;
    private final boolean exclusivo;
    private final Integer idPaciente;
    private final String nombrePaciente;
    private final long vecesRealizado;

    public TestTutorDTO(Integer idTest, String nombre, String categoria, Integer duracionMin,
                        boolean exclusivo, Integer idPaciente, String nombrePaciente, long vecesRealizado) {
        this.idTest = idTest;
        this.nombre = nombre;
        this.categoria = categoria;
        this.duracionMin = duracionMin;
        this.exclusivo = exclusivo;
        this.idPaciente = idPaciente;
        this.nombrePaciente = nombrePaciente;
        this.vecesRealizado = vecesRealizado;
    }

    public Integer getIdTest() { return idTest; }
    public String getNombre() { return nombre; }
    public String getCategoria() { return categoria; }
    public Integer getDuracionMin() { return duracionMin; }
    public boolean isExclusivo() { return exclusivo; }
    public Integer getIdPaciente() { return idPaciente; }
    public String getNombrePaciente() { return nombrePaciente; }
    public long getVecesRealizado() { return vecesRealizado; }
}
