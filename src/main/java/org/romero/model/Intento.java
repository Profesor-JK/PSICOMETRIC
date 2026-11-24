package org.romero.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "intento")
public class Intento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idintento")
    private Integer idIntento;

    @ManyToOne(optional = false)
    @JoinColumn(name = "idtest", nullable = false)
    private Test test;

    @Column(name = "idpaciente", nullable = false)
    private Integer idPaciente;

    @Column(name = "fecha", nullable = false)
    private LocalDateTime fecha = LocalDateTime.now();

    @Column(name = "puntaje", nullable = false)
    private Double puntaje = 0.0;

    @ManyToOne
    @JoinColumn(name = "idrango")
    private RangoResultado rango;

    @OneToMany(mappedBy = "intento", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RespuestaIntento> respuestas = new ArrayList<>();

    public Integer getIdIntento() { return idIntento; }
    public void setIdIntento(Integer idIntento) { this.idIntento = idIntento; }
    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }
    public Integer getIdPaciente() { return idPaciente; }
    public void setIdPaciente(Integer idPaciente) { this.idPaciente = idPaciente; }
    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
    public Double getPuntaje() { return puntaje; }
    public void setPuntaje(Double puntaje) { this.puntaje = puntaje; }
    public RangoResultado getRango() { return rango; }
    public void setRango(RangoResultado rango) { this.rango = rango; }
    public List<RespuestaIntento> getRespuestas() { return respuestas; }
    public void setRespuestas(List<RespuestaIntento> respuestas) { this.respuestas = respuestas; }
}
