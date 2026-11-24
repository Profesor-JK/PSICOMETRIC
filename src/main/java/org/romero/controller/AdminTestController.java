package org.romero.controller;

import org.romero.Service.GestionService;
import org.romero.Service.PacienteService;
import org.romero.Service.PsicologoService;
import org.romero.dto.CampoFormulario;
import org.romero.dto.CampoFormulario.Opcion;
import org.romero.dto.FilaListado;
import org.romero.dto.PacienteResumenDTO;
import org.romero.dto.TestAdminDTO;
import org.romero.model.Psicologo;
import org.romero.model.Test;
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
@RequestMapping("/admin/tests")
public class AdminTestController extends GestionWebController<Test, TestAdminDTO> {

    private final PsicologoService psicologoService;
    private final PacienteService pacienteService;

    public AdminTestController(GestionService<Test, TestAdminDTO> servicio,
                               PsicologoService psicologoService,
                               PacienteService pacienteService) {
        super(servicio);
        this.psicologoService = psicologoService;
        this.pacienteService = pacienteService;
    }

    /** Solo cambios: el alta va por POST /admin/tests/alta (AdminTestRestController). */
    @PostMapping("/guardar")
    public String guardar(@ModelAttribute TestAdminDTO form, @RequestParam(required = false) Integer id,
                          Model model, RedirectAttributes ra) {
        return guardarForm(form, id, model, ra);
    }

    @Override protected String ruta() { return "/admin/tests"; }
    @Override protected String titulo() { return "Tests"; }
    @Override protected String seccion() { return "adminTests"; }
    @Override protected String vistaNuevo() { return "admin/testNuevo"; }

    @Override
    protected void datosNuevo(Model model) {
        model.addAttribute("psicologos", psicologoService.findAll());
    }

    @Override
    protected List<String> columnas() {
        return List.of("ID", "Nombre", "Categoría", "Psicólogo", "Exclusivo para", "Activo");
    }

    @Override
    protected FilaListado fila(Test t) {
        Psicologo ps = psicologoService.findByCedula(t.getCedula());
        String psicologo = ps == null ? String.valueOf(t.getCedula()) : ps.getNombre() + " " + ps.getApellidospsic();
        String exclusivo = "Público";
        if (t.getIdPacienteExclusivo() != null) {
            var p = pacienteService.findById(t.getIdPacienteExclusivo());
            exclusivo = p == null ? "Paciente eliminado" : p.getNombrePac() + " " + p.getApellidosPac();
        }
        return new FilaListado(t.getIdTest(), List.of(String.valueOf(t.getIdTest()), t.getNombre(),
                t.getCategoria() == null ? "—" : t.getCategoria(), psicologo, exclusivo,
                Boolean.TRUE.equals(t.getActivo()) ? "Sí" : "No"));
    }

    @Override protected TestAdminDTO formVacio() { return new TestAdminDTO("", "", "", "", "", "", "", "true"); }

    @Override
    protected TestAdminDTO aForm(Test t) {
        return new TestAdminDTO(t.getNombre(), t.getCategoria(),
                t.getDuracionMin() == null ? "" : String.valueOf(t.getDuracionMin()),
                t.getDescripcion(), t.getInstrucciones(), String.valueOf(t.getCedula()),
                t.getIdPacienteExclusivo() == null ? "" : String.valueOf(t.getIdPacienteExclusivo()),
                String.valueOf(Boolean.TRUE.equals(t.getActivo())));
    }

    @Override
    protected List<CampoFormulario> campos(TestAdminDTO f, boolean edicion) {
        List<Opcion> psicologos = new ArrayList<>();
        psicologos.add(new Opcion("", "Selecciona…"));
        for (Psicologo p : psicologoService.findAll()) {
            psicologos.add(new Opcion(String.valueOf(p.getCedula()), p.getNombre() + " " + p.getApellidospsic()));
        }
        List<Opcion> pacientes = new ArrayList<>();
        pacientes.add(new Opcion("", "Público (todos los pacientes)"));
        for (PacienteResumenDTO p : pacienteService.listarResumenes()) {
            pacientes.add(new Opcion(String.valueOf(p.idPaciente()), p.nombre()));
        }
        return List.of(
                CampoFormulario.texto("nombre", "Nombre del test", "text", true, f.nombre()),
                CampoFormulario.texto("categoria", "Categoría", "text", false, f.categoria()),
                CampoFormulario.texto("duracionMin", "Duración (min)", "number", false, f.duracionMin()),
                CampoFormulario.texto("descripcion", "Descripción", "textarea", false, f.descripcion()),
                CampoFormulario.texto("instrucciones", "Instrucciones", "textarea", false, f.instrucciones()),
                CampoFormulario.seleccion("cedula", "Psicólogo responsable", true, f.cedula(), psicologos),
                CampoFormulario.seleccion("idPacienteExclusivo", "Visible para", false, f.idPacienteExclusivo(), pacientes),
                CampoFormulario.seleccion("activo", "Activo", true, f.activo(),
                        List.of(new Opcion("true", "Sí"), new Opcion("false", "No"))));
    }

    @Override
    protected void crear(TestAdminDTO form) {
        throw new UnsupportedOperationException("El alta de tests se hace desde el constructor de tests.");
    }
}
