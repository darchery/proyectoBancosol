package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.RolRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;

import es.uma.tsaw.proyectobancosol.entity.Rol;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import lombok.AllArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/usuarios")
public class UsuarioController {
    private final UsuarioRepositorio usuarioRepository;
    private final RolRepositorio rolRepository;

    @GetMapping("/coordinadores")
    public String listarCoordinadores(Model model) {
        List<Usuario> coordinadores = usuarioRepository.findByRolNombreRol("Coordinador");
        model.addAttribute("coordinadores", coordinadores);
        return "lista_coordinadores";
    }

    @GetMapping("/voluntarios")
    public String listarVoluntarios(Model model) {
        List<Usuario> voluntarios = usuarioRepository.findByRolNombreRol("Voluntario");
        model.addAttribute("voluntarios", voluntarios);
        return "lista_voluntarios";
    }

    @PostMapping("/guardar")
    public String guardarUsuario(@ModelAttribute Usuario usuario, @RequestParam("idRol") Integer idRol) {
        Rol rol = rolRepository.findById(idRol).orElseThrow();
        usuario.setRol(rol);
        usuarioRepository.save(usuario);
        return "redirect:/usuarios/coordinadores";
    }
}
