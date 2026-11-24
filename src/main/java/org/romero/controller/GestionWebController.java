package org.romero.controller;

import org.romero.Service.GestionService;
import org.romero.dto.CampoFormulario;
import org.romero.dto.FilaListado;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

/**
 * Pantallas comunes de gestión (consultas, altas, cambios y bajas) del moderador.
 * Cada entidad solo dice qué columnas y campos tiene (patrón "método plantilla").
 *
 * @param <E> entidad que se lista
 * @param <F> formulario con el que se da de alta o se cambia
 */
public abstract class GestionWebController<E, F> {

    private static final String VISTA_LISTADO = "admin/listado";
    private static final String VISTA_FORMULARIO = "admin/formulario";

    private final GestionService<E, F> servicio;

    protected GestionWebController(GestionService<E, F> servicio) {
        this.servicio = servicio;
    }

    // ---- lo que define cada entidad ----
    protected abstract String ruta();                 // ej. /admin/psicologos
    protected abstract String titulo();               // ej. Psicólogos
    protected abstract String seccion();              // opción activa de la navbar
    protected abstract List<String> columnas();
    protected abstract FilaListado fila(E entidad);
    protected abstract F formVacio();
    protected abstract F aForm(E entidad);
    protected abstract List<CampoFormulario> campos(F form, boolean edicion);
    protected abstract void crear(F form);

    // ---- ganchos opcionales ----
    protected String vistaNuevo() { return VISTA_FORMULARIO; }
    protected void datosNuevo(Model model) { }

    // ---- consultas / cambios / bajas ----
    @GetMapping
    public String listar(@RequestParam(required = false) String q,
                         @RequestParam(defaultValue = "consulta") String modo,
                         Model model) {
        String modoValido = List.of("consulta", "cambios", "bajas").contains(modo) ? modo : "consulta";
        List<FilaListado> filas = new ArrayList<>();
        for (E e : servicio.consultar(q)) filas.add(fila(e));

        base(model);
        model.addAttribute("modo", modoValido);
        model.addAttribute("q", q == null ? "" : q);
        model.addAttribute("columnas", columnas());
        model.addAttribute("filas", filas);
        return VISTA_LISTADO;
    }

    // ---- altas ----
    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        base(model);
        model.addAttribute("modo", "alta");
        model.addAttribute("campos", campos(formVacio(), false));
        datosNuevo(model);
        return vistaNuevo();
    }

    // ---- cambios ----
    @GetMapping("/{id}/editar")
    public String editar(@PathVariable Integer id, Model model, RedirectAttributes ra) {
        try {
            F form = aForm(servicio.obtener(id));
            base(model);
            model.addAttribute("modo", "cambios");
            model.addAttribute("idEdicion", id);
            model.addAttribute("campos", campos(form, true));
            return VISTA_FORMULARIO;
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
            return "redirect:" + ruta() + "?modo=cambios";
        }
    }

    // ---- bajas ----
    @PostMapping("/{id}/eliminar")
    public String eliminar(@PathVariable Integer id, RedirectAttributes ra) {
        try {
            servicio.baja(id);
            ra.addFlashAttribute("exito", "Registro eliminado.");
        } catch (IllegalArgumentException e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:" + ruta() + "?modo=bajas";
    }

    /** Lo usan los POST /guardar de cada controlador: alta si no hay id, cambio si lo hay. */
    protected String guardarForm(F form, Integer id, Model model, RedirectAttributes ra) {
        try {
            if (id == null) crear(form); else servicio.cambio(id, form);
            ra.addFlashAttribute("exito", id == null ? "Alta realizada." : "Cambios guardados.");
            return "redirect:" + ruta() + (id == null ? "" : "?modo=cambios");
        } catch (IllegalArgumentException e) {
            base(model);
            model.addAttribute("modo", id == null ? "alta" : "cambios");
            model.addAttribute("idEdicion", id);
            model.addAttribute("campos", campos(form, id != null));
            model.addAttribute("error", e.getMessage());
            if (id == null) datosNuevo(model);
            return id == null ? vistaNuevo() : VISTA_FORMULARIO;
        }
    }

    private void base(Model model) {
        model.addAttribute("titulo", titulo());
        model.addAttribute("ruta", ruta());
        model.addAttribute("seccion", seccion());
    }
}
