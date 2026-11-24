package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "tutor")
public class Tutor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtutor")
    private Integer idTutor;

    @Column(name = "Nombretut", nullable = false, length = 50)
    private String nombreTut;

    @Column(name = "Apellidostut", nullable = false, length = 60)
    private String apellidosTut;

    @Column(name = "correotut", length = 50)
    private String correoTut;

    @Column(name = "Contratut", nullable = false, length = 30)
    private String contraTut;

    @Column(name = "Fechanactutor", nullable = false)
    private java.sql.Date fechaNacTutor;

    public Integer getIdTutor() { return idTutor; }
    public void setIdTutor(Integer idTutor) { this.idTutor = idTutor; }
    public String getNombreTut() { return nombreTut; }
    public void setNombreTut(String nombreTut) { this.nombreTut = nombreTut; }
    public String getApellidosTut() { return apellidosTut; }
    public void setApellidosTut(String apellidosTut) { this.apellidosTut = apellidosTut; }
    public String getCorreoTut() { return correoTut; }
    public void setCorreoTut(String correoTut) { this.correoTut = correoTut; }
    public String getContraTut() { return contraTut; }
    public void setContraTut(String contraTut) { this.contraTut = contraTut; }
    public java.sql.Date getFechaNacTutor() { return fechaNacTutor; }
    public void setFechaNacTutor(java.sql.Date fechaNacTutor) { this.fechaNacTutor = fechaNacTutor; }
}
