/**
 * Controlador que gestiona la relación entre tiendas y campañas.
 *
 * Autores:
 * - Sergio Aldana: 96%
 * - Lucas Díaz Ruiz: 4%
 */

package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepository;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendacampanya")
public class TiendaCampanyaController {

    @Autowired
    protected TiendaCampanyaRepository tiendaCampanyaRepository;

    @Autowired
    protected UsuarioRepository usuarioRepository;

    @PostMapping("/asignar-responsables")
    public String asignarResponsables(@RequestParam("idTiendaCampanya") Integer idTiendaCampanya,
                                      @RequestParam("idCoordinador") Integer idCoordinador,
                                      @RequestParam("idCapitan") Integer idCapitan) {

        TiendaCampanya tiendaCampanya = tiendaCampanyaRepository.findById(idTiendaCampanya).orElse(null);
        tiendaCampanya.setCoordinador(usuarioRepository.findById(idCoordinador).orElse(null));
        tiendaCampanya.setCapitan(usuarioRepository.findById(idCapitan).orElse(null));

        tiendaCampanyaRepository.save(tiendaCampanya);
        return "redirect:/tiendas";
    }

    @GetMapping("/asignacion-campanya")
    public String verAsignaciones(@RequestParam("idCampanya") Integer idCampanya,
                                  Model model) {
        List<TiendaCampanya> asignaciones = tiendaCampanyaRepository.findByCampanyaIdCampanya(idCampanya);
        model.addAttribute("asignaciones", asignaciones);
        return "tiendas_por_campanya";
    }
}
