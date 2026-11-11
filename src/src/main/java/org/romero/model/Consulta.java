package org.romero.model;
import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "consulta")
public class Consulta {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idconsulta", nullable = false)
    private Integer idConsulta;
    @Column(name = "Cedula", nullable = false)
    private Integer cedula;
    @Column(name = "idpaciente", nullable = true)
    private Integer idPaciente;
    @Column(name = "idtutor", nullable = true)
    private Integer idTutor;
    @Column(name = "Fechaconsulta", nullable = true)
    private LocalDateTime fechaConsulta;
}
