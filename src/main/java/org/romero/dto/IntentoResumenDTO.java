package org.romero.dto;


public class IntentoResumenDTO {

    private final Integer idIntento;
    private final Integer idTest;
    private final String nombreTest;
    private final String categoriaTest;
    private final Integer idPaciente;
    private final String nombrePaciente;
    private final String fechaTexto;
    private final Double puntaje;
    private final Double puntajeMin;
    private final Double puntajeMax;
    private final String tituloRango;
    private final String nivelRango;

    public IntentoResumenDTO(Integer idIntento, Integer idTest, String nombreTest, String categoriaTest,
                             Integer idPaciente, String nombrePaciente, String fechaTexto,
                             Double puntaje, Double puntajeMin, Double puntajeMax,
                             String tituloRango, String nivelRango) {
        this.idIntento = idIntento;
        this.idTest = idTest;
        this.nombreTest = nombreTest;
        this.categoriaTest = categoriaTest;
        this.idPaciente = idPaciente;
        this.nombrePaciente = nombrePaciente;
        this.fechaTexto = fechaTexto;
        this.puntaje = puntaje;
        this.puntajeMin = puntajeMin;
        this.puntajeMax = puntajeMax;
        this.tituloRango = tituloRango;
        this.nivelRango = nivelRango;
    }

    public Integer getIdIntento() { return idIntento; }
    public Integer getIdTest() { return idTest; }
    public String getNombreTest() { return nombreTest; }
    public String getCategoriaTest() { return categoriaTest; }
    public Integer getIdPaciente() { return idPaciente; }
    public String getNombrePaciente() { return nombrePaciente; }
    public String getFechaTexto() { return fechaTexto; }
    public Double getPuntaje() { return puntaje; }
    public Double getPuntajeMin() { return puntajeMin; }
    public Double getPuntajeMax() { return puntajeMax; }
    public String getTituloRango() { return tituloRango; }
    public String getNivelRango() { return nivelRango; }
}
