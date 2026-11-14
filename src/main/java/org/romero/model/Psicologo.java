package org.romero.model;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
@Table(name = "psicologo")
public class Psicologo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cedula", nullable = false, length = 10)
    private Integer cedula;

    @Column(name = "Nombrepsic", nullable = false, length = 45)
    private String Nombre;

    @Column(name = "Apellidospsic", nullable = false, length = 50)
    private String Apellidospsic;

    @Column(name = "Fechanacpsic", nullable = false)
    private java.sql.Date Fechanacpsic;

    @Column(name = "generopsic", nullable = false, length = 20)
    private String Generopsic;

    @Column(name = "contrapsic", nullable = false, length = 30)
    private String Contrapsic;

    @Column(name = "Titulo", nullable = false, length = 30)
    private String Titulo;

    @Column(name = "Escuela", nullable = false, length = 50)
    private String Escuela;

    @Column(name ="correopsic", nullable = false, length = 50)
    private String correopsic;

    public String getApellidospsic() {
        return Apellidospsic;
    }

    public void setApellidospsic(String apellidospsic) {
        Apellidospsic = apellidospsic;
    }

    public Integer getCedula() {
        return cedula;
    }

    public void setCedula(Integer cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
    }

    public Date getFechanacpsic() {
        return Fechanacpsic;
    }

    public void setFechanacpsic(Date fechanacpsic) {
        Fechanacpsic = fechanacpsic;
    }

    public String getGeneropsic() {
        return Generopsic;
    }

    public void setGeneropsic(String generopsic) {
        Generopsic = generopsic;
    }

    public String getContrapsic() {
        return Contrapsic;
    }

    public void setContrapsic(String contrapsic) {
        Contrapsic = contrapsic;
    }

    public String getTitulo() {return Titulo;}

    public void setTitulo(String titulo) {Titulo = titulo;}

    public String getEscuela() {return Escuela;}

    public void setEscuela(String escuela) {Escuela = escuela;}

    public String getCorropsic() {
        return correopsic;
    }

    public void setCorropsic(String corropsic) {
        this.correopsic = corropsic;
    }
}