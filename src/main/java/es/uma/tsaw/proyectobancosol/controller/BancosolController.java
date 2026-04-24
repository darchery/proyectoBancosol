package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.TiendaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import es.uma.tsaw.proyectobancosol.entity.*;

import java.util.List;

@Controller
public class BancosolController {

    @Autowired
    protected TiendaRepository tiendaRepository;

    @GetMapping("/tiendas")
    public String prueba(Model model) {
        List<Tienda> tiendas = this.tiendaRepository.findAll();
        model.addAttribute("tiendas", tiendas);

        return "prueba";
    }
}