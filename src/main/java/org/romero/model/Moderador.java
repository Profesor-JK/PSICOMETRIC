package org.romero.model;

import jakarta.persistence.*;

@Entity
@Table(name = "moderador")
public class Moderador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idmoderador")
    private Integer idModerador;

    @Column(name = "usuario", nullable = false, length = 30)
    private String usuario;

    @Column(name = "contra", nullable = false, length = 30)
    private String contra;

    public Integer getIdModerador() { return idModerador; }
    public void setIdModerador(Integer idModerador) { this.idModerador = idModerador; }
    public String getUsuario() { return usuario; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public String getContra() { return contra; }
    public void setContra(String contra) { this.contra = contra; }
}
