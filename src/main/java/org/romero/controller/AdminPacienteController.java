package org.romero.controller;

import org.romero.Service.GestionConAltaService;
import org.romero.dao.TutorRepository;
import org.romero.dto.CampoFormulario;
import org.romero.dto.CampoFormulario.Opcion;
import org.romero.dto.FilaListado;
import org.romero.dto.PacienteAdminDTO;
import org.romero.model.Paciente;
import org.romero.model.Tutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/pacientes")
public class AdminPacienteController extends GestionWebController<Paciente, PacienteAdminDTO> {

    private final GestionConAltaService<Paciente, PacienteAdminDTO> servicio;
    private final TutorRepository tutorRepository;

    public AdminPacienteController(GestionConAltaService<Paciente, PacienteAdminDTO> servicio,
                                   TutorRepository tutorRepository) {
        super(servicio);
        this.servicio = servicio;
        this.tutorRepository = tutorRepository;
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute PacienteAdminDTO form, @RequestParam(required = false) Integer id,
                          Model model, RedirectAttributes ra) {
        return guardarForm(form, id, model, ra);
    }

    @Override protected String ruta() { return "/admin/pacientes"; }
    @Override protected String titulo() { return "Pacientes"; }
    @Override protected String seccion() { return "adminPacientes"; }

    @Override
    protected List<String> columnas() {
        return List.of("ID", "Nombre", "Correo", "Género", "Tutor");
    }

    @Override
    protected FilaListado fila(Paciente p) {
        String tutor = "Sin tutor";
        if (p.getIdTutor() != null) {
            tutor = tutorRepository.findById(p.getIdTutor())
                    .map(t -> t.getNombreTut() + " " + t.getApellidosTut()).orElse("Sin tutor");
        }
        return new FilaListado(p.getIdPaciente(), List.of(String.valueOf(p.getIdPaciente()),
                p.getNombrePac() + " " + p.getApellidosPac(), p.getCorreoPac(), p.getGeneroPsc(), tutor));
    }

    @Override protected PacienteAdminDTO formVacio() { return new PacienteAdminDTO("", "", "", "", "", "", ""); }

    @Override
    protected PacienteAdminDTO aForm(Paciente p) {
        return new PacienteAdminDTO(p.getNombrePac(), p.getApellidosPac(), String.valueOf(p.getFechaNacPac()),
                p.getGeneroPsc(), p.getCorreoPac(), "", p.getIdTutor() == null ? "" : String.valueOf(p.getIdTutor()));
    }

    @Override
    protected List<CampoFormulario> campos(PacienteAdminDTO f, boolean edicion) {
        List<Opcion> tutores = new ArrayList<>();
        tutores.add(new Opcion("", "Sin tutor"));
        for (Tutor t : tutorRepository.findAll()) {
            tutores.add(new Opcion(String.valueOf(t.getIdTutor()), t.getNombreTut() + " " + t.getApellidosTut()));
        }
        return List.of(
                CampoFormulario.texto("nombre", "Nombre", "text", true, f.nombre()),
                CampoFormulario.texto("apellidos", "Apellidos", "text", true, f.apellidos()),
                CampoFormulario.texto("fechaNac", "Fecha de nacimiento", "date", true, f.fechaNac()),
                CampoFormulario.seleccion("genero", "Género", true, f.genero(), AdminPsicologoController.Generos.opciones()),
                CampoFormulario.texto("correo", "Correo", "email", true, f.correo()),
                AdminPsicologoController.contrasena(edicion),
                CampoFormulario.seleccion("idTutor", "Tutor", false, f.idTutor(), tutores));
    }

    @Override
    protected void crear(PacienteAdminDTO form) {
        servicio.alta(form);
    }
}
