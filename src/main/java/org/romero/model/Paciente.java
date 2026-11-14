package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "paciente")
public class Paciente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idpaciente")
    private Integer idPaciente;

    @Column(name = "Nombrepac", nullable = false, length = 45)
    private String nombrePac;

    @Column(name = "Apellidospac", nullable = false, length = 50)
    private String apellidosPac;

    @Column(name = "Fechanacpac", nullable = false)
    private java.sql.Date fechaNacPac;

    @Column(name = "generopsc", nullable = false, length = 20)
    private String generoPsc;

    @Column(name = "contrapac", nullable = false, length = 30)
    private String contraPac;


    public Integer getIdPaciente() { return idPaciente; }
    public void setIdPaciente(Integer idPaciente) { this.idPaciente = idPaciente; }
    public String getNombrePac() { return nombrePac; }
    public void setNombrePac(String nombrePac) { this.nombrePac = nombrePac; }
    public String getApellidosPac() { return apellidosPac; }
    public void setApellidosPac(String apellidosPac) { this.apellidosPac = apellidosPac; }
    public java.sql.Date getFechaNacPac() { return fechaNacPac; }
    public void setFechaNacPac(java.sql.Date fechaNacPac) { this.fechaNacPac = fechaNacPac; }
    public String getGeneroPsc() { return generoPsc; }
    public void setGeneroPsc(String generoPsc) { this.generoPsc = generoPsc; }
    public String getContraPac() { return contraPac; }
    public void setContraPac(String contraPac) { this.contraPac = contraPac; }
}