/**
 * Controlador que gestiona los contactos asociados a entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 90%
 * - IA generativa: 10%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.ContactoDTO;
import es.uma.tsaw.proyectobancosol.service.ContactoService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@AllArgsConstructor
public class ContactoController {

    private final ContactoService contactoService;

    @GetMapping("/entidades/{idEntidad}/contactos")
    public String doListar(@PathVariable Integer idEntidad, Model model, HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        model.addAttribute("contactos", contactoService.listarPorEntidad(idEntidad));
        model.addAttribute("idEntidad", idEntidad);
        return "formularioContactos";
    }

    @GetMapping("/entidades/{idEntidad}/contactos/nuevo")
    public String doNuevo(@PathVariable Integer idEntidad, Model model, HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        model.addAttribute("contacto", new ContactoDTO());
        model.addAttribute("idEntidad", idEntidad);
        return "formularioContacto";
    }

    @PostMapping("/entidades/{idEntidad}/contactos/guardar")
    public String doGuardar(
            @PathVariable Integer idEntidad,
            @RequestParam(value = "idContacto", required = false) Integer idContacto,
            @RequestParam("nombre") String nombre,
            @RequestParam("email") String email,
            @RequestParam("telefono") String telefono,
            @RequestParam(value = "esPrincipal", required = false) Boolean esPrincipal,
            HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        contactoService.guardar(idContacto, idEntidad, nombre, email, telefono, esPrincipal);
        return "redirect:/entidades/" + idEntidad + "/contactos";
    }

    @GetMapping("/entidades/{idEntidad}/contactos/editar")
    public String doEditar(@PathVariable Integer idEntidad,
                         @RequestParam("id") Integer id, Model model,
                         HttpSession session) {
        // Acceden admins y coordinadores
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        model.addAttribute("contacto", contactoService.buscarPorId(id));
        model.addAttribute("idEntidad", idEntidad);
        return "formularioContacto";
    }

    @GetMapping("/entidades/{idEntidad}/contactos/borrar")
    public String doBorrar(@PathVariable Integer idEntidad,
                         @RequestParam("id") Integer id,
                         HttpSession session) {
        // Sólo admin
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        contactoService.borrar(id);
        return "redirect:/entidades/" + idEntidad + "/contactos";
    }
}