/**
 * Controlador que gestiona las entidades colaboradoras.
 * Permite listar, crear, editar y eliminar entidades.
 *
 * Autores:
 * - Daniela Calderón: 95%
 * - IA generativa: 5%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.service.DireccionService;
import es.uma.tsaw.proyectobancosol.service.EntidadColaboradoraService;
import es.uma.tsaw.proyectobancosol.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class EntidadColaboradoraController {

    @Autowired
    private EntidadColaboradoraService entidadService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private DireccionService direccionService;

    @GetMapping("/entidades")
    public String listar(Model model) {
        model.addAttribute("entidades", entidadService.listarTodas());
        return "gestionColaboradores";
    }

    @GetMapping("/entidades/nueva")
    public String nueva(Model model) {
        model.addAttribute("entidad", new EntidadColaboradoraDTO());
        model.addAttribute("usuarios", usuarioService.listarCoordinadores());
        return "formularioEntidadColaboradora";
    }

    @GetMapping("/entidades/editar")
    public String editar(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("entidad", entidadService.buscarPorId(id));
        model.addAttribute("usuarios", usuarioService.listarCoordinadores());
        return "formularioEntidadColaboradora";
    }

    @PostMapping("/entidades/guardar")
    public String guardar(
            @RequestParam(value = "idEntidad", required = false) Integer idEntidad,
            @RequestParam("nombreEntidad") String nombreEntidad,
            @RequestParam("tipo") String tipo,
            @RequestParam("ligadoBancosol") Boolean ligadoBancosol,
            @RequestParam(value = "responsableId", required = false) Integer responsableId,
            @RequestParam(value = "direccionId", required = false) Integer direccionId,
            @RequestParam(value = "domicilio", required = false) String domicilio,
            @RequestParam(value = "distritoLocal", required = false) String distritoLocal,
            @RequestParam(value = "zonaGeografica", required = false) String zonaGeografica) {

        entidadService.guardar(idEntidad, nombreEntidad, tipo, ligadoBancosol, responsableId, direccionId);

        if (direccionId != null) {
            direccionService.actualizar(direccionId, domicilio, distritoLocal, zonaGeografica);
        }

        return "redirect:/entidades";
    }

    @GetMapping("/entidades/borrar")
    public String borrar(@RequestParam("id") Integer id) {
        entidadService.borrar(id);
        return "redirect:/entidades";
    }


}