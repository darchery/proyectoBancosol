package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepository;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanyaEntity;
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

        TiendaCampanyaEntity tiendaCampanyaEntity = tiendaCampanyaRepository.findById(idTiendaCampanya).orElse(null);
        tiendaCampanyaEntity.setCoordinador(usuarioRepository.findById(idCoordinador).orElse(null));
        tiendaCampanyaEntity.setCapitan(usuarioRepository.findById(idCapitan).orElse(null));

        tiendaCampanyaRepository.save(tiendaCampanyaEntity);
        return "redirect:/tiendas";
    }

    @GetMapping("/asignacion-campanya")
    public String verAsignaciones(@RequestParam("idCampanya") Integer idCampanya,
                                  Model model) {
        List<TiendaCampanyaEntity> asignaciones = tiendaCampanyaRepository.findByCampanyaIdCampanya(idCampanya);
        model.addAttribute("asignaciones", asignaciones);
        return "tiendas_por_campanya";
    }
}
