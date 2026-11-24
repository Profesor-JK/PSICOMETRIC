package org.romero.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "pregunta")
public class Pregunta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpregunta")
    private Integer idPregunta;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idtest", nullable = false)
    private Test test;

    @Column(name = "orden", nullable = false)
    private Integer orden;

    @Column(name = "texto", nullable = false, length = 1000)
    private String texto;

    @Column(name = "tipo", nullable = false, length = 20)
    private String tipo;

    @Column(name = "obligatoria", nullable = false)
    private Boolean obligatoria = true;

    @Column(name = "escala_min")
    private Double escalaMin;

    @Column(name = "escala_max")
    private Double escalaMax;

    @Column(name = "etiqueta_min", length = 60)
    private String etiquetaMin;

    @Column(name = "etiqueta_max", length = 60)
    private String etiquetaMax;

    @OneToMany(mappedBy = "pregunta", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("orden ASC")
    private List<Opcion> opciones = new ArrayList<>();

    public boolean isEscalaCompacta() {
        return escalaMin != null && escalaMax != null
                && escalaMin == Math.floor(escalaMin) && escalaMax == Math.floor(escalaMax)
                && (escalaMax - escalaMin) <= 10;
    }
    public int getEscalaMinEntero() { return escalaMin == null ? 0 : escalaMin.intValue(); }
    public int getEscalaMaxEntero() { return escalaMax == null ? 0 : escalaMax.intValue(); }

    public Integer getIdPregunta() { return idPregunta; }
    public void setIdPregunta(Integer idPregunta) { this.idPregunta = idPregunta; }
    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }
    public Integer getOrden() { return orden; }
    public void setOrden(Integer orden) { this.orden = orden; }
    public String getTexto() { return texto; }
    public void setTexto(String texto) { this.texto = texto; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public Boolean getObligatoria() { return obligatoria; }
    public void setObligatoria(Boolean obligatoria) { this.obligatoria = obligatoria; }
    public Double getEscalaMin() { return escalaMin; }
    public void setEscalaMin(Double escalaMin) { this.escalaMin = escalaMin; }
    public Double getEscalaMax() { return escalaMax; }
    public void setEscalaMax(Double escalaMax) { this.escalaMax = escalaMax; }
    public String getEtiquetaMin() { return etiquetaMin; }
    public void setEtiquetaMin(String etiquetaMin) { this.etiquetaMin = etiquetaMin; }
    public String getEtiquetaMax() { return etiquetaMax; }
    public void setEtiquetaMax(String etiquetaMax) { this.etiquetaMax = etiquetaMax; }
    public List<Opcion> getOpciones() { return opciones; }
    public void setOpciones(List<Opcion> opciones) { this.opciones = opciones; }
}
