package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.entity.Campanya;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import org.springframework.ui.Model;
import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepositorio;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

@Controller
public class CampaniaControlador {

    @Autowired
    protected CampanyaRepositorio campanyaRepositorio;

    @Autowired
    protected CadenaRepositorio cadenaRepositorio;

    private static final List<String> TIPOS_CAMPANYA =
            Arrays.asList("GR", "primavera");

    @GetMapping("/campanas")
    public String listar(Model model) {
        List<Campanya> campanas = this.campanyaRepositorio.findAll();
        List<Cadena>   cadenas  = this.cadenaRepositorio.findAll();

        StringBuilder sb = new StringBuilder("{");
        for (int i = 0; i < campanas.size(); i++) {
            Campanya c = campanas.get(i);
            sb.append("\"").append(c.getIdCampanya()).append("\":[");
            List<Cadena> asociadas = c.getCadenasParticipantes();
            if (asociadas != null) {
                for (int j = 0; j < asociadas.size(); j++) {
                    sb.append(asociadas.get(j).getIdCadena());
                    if (j < asociadas.size() - 1) sb.append(",");
                }
            }
            sb.append("]");
            if (i < campanas.size() - 1) sb.append(",");
        }
        sb.append("}");

        StringBuilder sbC = new StringBuilder("{");
        for (int i = 0; i < campanas.size(); i++) {
            Campanya c = campanas.get(i);
            sbC.append("\"").append(c.getIdCampanya()).append("\":{");
            sbC.append("\"nombre\":\"").append(c.getNombreCampanya()  != null ? c.getNombreCampanya()  : "").append("\",");
            sbC.append("\"tipo\":\"")  .append(c.getTipoCampanya()    != null ? c.getTipoCampanya()    : "").append("\",");
            sbC.append("\"estado\":\"").append(c.getEstado()          != null ? c.getEstado()          : "").append("\",");
            sbC.append("\"fechaInicio\":\"").append(c.getFechaInicio() != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getFechaInicio()) : "").append("\",");
            sbC.append("\"fechaFin\":\"")  .append(c.getFechaFin()    != null ? new SimpleDateFormat("yyyy-MM-dd").format(c.getFechaFin())    : "").append("\"");
            sbC.append("}");
            if (i < campanas.size() - 1) sbC.append(",");
        }
        sbC.append("}");

        model.addAttribute("campanasJson", sbC.toString());
        model.addAttribute("campanas",     campanas);
        model.addAttribute("cadenas",      cadenas);
        model.addAttribute("cadenasJson",  sb.toString());
        model.addAttribute("tiposCampanya", TIPOS_CAMPANYA);
        return "gestionCampanas";
    }

    @GetMapping("/campanas/editar")
    public String editarCampana(@RequestParam("id") Integer id, Model model) {
        Campanya campana = this.campanyaRepositorio.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + id));
        model.addAttribute("campana", campana);
        return "campana_form";
    }

    @GetMapping("/campanas/borrar")
    public String borrarCampana(@RequestParam("id") Integer id) {
        this.campanyaRepositorio.deleteById(id);
        return "redirect:/campanas";
    }

    // ── CADENAS ──

    @GetMapping("/campanas/cadenas/nueva")
    public String nuevaCadena(Model model) {
        model.addAttribute("cadena", new Cadena());
        return "cadena_form";
    }

    @Transactional
    @PostMapping("/campanas/cadenas/guardar")
    public String guardarCadena(
            @RequestParam(value = "idCadena",      required = false) Integer idCadena,
            @RequestParam("nombreCadena")                             String  nombreCadena,
            @RequestParam(value = "resenyaCadena", required = false) String  resenyaCadena,
            @RequestParam(value = "logoUrl",       required = false) String  logoUrl) {

        Cadena cadena = (idCadena == null)
                ? new Cadena()
                : this.cadenaRepositorio.findById(idCadena)
                  .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + idCadena));

        cadena.setNombreCadena(nombreCadena);
        cadena.setResenyaCadena(resenyaCadena);
        cadena.setLogoUrl(logoUrl);

        this.cadenaRepositorio.save(cadena);
        return "redirect:/campanas";
    }

    @GetMapping("/campanas/cadenas/editar")
    public String editarCadena(@RequestParam("id") Integer id, Model model) {
        Cadena cadena = this.cadenaRepositorio.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + id));
        model.addAttribute("cadena", cadena);
        return "cadena_form";
    }

    @GetMapping("/campanas/cadenas/borrar")
    public String borrarCadena(@RequestParam("id") Integer id) {
        this.cadenaRepositorio.deleteById(id);
        return "redirect:/campanas";
    }

    // ── GUARDAR TODO ──

    @Transactional
    @PostMapping("/campanas/guardarTodo")
    public String guardarTodo(
            @RequestParam(value = "campanaId",          required = false) Integer       campanaId,
            @RequestParam(value = "campanaEditId",       required = false) Integer       campanaEditId,
            @RequestParam(value = "cadenaIds",           required = false) List<Integer> cadenaIds,
            @RequestParam(value = "cadenasBorrar",       required = false) List<Integer> cadenasBorrar,
            @RequestParam(value = "campanaNombre",       required = false) String        nombre,
            @RequestParam(value = "campanaTipo",         required = false) String        tipo,
            @RequestParam(value = "campanaEstado",       required = false) String        estado,
            @RequestParam(value = "campanaFechaInicio",  required = false) String        fechaInicio,
            @RequestParam(value = "campanaFechaFin",     required = false) String        fechaFin,
            RedirectAttributes redirect
    ) throws Exception {

        // 1. Eliminar cadenas marcadas para borrar
        if (cadenasBorrar != null && !cadenasBorrar.isEmpty()) {
            this.cadenaRepositorio.deleteAllById(cadenasBorrar);
        }

        // 2. Cadenas limpias
        List<Integer> idsLimpios = new java.util.ArrayList<>();
        if (cadenaIds != null) {
            for (Integer id : cadenaIds) {
                if (cadenasBorrar == null || !cadenasBorrar.contains(id)) {
                    idsLimpios.add(id);
                }
            }
        }
        List<Cadena> cadenas = idsLimpios.isEmpty()
                ? List.of()
                : this.cadenaRepositorio.findAllById(idsLimpios);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        // 3a. Editar campaña existente
        if (campanaEditId != null) {
            Campanya campana = this.campanyaRepositorio.findById(campanaEditId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaEditId));
            if (nombre != null && !nombre.trim().isEmpty()) campana.setNombreCampanya(nombre.trim());
            if (tipo   != null) campana.setTipoCampanya(tipo);
            if (estado != null) campana.setEstado(estado);
            if (fechaInicio != null && !fechaInicio.isEmpty()) campana.setFechaInicio(sdf.parse(fechaInicio));
            if (fechaFin    != null && !fechaFin.isEmpty())    campana.setFechaFin(sdf.parse(fechaFin));
            campana.setCadenasParticipantes(cadenas);
            this.campanyaRepositorio.save(campana);
            redirect.addFlashAttribute("msg", "ok:Cambios guardados correctamente.");

            // 3b. Crear campaña nueva
        } else if (nombre != null && !nombre.trim().isEmpty()) {
            // Comprobar si ya existe una campaña con ese nombre (tipo + año)
            List<Campanya> existentes = this.campanyaRepositorio.findByNombreCampanya(nombre.trim());
            if (!existentes.isEmpty()) {
                redirect.addFlashAttribute("msg", "error:Ya existe una campaña llamada \"" + nombre.trim() + "\" este año.");
            } else {
                Campanya nueva = new Campanya();
                nueva.setNombreCampanya(nombre.trim());
                nueva.setTipoCampanya(tipo);
                nueva.setEstado(estado);
                if (fechaInicio != null && !fechaInicio.isEmpty()) nueva.setFechaInicio(sdf.parse(fechaInicio));
                if (fechaFin    != null && !fechaFin.isEmpty())    nueva.setFechaFin(sdf.parse(fechaFin));
                nueva.setCadenasParticipantes(cadenas);
                this.campanyaRepositorio.save(nueva);
                redirect.addFlashAttribute("msg", "ok:Campaña \"" + nombre.trim() + "\" generada correctamente.");
            }

            // 3c. Solo cadenas de campaña seleccionada
        } else if (campanaId != null) {
            Campanya campana = this.campanyaRepositorio.findById(campanaId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaId));
            campana.setCadenasParticipantes(cadenas);
            this.campanyaRepositorio.save(campana);
            redirect.addFlashAttribute("msg", "ok:Cambios guardados correctamente.");
        }

        return "redirect:/campanas";
    }
}