package es.uma.tsaw.proyectobancosol.controller;


import es.uma.tsaw.proyectobancosol.entity.Campanya;
import org.springframework.ui.Model;
import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.List;

@Controller
public class CampaniaControlador {

    @Autowired
    protected CampanyaRepositorio campanyaRepositorio;

    @Autowired
    protected CadenaRepositorio cadenaRepositorio;


    @GetMapping("/campanas")
    public String listar(Model model) {
        List<Campanya> campanas = this.campanyaRepositorio.findAll();
        List<Cadena> cadenas = this.cadenaRepositorio.findAll();
        model.addAttribute("campanas", campanas);
        model.addAttribute("cadenas", cadenas);
        return "gestionCampanas";
    }

    @GetMapping("/campanas/nueva")
    public String nuevaCampana(Model model) {
        model.addAttribute("campana", new Campanya());
        return "campana_form";
    }

    @PostMapping("/campanas/guardar")
    public String guardarCampana(
            @RequestParam(value = "idCampanya", required = false) Integer idCampanya,
            @RequestParam("tipoCampanya") String tipoCampanya,
            @RequestParam(value = "fechaInicio", required = false) String fechaInicio,
            @RequestParam(value = "fechaFin", required = false) String fechaFin,
            @RequestParam(value = "estado", required = false) String estado) throws Exception {

        Campanya campana = (idCampanya == null)
                ? new Campanya()
                : this.campanyaRepositorio.findById(idCampanya).get();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        campana.setTipoCampanya(tipoCampanya);
        campana.setEstado(estado);
        if (fechaInicio != null && !fechaInicio.isEmpty())
            campana.setFechaInicio(sdf.parse(fechaInicio));
        if (fechaFin != null && !fechaFin.isEmpty())
            campana.setFechaFin(sdf.parse(fechaFin));

        this.campanyaRepositorio.save(campana);
        return "redirect:/campanas";
    }

    @GetMapping("/campanas/editar")
    public String editarCampana(@RequestParam("id") Integer id, Model model) {
        Campanya campana = this.campanyaRepositorio.findById(id).get();
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

    @PostMapping("/campanas/cadenas/guardar")
    public String guardarCadena(
            @RequestParam(value = "idCadena", required = false) Integer idCadena,
            @RequestParam("nombreCadena") String nombreCadena,
            @RequestParam(value = "resenyaCadena", required = false) String resenyaCadena,
            @RequestParam(value = "logoUrl", required = false) String logoUrl) {

        Cadena cadena = (idCadena == null)
                ? new Cadena()
                : this.cadenaRepositorio.findById(idCadena).get();

        cadena.setNombreCadena(nombreCadena);
        cadena.setResenyaCadena(resenyaCadena);
        cadena.setLogoUrl(logoUrl);

        this.cadenaRepositorio.save(cadena);
        return "redirect:/campanas";
    }

    @GetMapping("/campanas/cadenas/editar")
    public String editarCadena(@RequestParam("id") Integer id, Model model) {
        Cadena cadena = this.cadenaRepositorio.findById(id).get();
        model.addAttribute("cadena", cadena);
        return "cadena_form";
    }

    @GetMapping("/campanas/cadenas/borrar")
    public String borrarCadena(@RequestParam("id") Integer id) {
        this.cadenaRepositorio.deleteById(id);
        return "redirect:/campanas";
    }

    @PostMapping("/campanas/generarCampana")
    public String generarCampana(@RequestParam("campanaId") Integer campanaId) {
        // Aquí iría la lógica de negocio
        return "redirect:/campanas";
    }









}
