package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.*;
import es.uma.tsaw.proyectobancosol.entity.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*PREGUNTAR
* Cuando añadimos una asignacion, podemos asignarle tmabien una tienda no? no solo el turno y la entidad colaboradora
* porque la relación no es directa: base de datos: turnoActivo- tienda camapña-tienda(acceso al nombre)*/

@Controller
@RequestMapping("/voluntarios")
@AllArgsConstructor
public class AsignacionController {

    @Autowired
    private final UsuarioRepositorio usuarioRepositorio;
    @Autowired
    private final AsignacionVoluntarioRepositorio asignacionVoluntarioRepositorio;
    @Autowired
    private final TurnoActivoRepositorio turnoActivoRepositorio;
    @Autowired
    private final EntidadColaboradoraRepositorio entidadColaboradoraRepositorio;
    @Autowired
    private final TiendaRepositorio tiendaRepositorio;


    @GetMapping("/listar")
    public String listar(@RequestParam Integer idUsuario, Model model) {
        Usuario usuario = usuarioRepositorio.findById(idUsuario).orElse(null);

        List<AsignacionVoluntario> asignaciones = asignacionVoluntarioRepositorio.findByUsuario(usuario);

        model.addAttribute("usuario", usuario);
        model.addAttribute("asignaciones", asignaciones);

        return "gestionVoluntarios";
    }

    private String editarCrear(Integer idUsuario, Integer id, Model model) {
        Usuario usuario = null;
        List<TurnoActivo> turnos = turnoActivoRepositorio.findAll();
        List<EntidadColaboradora> entidades = entidadColaboradoraRepositorio.findAll();
        //List<Tienda> tienda = tiendaRepositorio.findAll();

        if (idUsuario == null){
            usuario = new Usuario();
        } else {
            usuario = usuarioRepositorio.findById(idUsuario).get();
        }

        model.addAttribute("usuario", usuario);
        model.addAttribute("turnos", turnos);
        model.addAttribute("entidades", entidades);
        //model.addAttribute("tiendas", tienda);

        if (id != null) {
            AsignacionVoluntario asignacion = asignacionVoluntarioRepositorio.findById(id).orElse(null);
            model.addAttribute("asignacion", asignacion);
        }

        return "editarAsignacionVoluntario";
    }

    @GetMapping("/edit")
    public String doEdit(@RequestParam Integer idUsuario,
                              @RequestParam(required = false) Integer id,
                              Model model) {
        return this.editarCrear(idUsuario, id, model);
    }

    @PostMapping("/guardar")
    public String doGuardar(@RequestParam Integer idUsuario,
                            @RequestParam(required = false) Integer id,
                            @RequestParam Integer idTurno,
                            @RequestParam(required = false) Integer idEntidad,
                            @RequestParam(required = false) Boolean asistencia) {

        AsignacionVoluntario asignacion = null;

        if (id == null) {
            asignacion = new AsignacionVoluntario(); // CREAR
            Usuario usuario = usuarioRepositorio.findById(idUsuario).get();
            asignacion.setUsuario(usuario);
        } else {
            asignacion = asignacionVoluntarioRepositorio.findById(id).get(); // EDITAR
        }

        TurnoActivo turno = turnoActivoRepositorio.findById(idTurno).get();
        asignacion.setTurnoActivo(turno);

        if (idEntidad != null) {
            EntidadColaboradora entidad = entidadColaboradoraRepositorio.findById(idEntidad).orElse(null);
            asignacion.setEntidadColaboradora(entidad);
        } else {
            asignacion.setEntidadColaboradora(null);
        }

        asignacion.setAsistencia(Boolean.TRUE.equals(asistencia));

        asignacionVoluntarioRepositorio.save(asignacion);

        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }

    @GetMapping("/borrar")
    public String borrar(@RequestParam Integer id,
                         @RequestParam Integer idUsuario) {
        asignacionVoluntarioRepositorio.deleteById(id);
        return "redirect:/voluntarios/listar?idUsuario=" + idUsuario;
    }
}