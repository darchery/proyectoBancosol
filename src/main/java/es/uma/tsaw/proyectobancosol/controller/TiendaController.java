package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.DireccionRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.Tienda;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanya;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendas")
public class TiendaController {

    @Autowired
    protected TiendaRepositorio tiendaRepositorio;

    @Autowired
    protected TiendaCampanyaRepositorio tiendaCampanyaRepositorio;

    @Autowired
    protected CadenaRepositorio cadenaRepositorio;

    @Autowired
    protected DireccionRepositorio direccionRepositorio;

    @GetMapping("")
    public String doInit(Model model) {
        List<Tienda> tiendas = tiendaRepositorio.findAll();
        model.addAttribute("tiendas", tiendas);
        return "gestionTienda";
    }

    @GetMapping("/editarCrear")
    public String doEditarCrear(@RequestParam(value="id", required = false) Integer id,
                                Model model) {

        Tienda tienda = null;

        if(id != null){
            tienda = tiendaRepositorio.findByIdConRelaciones(id).orElse(null);

            model.addAttribute("tienda", tienda);
            model.addAttribute("cadenas", cadenaRepositorio.findAll());
            model.addAttribute("direcciones", direccionRepositorio.findAll());
        } else{
            model.addAttribute("tienda", new Tienda());
            model.addAttribute("cadenas", cadenaRepositorio.findAll());
            model.addAttribute("direcciones", direccionRepositorio.findAll());
        }
        return "formularioTienda";
    }

    @PostMapping("/guardar")
    public String doGuardar(@ModelAttribute("tienda") Tienda tienda,
                            @RequestParam("idCadena") Integer idCadena,
                            @RequestParam(value = "idDireccion", required = false) Integer idDireccion) {

        tienda.setCadena(cadenaRepositorio.findById(idCadena).orElse(null));

        if (idDireccion != null) {
            tienda.setDireccion(direccionRepositorio.findById(idDireccion).orElse(null));
        }

        tiendaRepositorio.save(tienda);
        return "redirect:/tiendas";
    }

    @GetMapping("/borrar")
    public String doBorrar(@RequestParam("id") Integer id) {
        tiendaRepositorio.deleteById(id);
        return "redirect:/tiendas";
    }

    // --- Otros métodos existentes ---

    @GetMapping("/asignacion-campanya")
    public String verAsignaciones(@RequestParam("idCampanya") Integer idCampanya,
                                  Model model) {
        List<TiendaCampanya> asignaciones = tiendaCampanyaRepositorio.findByCampanyaIdCampanya(idCampanya);
        model.addAttribute("asignaciones", asignaciones);
        return "tiendas_por_campanya";
    }

}
