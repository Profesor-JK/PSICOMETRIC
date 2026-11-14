package org.romero.dto;

public class ConsultaDTO {
    private String fechaConsulta;
    private Integer idpaciente;
    private Integer cedula;
    private Integer idtutor;

    public String getFechaConsulta() {
        return fechaConsulta;
    }

    public void setFechaConsulta(String fechaConsulta) {
        this.fechaConsulta = fechaConsulta;
    }

    public Integer getIdpaciente() {
        return idpaciente;
    }

    public void setIdpaciente(Integer idpaciente) {
        this.idpaciente = idpaciente;
    }

    public Integer getCedula() {
        return cedula;
    }

    public void setCedula(Integer cedula) {
        this.cedula = cedula;
    }

    public Integer getIdtutor() {
        return idtutor;
    }

    public void setIdtutor(Integer idtutor) {
        this.idtutor = idtutor;
    }
}
