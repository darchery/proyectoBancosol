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
import es.uma.tsaw.proyectobancosol.service.AsignacionVoluntarioService;
import es.uma.tsaw.proyectobancosol.service.UsuarioService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
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

    @GetMapping("/listar")
    public String listar(@RequestParam(required = false) Integer idUsuario, Model model, HttpSession session) {
        // Acceden coordinadores y admins
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/menu";

        if (idUsuario == null) {
            return "redirect:/usuarios/voluntarios";
        }
        List<AsignacionVoluntarioDTO> asignaciones = asignacionVoluntarioService.findByUsuario(idUsuario);

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }

    @GetMapping("/edit")
    public String editarCrear(@RequestParam Integer idUsuario,
                              @RequestParam(required = false) Integer id,
                              Model model, HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/menu";

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("turnos", asignacionVoluntarioService.findAllTurnosActivos());
        model.addAttribute("entidades", asignacionVoluntarioService.findAllEntidadesColaboradoras());
        model.addAttribute("tiendas", asignacionVoluntarioService.findAllTiendas());

        if (id != null) {
            AsignacionVoluntarioDTO asignacion = asignacionVoluntarioService.findById(id);
            model.addAttribute("asignacion", asignacion);
        }

        return "editarAsignacionVoluntario";
    }

    @PostMapping("/guardar")
    public String doGuardar(@RequestParam Integer idUsuario,
                            @RequestParam(required = false) Integer id,
                            @RequestParam Integer idTurno,
                            @RequestParam(required = false) Integer idEntidad,
                            @RequestParam(required = false) Boolean asistencia,
                            HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/menu";

        asignacionVoluntarioService.guardar(idUsuario, id, idTurno, idEntidad, asistencia);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }

    @GetMapping("/borrar")
    public String borrar(@RequestParam Integer id,
                         @RequestParam Integer idUsuario,
                         HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/menu";

        asignacionVoluntarioService.borrar(id);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }
}
