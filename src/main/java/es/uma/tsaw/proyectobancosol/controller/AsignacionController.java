package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TurnoActivoRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import es.uma.tsaw.proyectobancosol.service.AsignacionVoluntarioService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/voluntarios")
@AllArgsConstructor
public class AsignacionController {

    private final AsignacionVoluntarioService asignacionVoluntarioService;
    private final UsuarioRepositorio usuarioRepositorio;
    private final TurnoActivoRepositorio turnoActivoRepositorio;
    private final EntidadColaboradoraRepositorio entidadColaboradoraRepositorio;
    private final TiendaRepositorio tiendaRepositorio;

    @GetMapping("/listar")
    public String listar(@RequestParam Integer idUsuario, Model model) {
        Usuario usuario = usuarioRepositorio.findById(idUsuario).orElse(null);
        List<AsignacionVoluntarioDTO> asignaciones = asignacionVoluntarioService.findByUsuario(idUsuario);

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("nombreUsuario", usuario != null ? usuario.getNombre() : "-");
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }

    private String editarCrear(Integer idUsuario, Integer id, Model model) {
        Usuario usuario = usuarioRepositorio.findById(idUsuario).orElse(new Usuario());

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("nombreUsuario", usuario.getNombre());
        model.addAttribute("turnos", turnoActivoRepositorio.findAll());
        model.addAttribute("entidades", entidadColaboradoraRepositorio.findAll());
        model.addAttribute("tiendas", tiendaRepositorio.findAll());

        if (id != null) {
            AsignacionVoluntarioDTO asignacion = asignacionVoluntarioService.findById(id);
            model.addAttribute("asignacion", asignacion);
        }

        return "editarAsignacionVoluntario";
    }

    @GetMapping("/edit")
    public String doEdit(@RequestParam Integer idUsuario,
                         @RequestParam(required = false) Integer id,
                         Model model) {
        return this.editarCrear(idUsuario, id, model);
    }

    @PostMapping("/guardar")
    public String doGuardar(@RequestParam Integer idUsuario,
                            @RequestParam(required = false) Integer id,
                            @RequestParam Integer idTurno,
                            @RequestParam(required = false) Integer idEntidad,
                            @RequestParam(required = false) Boolean asistencia) {
        asignacionVoluntarioService.guardar(idUsuario, id, idTurno, idEntidad, asistencia);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }

    @GetMapping("/borrar")
    public String borrar(@RequestParam Integer id,
                         @RequestParam Integer idUsuario) {
        asignacionVoluntarioService.borrar(id);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }
}