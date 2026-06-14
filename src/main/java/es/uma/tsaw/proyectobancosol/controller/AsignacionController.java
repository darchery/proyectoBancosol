/**
 * Controlador que gestiona la asignación de voluntarios a turnos.
 * Permite listar, crear, editar y eliminar asignaciones.
 *
 * Autores:
 * - Laia Díaz: 50%
 * - Lucas Díaz: 25%
 * - Daniela Calderón: 15%
 * - Sergio Aldana: 10%
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
    public String doListar(@RequestParam(required = false) Integer idUsuario, Model model, HttpSession session) {
        // Acceden coordinadores y admins
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        if (idUsuario == null) {
            return "redirect:/usuarios/voluntarios";
        }
        List<AsignacionVoluntarioDTO> asignaciones = asignacionVoluntarioService.findByUsuario(idUsuario);

        model.addAttribute("idUsuario", idUsuario);
        model.addAttribute("asignaciones", asignaciones);
        return "gestionVoluntarios";
    }

    @GetMapping("/edit")
    public String doEditarCrear(@RequestParam Integer idUsuario,
                              @RequestParam(required = false) Integer id,
                              Model model, HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

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
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        asignacionVoluntarioService.guardar(idUsuario, id, idTurno, idEntidad, asistencia);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam Integer id,
                         @RequestParam Integer idUsuario,
                         HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        asignacionVoluntarioService.borrar(id);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }

    @GetMapping("/misAsignaciones")
    public String doMisAsignaciones(@RequestParam Integer idUsuario,
                                    Model model, HttpSession session) {
        // Acceden voluntarios
        if (!SecurityUtil.tieneRol(session, 4)) return "redirect:/sinPermisos";

        List<AsignacionVoluntarioDTO> asignaciones =
                asignacionVoluntarioService.findByUsuario(idUsuario);

        model.addAttribute("asignaciones", asignaciones);
        return "misAsignaciones";
    }
}
