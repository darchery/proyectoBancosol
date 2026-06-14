/**
 * Controlador que gestiona las tiendas.
 * Permite listar, crear, editar y eliminar tiendas.
 *
 * Autores:
 * - Sergio Aldana: 68%
 * - Laia Díaz: 32%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.service.TiendaService;
import es.uma.tsaw.proyectobancosol.service.CadenaService;
import es.uma.tsaw.proyectobancosol.service.DireccionService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendas")
public class TiendaController {
    private final TiendaService tiendaService;
    private final CadenaService cadenaService;
    private final DireccionService direccionService;

    @GetMapping("")
    public String doInit(Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("tiendas", tiendaService.listarTodas());

        return "gestionTienda";
    }

    @GetMapping("/editarCrear")
    public String doEditarCrear(@RequestParam(required = false) Integer id, Model model, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        model.addAttribute("tienda", tiendaService.buscarOCrear(id));
        model.addAttribute("cadenas", cadenaService.listarTodas());
        model.addAttribute("direcciones", direccionService.listarTodas());

        return "formularioTienda";
    }

    @PostMapping("/guardar")
    public String doGuardar(@RequestParam(value = "idTienda", required = false) Integer idTienda,
                            @RequestParam("nombreEstablecimiento") String nombreEstablecimiento,
                            @RequestParam("direccionEstablecimiento") String direccionEstablecimiento,
                            @RequestParam("franquicia") Boolean franquicia,
                            @RequestParam("lineales") String lineales,
                            @RequestParam("cp") String cp,
                            @RequestParam("idCadena") Integer idCadena,
                            @RequestParam(value = "idDireccion", required = false) Integer idDireccion,
                            HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        tiendaService.guardar(idTienda, nombreEstablecimiento, direccionEstablecimiento, franquicia, lineales, cp, idCadena, idDireccion);

        return "redirect:/tiendas";
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam("id") Integer id, HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        tiendaService.borrar(id);

        return "redirect:/tiendas";
    }
}