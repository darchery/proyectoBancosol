package es.uma.tsaw.proyectobancosol.controller;

import lombok.AllArgsConstructor;
import org.springframework.ui.Model;
import java.util.List;
import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@RequestMapping("/asignacion")
public class AsignacionController {

    private final AsignacionVoluntarioRepositorio asignacionRepositorio;

    @GetMapping("/voluntarios")
    public String listarAsignaciones(Model model) {
        List<AsignacionVoluntario> asignaciones = asignacionRepositorio.findAll();
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }

}
