/**
 * Controlador que gestiona la asignación de voluntarios a turnos.
 * Permite listar, crear, editar y eliminar asignaciones.
 *
 * Autores:
 * - Laia Díaz: 95%
 * - Sergio Aldana: 5%
 */


package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.dto.UsuarioDTO;
import es.uma.tsaw.proyectobancosol.service.AsignacionVoluntarioService;
import es.uma.tsaw.proyectobancosol.service.UsuarioService;
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
    private final UsuarioService usuarioService;

    @GetMapping("/listar")
    public String listar(@RequestParam(required = false) Integer idUsuario, Model model) {
        if (idUsuario == null) {
            return "redirect:/usuarios/voluntarios";
        }
        UsuarioDTO usuarioDTO = usuarioService.buscarOCrear(idUsuario);
        List<AsignacionVoluntarioDTO> asignaciones = asignacionVoluntarioService.findByUsuario(idUsuario);

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("nombreUsuario", usuarioDTO != null ? usuarioDTO.getNombre() : "-");
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }

    private String editarCrear(Integer idUsuario, Integer id, Model model) {
        UsuarioDTO usuarioDTO = usuarioService.buscarOCrear(idUsuario);

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("nombreUsuario", usuarioDTO != null ? usuarioDTO.getNombre() : "-");
        model.addAttribute("turnos", asignacionVoluntarioService.findAllTurnosActivos());
        model.addAttribute("entidades", asignacionVoluntarioService.findAllEntidadesColaboradoras());
        model.addAttribute("tiendas", asignacionVoluntarioService.findAllTiendas());

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
