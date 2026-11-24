package org.romero.controller;

import org.romero.Service.GestionConAltaService;
import org.romero.dto.CampoFormulario;
import org.romero.dto.FilaListado;
import org.romero.dto.TutorAdminDTO;
import org.romero.model.Tutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/tutores")
public class AdminTutorController extends GestionWebController<Tutor, TutorAdminDTO> {

    private final GestionConAltaService<Tutor, TutorAdminDTO> servicio;

    public AdminTutorController(GestionConAltaService<Tutor, TutorAdminDTO> servicio) {
        super(servicio);
        this.servicio = servicio;
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute TutorAdminDTO form, @RequestParam(required = false) Integer id,
                          Model model, RedirectAttributes ra) {
        return guardarForm(form, id, model, ra);
    }

    @Override protected String ruta() { return "/admin/tutores"; }
    @Override protected String titulo() { return "Tutores"; }
    @Override protected String seccion() { return "adminTutores"; }

    @Override
    protected List<String> columnas() {
        return List.of("ID", "Nombre", "Correo", "Fecha de nacimiento");
    }

    @Override
    protected FilaListado fila(Tutor t) {
        return new FilaListado(t.getIdTutor(), List.of(String.valueOf(t.getIdTutor()),
                t.getNombreTut() + " " + t.getApellidosTut(), String.valueOf(t.getCorreoTut()),
                String.valueOf(t.getFechaNacTutor())));
    }

    @Override protected TutorAdminDTO formVacio() { return new TutorAdminDTO("", "", "", "", ""); }

    @Override
    protected TutorAdminDTO aForm(Tutor t) {
        return new TutorAdminDTO(t.getNombreTut(), t.getApellidosTut(), String.valueOf(t.getFechaNacTutor()),
                t.getCorreoTut(), "");
    }

    @Override
    protected List<CampoFormulario> campos(TutorAdminDTO f, boolean edicion) {
        return List.of(
                CampoFormulario.texto("nombre", "Nombre", "text", true, f.nombre()),
                CampoFormulario.texto("apellidos", "Apellidos", "text", true, f.apellidos()),
                CampoFormulario.texto("fechaNac", "Fecha de nacimiento", "date", true, f.fechaNac()),
                CampoFormulario.texto("correo", "Correo", "email", true, f.correo()),
                AdminPsicologoController.contrasena(edicion));
    }

    @Override
    protected void crear(TutorAdminDTO form) {
        servicio.alta(form);
    }
}
