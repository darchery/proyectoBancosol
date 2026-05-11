package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.UUID;

@Controller
public class TiendaCampanyaController {

    @Autowired
    protected TiendaCampanyaRepositorio tiendaCampanyaRepositorio;

    @Autowired
    protected UsuarioRepositorio usuarioRepositorio;

    @PostMapping("/asignar-responsables")
    public String asignarResponsables(@RequestParam("idTiendaCampanya") Integer idTiendaCampanya,
                                      @RequestParam("idCoordinador") UUID idCoordinador,
                                      @RequestParam("idCapitan") UUID idCapitan) {

        TiendaCampanya tiendaCampanya = tiendaCampanyaRepositorio.findById(idTiendaCampanya).orElse(null);
        tiendaCampanya.setCoordinador(usuarioRepositorio.findById(idCoordinador).orElse(null));
        tiendaCampanya.setCapitan(usuarioRepositorio.findById(idCapitan).orElse(null));

        tiendaCampanyaRepositorio.save(tiendaCampanya);
        return "redirect:/tiendas";
    }

    @GetMapping("/asignacion-campanya")
    public String verAsignaciones(@RequestParam("idCampanya") Integer idCampanya,
                                  Model model) {
        List<TiendaCampanya> asignaciones = tiendaCampanyaRepositorio.findByCampanyaIdCampanya(idCampanya);
        model.addAttribute("asignaciones", asignaciones);
        return "tiendas_por_campanya";
    }
}
