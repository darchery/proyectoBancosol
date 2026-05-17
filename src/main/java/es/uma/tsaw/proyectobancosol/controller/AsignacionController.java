package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/voluntarios")
@AllArgsConstructor
public class AsignacionController {

    @Autowired
    private final UsuarioRepositorio usuarioRepositorio;

    @Autowired
    private final AsignacionVoluntarioRepositorio asignacionVoluntarioRepositorio;

    @GetMapping("/listar")
    public String listar(@RequestParam Integer idUsuario, Model model) {
        Usuario usuario = usuarioRepositorio.findById(idUsuario).orElse(null);

        if (usuario == null) {
            model.addAttribute("error", "Usuario no encontrado con id: " + idUsuario);
            return "gestionVoluntarios";
        }

        List<AsignacionVoluntario> asignaciones = asignacionVoluntarioRepositorio.findByUsuario(usuario);

        model.addAttribute("usuario", usuario);
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }
}