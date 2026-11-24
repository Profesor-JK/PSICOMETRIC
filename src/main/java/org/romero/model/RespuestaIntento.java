package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "respuesta_intento")
public class RespuestaIntento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idrespuesta")
    private Integer idRespuesta;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "idintento", nullable = false)
    private Intento intento;

    @Column(name = "idpregunta", nullable = false)
    private Integer idPregunta;

    @Column(name = "idopcion")
    private Integer idOpcion;

    @Column(name = "valor")
    private Double valor;

    @Column(name = "texto", length = 2000)
    private String texto;

    @Column(name = "puntos", nullable = false)
    private Double puntos = 0.0;

    public Integer getIdRespuesta() { return idRespuesta; }
    public void setIdRespuesta(Integer idRespuesta) { this.idRespuesta = idRespuesta; }
    public Intento getIntento() { return intento; }
    public void setIntento(Intento intento) { this.intento = intento; }
    public Integer getIdPregunta() { return idPregunta; }
    public void setIdPregunta(Integer idPregunta) { this.idPregunta = idPregunta; }
    public Integer getIdOpcion() { return idOpcion; }
    public void setIdOpcion(Integer idOpcion) { this.idOpcion = idOpcion; }
    public Double getValor() { return valor; }
    public void setValor(Double valor) { this.valor = valor; }
    public String getTexto() { return texto; }
    public void setTexto(String texto) { this.texto = texto; }
    public Double getPuntos() { return puntos; }
    public void setPuntos(Double puntos) { this.puntos = puntos; }
}
