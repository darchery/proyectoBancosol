package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.service.TiendaService;
import es.uma.tsaw.proyectobancosol.service.CadenaService;
import es.uma.tsaw.proyectobancosol.service.DireccionService;
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
    public String doInit(Model model) {

        model.addAttribute("tiendas", tiendaService.listarTodas());

        return "gestionTienda";
    }

    @GetMapping("/editarCrear")
    public String doEditarCrear(@RequestParam(required = false) Integer id, Model model) {

        model.addAttribute("tienda", tiendaService.buscarOCrear(id));
        model.addAttribute("cadenas", cadenaService.listarTodas());
        model.addAttribute("direcciones", direccionService.listarTodas());

        return "formularioTienda";
    }

    @PostMapping("/guardar")
    public String doGuardar(@ModelAttribute("tienda") TiendaDTO tiendaDTO,
                            @RequestParam("idCadena") Integer idCadena,
                            @RequestParam(value = "idDireccion", required = false) Integer idDireccion) {

        tiendaService.guardar(tiendaDTO, idCadena, idDireccion);

        return "redirect:/tiendas";
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam("id") Integer id) {

        tiendaService.borrar(id);

        return "redirect:/tiendas";
    }
}