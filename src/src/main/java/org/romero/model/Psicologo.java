package org.romero.model;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
@Table(name = "psicologo")
public class Psicologo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cedula", nullable = false, length = 10)
    private Integer idPsicologo;

    @Column(name = "Nombrepsc", nullable = false, length = 45)
    private String Nombre;

    @Column(name = "Apellidospsc", nullable = false, length = 50)
    private String Apellidospsic;

    @Column(name = "Fechanacpsc", nullable = false)
    private java.sql.Date Fechanacpsic;

    @Column(name = "generopsc", nullable = false, length = 20)
    private String Generopsic;

    @Column(name = "contrapsc", nullable = false, length = 30)
    private String Contrapsic;

    public String getApellidospsic() {
        return Apellidospsic;
    }

    public void setApellidospsic(String apellidospsic) {
        Apellidospsic = apellidospsic;
    }

    public Integer getIdPsicologo() {
        return idPsicologo;
    }

    public void setIdPsicologo(Integer idPsicologo) {
        this.idPsicologo = idPsicologo;
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
}