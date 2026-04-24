package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepository;

import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.List;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendas")
public class TiendaController {
    private final TiendaRepository tiendaRepository;
    private final TiendaCampanyaRepositorio tiendaCampanyaRepository;
    private final UsuarioRepositorio usuarioRepository;

    @GetMapping("/")
    public String listarTienda (Model model){
        model.addAttribute("tiendas", tiendaRepository.findAll());
        return "tiendas";
    }

    @GetMapping("/asignacion-campanya")
    public String verAsignaciones(@RequestParam("idCampanya") Integer idCampanya, Model model) {
        List<TiendaCampanya> asignaciones = tiendaCampanyaRepository.findByCampanyaIdCampanya(idCampanya);
        model.addAttribute("asignaciones", asignaciones);
        return "tiendas_por_campanya";
    }

    //FALTA UN ASIGNAR RESPONSABLES
    @PostMapping("/asignar-responsables")
    public String asignarResponsables(@RequestParam("idTiendaCampanya") Integer idTiendaCampanya,
                                      @RequestParam("idCoordinador") UUID idCoordinador,
                                      @RequestParam("idCapitan") UUID idCapitan) {

        TiendaCampanya tiendaCampanya = tiendaCampanyaRepository.findById(idTiendaCampanya).orElseThrow();
        tiendaCampanya.setCoordinador(usuarioRepository.findById(idCoordinador).orElse(null));
        tiendaCampanya.setCapitan(usuarioRepository.findById(idCapitan).orElse(null));

        tiendaCampanyaRepository.save(tiendaCampanya);
        return "redirect:/tiendas/";
    }


}
