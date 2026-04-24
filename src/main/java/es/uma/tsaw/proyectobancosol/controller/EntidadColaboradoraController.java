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

}
