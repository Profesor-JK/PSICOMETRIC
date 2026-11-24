package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "rango_resultado")
public class RangoResultado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idrango")
    private Integer idRango;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idtest", nullable = false)
    private Test test;

    @Column(name = "minimo", nullable = false)
    private Double minimo;

    @Column(name = "maximo", nullable = false)
    private Double maximo;

    @Column(name = "titulo", nullable = false, length = 150)
    private String titulo;

    @Column(name = "descripcion", length = 2000)
    private String descripcion;
    @Column(name = "nivel", nullable = false, length = 20)
    private String nivel = "primary";

    public Integer getIdRango() { return idRango; }
    public void setIdRango(Integer idRango) { this.idRango = idRango; }
    public Test getTest() { return test; }
    public void setTest(Test test) { this.test = test; }
    public Double getMinimo() { return minimo; }
    public void setMinimo(Double minimo) { this.minimo = minimo; }
    public Double getMaximo() { return maximo; }
    public void setMaximo(Double maximo) { this.maximo = maximo; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public String getNivel() { return nivel; }
    public void setNivel(String nivel) { this.nivel = nivel; }
}
