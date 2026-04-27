package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Controller
public class EntidadColaboradoraController {

    @Autowired
    protected EntidadColaboradoraRepositorio entidadColaboradoraRepositorio;

    @Autowired
    protected UsuarioRepositorio usuarioRepositorio;

    @GetMapping("/entidades")
    public String listar(Model model) {
        List<EntidadColaboradora> entidades = this.entidadColaboradoraRepositorio.findAll();
        List<Usuario> usuarios = this.usuarioRepositorio.findAll();
        model.addAttribute("entidades", entidades);
        model.addAttribute("usuarios", usuarios);
        return "gestionColaboradores";
    }

    @GetMapping("/entidades/nueva")
    public String nueva(Model model) {
        model.addAttribute("entidad", new EntidadColaboradora());
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
            @RequestParam(value = "responsableId", required = false) UUID responsableId) {

        EntidadColaboradora entidad = (idEntidad == null)
                ? new EntidadColaboradora()
                : this.entidadColaboradoraRepositorio.findById(idEntidad).get();

        entidad.setNombreEntidad(nombreEntidad);
        entidad.setTipo(tipo);
        entidad.setLigadoBancosol(ligadoBancosol);

        if (responsableId != null) {
            Usuario responsable = this.usuarioRepositorio.findById(responsableId).get();
            entidad.setResponsable(responsable);
        }

        this.entidadColaboradoraRepositorio.save(entidad);
        return "redirect:/entidades";
    }

    @GetMapping("/entidades/editar")
    public String editar(@RequestParam("id") Integer id, Model model) {
        EntidadColaboradora entidad = this.entidadColaboradoraRepositorio.findById(id).get();
        List<Usuario> usuarios = this.usuarioRepositorio.findAll();
        model.addAttribute("entidad", entidad);
        model.addAttribute("usuarios", usuarios);
        return "entidad_form";
    }

    @GetMapping("/entidades/borrar")
    public String borrar(@RequestParam("id") Integer id) {
        this.entidadColaboradoraRepositorio.deleteById(id);
        return "redirect:/entidades";
    }
}