package org.romero.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "test")
public class Test {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtest")
    private Integer idTest;

    @Column(name = "cedula", nullable = false)
    private Integer cedula;

    @Column(name = "nombre", nullable = false, length = 150)
    private String nombre;

    @Column(name = "categoria", length = 150)
    private String categoria;

    @Column(name = "duracion_min")
    private Integer duracionMin;

    @Column(name = "descripcion", length = 2000)
    private String descripcion;

    @Column(name = "instrucciones", length = 2000)
    private String instrucciones;

    @Column(name = "puntaje_min", nullable = false)
    private Double puntajeMin = 0.0;

    @Column(name = "puntaje_max", nullable = false)
    private Double puntajeMax = 0.0;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;

    @Column(name = "id_paciente_exclusivo")
    private Integer idPacienteExclusivo;

    @Column(name = "fecha_creacion", nullable = false)
    private LocalDateTime fechaCreacion = LocalDateTime.now();

    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("orden ASC")
    private List<Pregunta> preguntas = new ArrayList<>();

    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("minimo ASC")
    private List<RangoResultado> resultados = new ArrayList<>();

    public boolean esExclusivo() { return idPacienteExclusivo != null; }
    public boolean esVisibleParaPaciente(Integer idPaciente) {
        return idPacienteExclusivo == null || idPacienteExclusivo.equals(idPaciente);
    }

    public Integer getIdTest() { return idTest; }
    public void setIdTest(Integer idTest) { this.idTest = idTest; }
    public Integer getCedula() { return cedula; }
    public void setCedula(Integer cedula) { this.cedula = cedula; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
    public Integer getDuracionMin() { return duracionMin; }
    public void setDuracionMin(Integer duracionMin) { this.duracionMin = duracionMin; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getInstrucciones() { return instrucciones; }
    public void setInstrucciones(String instrucciones) { this.instrucciones = instrucciones; }
    public Double getPuntajeMin() { return puntajeMin; }
    public void setPuntajeMin(Double puntajeMin) { this.puntajeMin = puntajeMin; }
    public Double getPuntajeMax() { return puntajeMax; }
    public void setPuntajeMax(Double puntajeMax) { this.puntajeMax = puntajeMax; }
    public Boolean getActivo() { return activo; }
    public void setActivo(Boolean activo) { this.activo = activo; }
    public Integer getIdPacienteExclusivo() { return idPacienteExclusivo; }
    public void setIdPacienteExclusivo(Integer idPacienteExclusivo) { this.idPacienteExclusivo = idPacienteExclusivo; }
    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    public List<Pregunta> getPreguntas() { return preguntas; }
    public void setPreguntas(List<Pregunta> preguntas) { this.preguntas = preguntas; }
    public List<RangoResultado> getResultados() { return resultados; }
    public void setResultados(List<RangoResultado> resultados) { this.resultados = resultados; }
}
