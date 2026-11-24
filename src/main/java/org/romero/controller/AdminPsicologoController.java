package org.romero.controller;

import org.romero.Service.GestionConAltaService;
import org.romero.dto.CampoFormulario;
import org.romero.dto.CampoFormulario.Opcion;
import org.romero.dto.FilaListado;
import org.romero.dto.PsicologoAdminDTO;
import org.romero.model.Psicologo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/psicologos")
public class AdminPsicologoController extends GestionWebController<Psicologo, PsicologoAdminDTO> {

    private final GestionConAltaService<Psicologo, PsicologoAdminDTO> servicio;

    public AdminPsicologoController(GestionConAltaService<Psicologo, PsicologoAdminDTO> servicio) {
        super(servicio);
        this.servicio = servicio;
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute PsicologoAdminDTO form, @RequestParam(required = false) Integer id,
                          Model model, RedirectAttributes ra) {
        return guardarForm(form, id, model, ra);
    }

    @Override protected String ruta() { return "/admin/psicologos"; }
    @Override protected String titulo() { return "Psicólogos"; }
    @Override protected String seccion() { return "adminPsicologos"; }

    @Override
    protected List<String> columnas() {
        return List.of("Cédula", "Nombre", "Correo", "Título", "Escuela");
    }

    @Override
    protected FilaListado fila(Psicologo p) {
        return new FilaListado(p.getCedula(), List.of(String.valueOf(p.getCedula()),
                p.getNombre() + " " + p.getApellidospsic(), p.getCorropsic(), p.getTitulo(), p.getEscuela()));
    }

    @Override protected PsicologoAdminDTO formVacio() {
        return new PsicologoAdminDTO("", "", "", "", "", "", "", "", "");
    }

    @Override
    protected PsicologoAdminDTO aForm(Psicologo p) {
        return new PsicologoAdminDTO(String.valueOf(p.getCedula()), p.getNombre(), p.getApellidospsic(),
                String.valueOf(p.getFechanacpsic()), p.getGeneropsic(), p.getCorropsic(), "",
                p.getTitulo(), p.getEscuela());
    }

    @Override
    protected List<CampoFormulario> campos(PsicologoAdminDTO f, boolean edicion) {
        return List.of(
                new CampoFormulario("cedula", "Cédula", "number", true, edicion, f.cedula(), null,
                        edicion ? "La cédula identifica al psicólogo y no se puede cambiar." : null),
                CampoFormulario.texto("nombre", "Nombre", "text", true, f.nombre()),
                CampoFormulario.texto("apellidos", "Apellidos", "text", true, f.apellidos()),
                CampoFormulario.texto("fechaNac", "Fecha de nacimiento", "date", true, f.fechaNac()),
                CampoFormulario.seleccion("genero", "Género", true, f.genero(), Generos.opciones()),
                CampoFormulario.texto("correo", "Correo", "email", true, f.correo()),
                contrasena(edicion),
                CampoFormulario.texto("titulo", "Título", "text", true, f.titulo()),
                CampoFormulario.texto("escuela", "Escuela", "text", true, f.escuela()));
    }

    @Override
    protected void crear(PsicologoAdminDTO form) {
        servicio.alta(form);
    }

    static CampoFormulario contrasena(boolean edicion) {
        return new CampoFormulario("contrasena", "Contraseña", "password", !edicion, false, "", null,
                edicion ? "Déjala vacía para conservar la actual." : null);
    }

    /** Opciones de género compartidas por los formularios. */
    static final class Generos {
        private Generos() {}
        static List<Opcion> opciones() {
            return List.of(new Opcion("", "Selecciona…"), new Opcion("Masculino", "Masculino"),
                    new Opcion("Femenino", "Femenino"), new Opcion("Otro", "Otro"));
        }
    }
}
