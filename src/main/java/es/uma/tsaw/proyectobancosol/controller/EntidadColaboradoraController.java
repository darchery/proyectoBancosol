package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import es.uma.tsaw.proyectobancosol.service.EntidadColaboradoraService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class EntidadColaboradoraController {

    @Autowired
    private EntidadColaboradoraService entidadService;

    @Autowired
    private UsuarioRepositorio usuarioRepositorio;

    @GetMapping("/entidades")
    public String listar(Model model) {
        model.addAttribute("entidades", entidadService.listarTodas());
        return "gestionColaboradores";
    }

    @GetMapping("/entidades/nueva")
    public String nueva(Model model) {
        model.addAttribute("entidad", new EntidadColaboradoraDTO());
        List<Usuario> usuarios = this.usuarioRepositorio.findAll();
        model.addAttribute("usuarios", usuarios);
        return "entidad_form";
    }

    @PostMapping("/entidades/guardar")
    public String guardar(
            @RequestParam(value = "idEntidad", required = false) Integer idEntidad,
            @RequestParam("nombreEntidad") String nombreEntidad,
            @RequestParam("tipo") String tipo,
            @RequestParam("ligadoBancosol") Boolean ligadoBancosol,
            @RequestParam(value = "responsableId", required = false) Integer responsableId) {

        entidadService.guardar(idEntidad, nombreEntidad, tipo, ligadoBancosol, responsableId);
        return "redirect:/entidades";
    }

    @GetMapping("/entidades/editar")
    public String editar(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("entidad", entidadService.buscarPorId(id));
        List<Usuario> usuarios = this.usuarioRepositorio.findAll();
        model.addAttribute("usuarios", usuarios);
        return "entidad_form";
    }

    @GetMapping("/entidades/borrar")
    public String borrar(@RequestParam("id") Integer id) {
        entidadService.borrar(id);
        return "redirect:/entidades";
    }
}