/**
 * Controlador que gestiona la las cadenas.
 *
 * Autores:
 * - Sergio Aldana: 80%
 * - IA: 20 %
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.CadenaDTO;
import es.uma.tsaw.proyectobancosol.service.CadenaService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@AllArgsConstructor
@RequestMapping("/cadenas")
public class CadenaController {

    private final CadenaService cadenaService;

    @GetMapping("/nueva")
    public String doNueva(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("cadena", new CadenaDTO());
        return "formularioCadena";
    }

    @GetMapping("/editar")
    public String doEditar(@RequestParam("id") Integer id, Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("cadena", cadenaService.buscarOCrear(id));
        return "formularioCadena";
    }

    @PostMapping("/guardar")
    public String doGuardar(@ModelAttribute("cadena") CadenaDTO cadena, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        cadenaService.guardar(cadena);
        return "redirect:/campanyas";
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam("id") Integer id, RedirectAttributes redirect, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        cadenaService.borrar(id);
        redirect.addFlashAttribute("msg", "ok:Cadena eliminada correctamente.");
        return "redirect:/campanyas";
    }
}
