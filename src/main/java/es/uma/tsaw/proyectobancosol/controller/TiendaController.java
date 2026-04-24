package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepositorio;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.List;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendas")
public class TiendaController {
    private final TiendaRepositorio tiendaRepository;
    private final TiendaCampanyaRepositorio tiendaCampanyaRepository;
    private final UsuarioController usuarioRepository;

    @GetMapping("/")
    public String listarTienda (Model model){
        model.addAttribute("tiendas", tiendaRepository.findAll());
        return "tiendas";
    }

    @GetMapping("/asignacion-campanya")
    public String asignacionCampanya (Model model){}
}
