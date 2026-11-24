package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "opcion")
public class Opcion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idopcion")
    private Integer idOpcion;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idpregunta", nullable = false)
    private Pregunta pregunta;

    @Column(name = "orden", nullable = false)
    private Integer orden;

    @Column(name = "texto", nullable = false, length = 500)
    private String texto;

    @Column(name = "puntos", nullable = false)
    private Double puntos = 0.0;

    public Integer getIdOpcion() { return idOpcion; }
    public void setIdOpcion(Integer idOpcion) { this.idOpcion = idOpcion; }
    public Pregunta getPregunta() { return pregunta; }
    public void setPregunta(Pregunta pregunta) { this.pregunta = pregunta; }
    public Integer getOrden() { return orden; }
    public void setOrden(Integer orden) { this.orden = orden; }
    public String getTexto() { return texto; }
    public void setTexto(String texto) { this.texto = texto; }
    public Double getPuntos() { return puntos; }
    public void setPuntos(Double puntos) { this.puntos = puntos; }
}
