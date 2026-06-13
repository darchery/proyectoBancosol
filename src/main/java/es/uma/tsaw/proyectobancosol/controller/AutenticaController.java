package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
@AllArgsConstructor
public class AutenticaController {

    private final UsuarioRepository usuarioRepository;

    @GetMapping("/")
    public String doLogin () {
        return "login";
    }

    @GetMapping("/menu")
    public String doMenu () {
        return "menu";
    }

    @PostMapping("/autentica")
    public String doAutentica (@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               HttpSession session,
                               Model model) {
        UsuarioEntity editor = this.usuarioRepository.autheticate(username, password);
        if (editor == null) {
            model.addAttribute("error", "Usuario no encontrado o error de autenticación");
            return "login";
        } else {
            session.setAttribute("user", editor);
            return "redirect:/menu";
        }
    }

    @GetMapping("/salir")
    public String doSalir (HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}