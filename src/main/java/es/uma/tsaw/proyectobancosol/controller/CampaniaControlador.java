package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import es.uma.tsaw.proyectobancosol.service.CampanyaService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

@Controller
@AllArgsConstructor
public class CampaniaControlador {

    private final CampanyaService campanyaService;

    private static final List<String> TIPOS_CAMPANYA = Arrays.asList("GR", "primavera");

    // ── LISTAR ─────────────────────────────────────────────────────────────

    @GetMapping("/campanas")
    public String listar(Model model) {
        List<CampanyaDTO> campanas = campanyaService.findAll();
        List<CadenaEntity> cadenaEntities = campanyaService.findAllCadenas();

        // JSON de cadenas por campaña: { "1": [2, 5], "2": [3] }
        StringBuilder sbCadenas = new StringBuilder("{");
        for (int i = 0; i < campanas.size(); i++) {
            CampanyaDTO c = campanas.get(i);
            sbCadenas.append("\"").append(c.getIdCampanya()).append("\":[");
            List<Integer> ids = c.getCadenaIds();
            if (ids != null) {
                for (int j = 0; j < ids.size(); j++) {
                    sbCadenas.append(ids.get(j));
                    if (j < ids.size() - 1) sbCadenas.append(",");
                }
            }
            sbCadenas.append("]");
            if (i < campanas.size() - 1) sbCadenas.append(",");
        }
        sbCadenas.append("}");

        // JSON de datos de campaña: { "1": { "nombre": "...", ... } }
        StringBuilder sbCampanas = new StringBuilder("{");
        for (int i = 0; i < campanas.size(); i++) {
            CampanyaDTO c = campanas.get(i);
            sbCampanas.append("\"").append(c.getIdCampanya()).append("\":{");
            sbCampanas.append("\"nombre\":\"") .append(c.getNombreCampanya()  != null ? c.getNombreCampanya()  : "").append("\",");
            sbCampanas.append("\"tipo\":\"")   .append(c.getTipoCampanya()    != null ? c.getTipoCampanya()    : "").append("\",");
            sbCampanas.append("\"estado\":\"") .append(c.getEstado()          != null ? c.getEstado()          : "").append("\",");
            sbCampanas.append("\"fechaInicio\":\"").append(c.getFechaInicio() != null ? c.getFechaInicio()      : "").append("\",");
            sbCampanas.append("\"fechaFin\":\"")   .append(c.getFechaFin()    != null ? c.getFechaFin()         : "").append("\"");
            sbCampanas.append("}");
            if (i < campanas.size() - 1) sbCampanas.append(",");
        }
        sbCampanas.append("}");

        model.addAttribute("campanas",      campanas);
        model.addAttribute("cadenas", cadenaEntities);
        model.addAttribute("cadenasJson",   sbCadenas.toString());
        model.addAttribute("campanasJson",  sbCampanas.toString());
        model.addAttribute("tiposCampanya", TIPOS_CAMPANYA);
        return "gestionCampanas";
    }

    // ── EDITAR / BORRAR CAMPAÑA ────────────────────────────────────────────

    @GetMapping("/campanas/editar")
    public String editarCampana(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("campana", campanyaService.findById(id));
        return "campana_form";
    }

    @GetMapping("/campanas/borrar")
    public String borrarCampana(@RequestParam("id") Integer id) {
        campanyaService.borrarCampana(id);
        return "redirect:/campanas";
    }

    // ── CADENAS ────────────────────────────────────────────────────────────

    @GetMapping("/campanas/cadenas/nueva")
    public String nuevaCadena(Model model) {
        model.addAttribute("cadena", new CadenaEntity());
        return "formularioCadena";
    }

    @GetMapping("/campanas/cadenas/editar")
    public String editarCadena(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("cadena", campanyaService.findCadenaById(id));
        return "formularioCadena";
    }

    @Transactional
    @PostMapping("/campanas/cadenas/guardar")
    public String guardarCadena(
            @RequestParam(value = "idCadena",      required = false) Integer idCadena,
            @RequestParam("nombreCadena")                             String  nombreCadena,
            @RequestParam(value = "resenyaCadena", required = false) String  resenyaCadena,
            @RequestParam(value = "logoUrl",       required = false) String  logoUrl) {

        campanyaService.guardarCadena(idCadena, nombreCadena, resenyaCadena, logoUrl);
        return "redirect:/campanas";
    }

    @GetMapping("/campanas/cadenas/borrar")
    public String borrarCadena(@RequestParam("id") Integer id) {
        campanyaService.borrarCadena(id);
        return "redirect:/campanas";
    }

    // ── GUARDAR TODO ───────────────────────────────────────────────────────

    @Transactional
    @PostMapping("/campanas/guardarTodo")
    public String guardarTodo(
            @RequestParam(value = "campanaId",         required = false) Integer       campanaId,
            @RequestParam(value = "campanaEditId",      required = false) Integer       campanaEditId,
            @RequestParam(value = "cadenaIds",          required = false) List<Integer> cadenaIds,
            @RequestParam(value = "cadenasBorrar",      required = false) List<Integer> cadenasBorrar,
            @RequestParam(value = "campanaNombre",      required = false) String        nombre,
            @RequestParam(value = "campanaTipo",        required = false) String        tipo,
            @RequestParam(value = "campanaEstado",      required = false) String        estado,
            @RequestParam(value = "campanaFechaInicio", required = false) String        fechaInicio,
            @RequestParam(value = "campanaFechaFin",    required = false) String        fechaFin,
            RedirectAttributes redirect) throws Exception {

        String msg = campanyaService.guardarTodo(
                campanaId, campanaEditId, cadenaIds, cadenasBorrar,
                nombre, tipo, estado, fechaInicio, fechaFin);

        if (msg != null) redirect.addFlashAttribute("msg", msg);
        return "redirect:/campanas";
    }
}