/**
 * Controlador que gestiona las campañas de recogida.
 * Permite listar, crear, editar y eliminar campañas.
 *
 * Autores:
 * - Marina Ruiz: 90 %
 * - Sergio Aldana: 10 %
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.service.CadenaService;
import es.uma.tsaw.proyectobancosol.service.CampanyaService;
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
@RequestMapping("/campanyas")
public class CampanyaController {

    private final CampanyaService campanyaService;
    private final CadenaService cadenaService;

    @GetMapping("")
    public String doInit(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        model.addAttribute("campanas", campanyaService.listarTodas());
        model.addAttribute("cadenas", cadenaService.listarTodas());
        return "gestionCampanyas";
    }

    @GetMapping("/generarCampanya")
    public String doGenerarCampanya(@RequestParam(required = false) Integer id, Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        model.addAttribute("campana", campanyaService.buscarOCrear(id));
        model.addAttribute("cadenas", cadenaService.listarTodas());
        return "formularioCampanya";
    }

    @GetMapping("/historial")
    public String doHistorial(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        model.addAttribute("campanas", campanyaService.listarTodas());
        return "historialCampanyas";
    }

    @PostMapping("/generarCampanyaConDatos")
    public String doGenerarCampanyaConDatos(@RequestParam String tipoCampanya,
                                  @RequestParam String fechaInicio,
                                  @RequestParam String fechaFin,
                                  @RequestParam(value = "cadenaIds", required = false) List<Integer> cadenaIds,
                                  RedirectAttributes redirect,
                                  HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        try {
            String anyo = fechaInicio.substring(0, 4);
            tipoCampanya = tipoCampanya.toUpperCase();
            String nombreCampanya = tipoCampanya + " " + anyo;

            campanyaService.guardar(null, nombreCampanya, tipoCampanya, "ACTIVA", fechaInicio, fechaFin, cadenaIds);
            redirect.addFlashAttribute("msg", "ok:Campaña \"" + nombreCampanya + "\" generada correctamente.");
        } catch (IllegalArgumentException e) {
            redirect.addFlashAttribute("msg", "error:" + e.getMessage());
        }
        return "redirect:/campanyas";
    }

    @PostMapping("/guardar")
    public String doGuardar(@RequestParam(value = "idCampanya", required = false) Integer idCampanya,
                            @RequestParam(value = "nombreCampanya", required = false) String nombreCampanya,
                            @RequestParam(value = "tipoCampanya", required = false) String tipoCampanya,
                            @RequestParam(value = "estado", required = false) String estado,
                            @RequestParam(value = "fechaInicio", required = false) String fechaInicio,
                            @RequestParam(value = "fechaFin", required = false) String fechaFin,
                            @RequestParam(value = "cadenaIds", required = false) List<Integer> cadenaIds,
                            @RequestParam(value = "cadenasBorrar", required = false) List<Integer> cadenasBorrar,
                            RedirectAttributes redirect,
                            HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        try {
            if (cadenasBorrar != null && !cadenasBorrar.isEmpty()) {
                campanyaService.borrarCadenas(cadenasBorrar);
            }
            campanyaService.guardar(idCampanya, nombreCampanya, tipoCampanya, estado, fechaInicio, fechaFin, cadenaIds);

            String msg = (idCampanya != null)
                    ? "ok:Cambios guardados correctamente."
                    : "ok:Campaña \"" + nombreCampanya + "\" generada correctamente.";
            redirect.addFlashAttribute("msg", msg);
        } catch (IllegalArgumentException e) {
            redirect.addFlashAttribute("msg", "error:" + e.getMessage());
        }
        return "redirect:/campanyas";
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam("id") Integer id, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";
        campanyaService.borrar(id);
        return "redirect:/campanyas";
    }
}