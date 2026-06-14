/**
 * Controlador que gestiona las entidades colaboradoras.
 * Permite listar, crear, editar y eliminar entidades.
 *
 * Autores:
 * - Daniela Calderón: 60%
 * - Sergio Aldana: 20%
 * - Lucas Díaz: 20%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.service.DireccionService;
import es.uma.tsaw.proyectobancosol.service.EntidadColaboradoraService;
import es.uma.tsaw.proyectobancosol.service.UsuarioService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@AllArgsConstructor
public class EntidadColaboradoraController {

    private final EntidadColaboradoraService entidadService;

    private final UsuarioService usuarioService;

    private final DireccionService direccionService;

    @GetMapping("/entidades")
    public String doListar(Model model, HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        model.addAttribute("entidades", entidadService.listarTodas());
        return "gestionColaboradores";
    }

    @GetMapping("/entidades/nueva")
    public String doNueva(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("entidad", new EntidadColaboradoraDTO());
        model.addAttribute("usuarios", usuarioService.listarCoordinadores());
        return "formularioEntidadColaboradora";
    }

    @GetMapping("/entidades/editar")
    public String doEditar(@RequestParam("id") Integer id, Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("entidad", entidadService.buscarPorId(id));
        model.addAttribute("usuarios", usuarioService.listarCoordinadores());
        return "formularioEntidadColaboradora";
    }

    @PostMapping("/entidades/guardar")
    public String doGuardar(
            @RequestParam(value = "idEntidad", required = false) Integer idEntidad,
            @RequestParam("nombreEntidad") String nombreEntidad,
            @RequestParam("tipo") String tipo,
            @RequestParam(value = "ligadoBancosol", required = false) Boolean ligadoBancosol,
            @RequestParam(value = "responsableId", required = false) Integer responsableId,
            @RequestParam(value = "direccionId", required = false) Integer direccionId,
            @RequestParam(value = "domicilio", required = false) String domicilio,
            @RequestParam(value = "distritoLocal", required = false) String distritoLocal,
            @RequestParam(value = "zonaGeografica", required = false) String zonaGeografica,
            @RequestParam(value = "observaciones", required = false) String observaciones,
            HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        if (direccionId == null && domicilio != null && !domicilio.trim().isEmpty()) {
            direccionId = direccionService.crear(domicilio, distritoLocal, zonaGeografica);
        } else if (direccionId != null) {
            direccionService.actualizar(direccionId, domicilio, distritoLocal, zonaGeografica);
        }

        entidadService.guardar(idEntidad, nombreEntidad, tipo, ligadoBancosol, responsableId, direccionId, observaciones);

        return "redirect:/entidades";
    }

    @GetMapping("/entidades/borrar")
    public String doBorrar(@RequestParam("id") Integer id, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        entidadService.borrar(id);
        return "redirect:/entidades";
    }


}