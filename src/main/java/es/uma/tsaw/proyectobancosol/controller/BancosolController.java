package es.uma.tsaw.proyectobancosol.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BancosolController {

    @GetMapping("/prueba")
    public String prueba() {
        return "prueba";
    }

    @GetMapping("/gestionTienda")
    public String gestionTienda() {
        return "gestionTienda";
    }
}