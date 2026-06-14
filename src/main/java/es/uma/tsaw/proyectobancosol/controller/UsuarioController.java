/**
 * Controlador que gestiona los usuarios del sistema (voluntarios, coordinadores, capitanes, administradores).
 * Proporciona listado, creación, edición y eliminación de usuarios.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 90%
 * - Laia Díaz: 10%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.RolDTO;
import es.uma.tsaw.proyectobancosol.dto.UsuarioDTO;
import es.uma.tsaw.proyectobancosol.service.UsuarioService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/usuarios")
public class UsuarioController {

    private final UsuarioService usuarioService;


    @GetMapping("/coordinadores-capitanes")
    public String doListarCoordinadores(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        List<UsuarioDTO> coordinadores = this.usuarioService.listarCoordinadoresCapitanes(2);
        List<UsuarioDTO> capitanes = this.usuarioService.listarCoordinadoresCapitanes(3);
        List<UsuarioDTO> coordinadoresCapitanes = this.usuarioService.listarCoordinadoresCapitanes(6);


        model.addAttribute("coordinadores", coordinadores);
        model.addAttribute("capitanes", capitanes);
        model.addAttribute("coordinadoresCapitanes", coordinadoresCapitanes);

        return "gestionCoordinadorCapitan";
    }

    @GetMapping("/voluntarios")
    public String doListarVoluntarios(Model model, HttpSession session) {
        // Sólo acceden => admin, coordinador y coordinador-capitan
        if (!SecurityUtil.tieneRol(session, 1, 2, 6)) return "redirect:/sinPermisos";

        List<UsuarioDTO> voluntarios = this.usuarioService.listarVoluntarios();
        model.addAttribute("voluntarios", voluntarios);
        return "listarVoluntarios";
    }

    @GetMapping("/editarCrear")
    public String doEditarCrearUsuario(@RequestParam(value = "id", required = false) Integer id,
                                    @RequestParam(value = "idRol", required = true) Integer idRol,
                                   Model model,
                                   HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        RolDTO rolDTO = this.usuarioService.buscarRol(idRol);
        model.addAttribute("rol", rolDTO);

        if (id != null) { // Editar
            UsuarioDTO usuarioDTO = this.usuarioService.buscarOCrear(id);
            model.addAttribute("usuario", usuarioDTO);
        } // Crear
        return "editarCrearUsuario";
    }

    @PostMapping("/guardar")
    public String doGuardarUsuario(@RequestParam(value = "id", required = false) Integer id,
                                 @RequestParam(value = "idRol", required = true) Integer idRol,
                                 @RequestParam(value = "nombre", required = false) String nombre,
                                 @RequestParam(value = "email", required = false) String email,
                                 @RequestParam(value = "telefono", required = false) String telefono,
                                 @RequestParam(value = "contrasenya", required = false) String contrasenya,
                                 RedirectAttributes redirectAttributes,
                                 HttpSession session) {
        // Sólo administradores
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        if (this.usuarioService.existeEmail(email, id)) {
            redirectAttributes.addFlashAttribute("error", "email_duplicado");
            if (id != null) {
                return "redirect:/usuarios/editarCrear?id=" + id + "&idRol=" + idRol;
            } else {
                return "redirect:/usuarios/editarCrear?idRol=" + idRol;
            }
        }


        this.usuarioService.guardar(id, idRol, nombre, email, telefono, contrasenya);

        // PROVISIONAL - Debe redirigir a la página del rol
        return "redirect:/usuarios/coordinadores-capitanes";
    }

    @GetMapping("/borrar")
    public String doBorrarUsuario(@RequestParam(value = "id", required = true) Integer id, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        this.usuarioService.borrar(id);

        // PROVISIONAL - Debe redirigir a la página del rol
        return "redirect:/usuarios/coordinadores-capitanes";
    }
}
