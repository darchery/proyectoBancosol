package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.dao.RolRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;

import es.uma.tsaw.proyectobancosol.entity.*;
import lombok.AllArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.UUID;

@Controller
@AllArgsConstructor
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    protected final UsuarioRepositorio usuarioRepository;
    @Autowired
    protected final RolRepositorio rolRepository;
    @Autowired
    protected final AsignacionVoluntarioRepositorio asignacionVoluntarioRepository;
    @Autowired
    protected final TiendaCampanyaRepositorio tiendaCampanyaRepositorio;

    @GetMapping("/coordinadores-capitanes")
    public String listarCoordinadores(Model model) {
        List<Usuario> coordinadores = usuarioRepository.findUsuarioByRolID(2);

        // Enriquecer cada coordinador con sus datos
        for (Usuario coordinador : coordinadores) {
            // 1. Obtener la entidad colaboradora
            List<AsignacionVoluntario> asignaciones =
                    asignacionVoluntarioRepository.findByUsuario(coordinador);

            String entidad = "-";
            String area = "-";

            if (!asignaciones.isEmpty() && asignaciones.get(0).getEntidadColaboradora() != null) {
                entidad = asignaciones.get(0).getEntidadColaboradora().getNombreEntidad();
            }

            // 2. Obtener el área (distrito/comarca) desde las tiendas del coordinador
            List<TiendaCampanya> tiendas = tiendaCampanyaRepositorio.findByCoordinador(coordinador);

            if (!tiendas.isEmpty() && tiendas.get(0).getTienda().getDireccion() != null) {
                Direccion direccion = tiendas.get(0).getTienda().getDireccion();
               // Si es del Málaga capital => enseñamos el distrito
                if (direccion.getZonaGeografica().equals("Málaga Capital")) {
                    area = direccion.getDistritoLocal();
               } else  { // Si no, su zona geográfica
                   area = direccion.getZonaGeografica();
               }
            }

            // Guardar los atributos en el modelo
            model.addAttribute("entidad_" + coordinador.getIdUsuario(), entidad);
            model.addAttribute("area_" + coordinador.getIdUsuario(), area);
            model.addAttribute("tiendas_" + coordinador.getIdUsuario(), tiendas.size());
        }

        model.addAttribute("coordinadores", coordinadores);

        return "gestionCoordinadorCapitan";
    }

    @GetMapping("/voluntarios")
    public String listarVoluntarios(Model model) {
        List<Usuario> voluntarios = usuarioRepository.findUsuarioByRolID(4);
        model.addAttribute("voluntarios", voluntarios);
        return "lista_voluntarios";
    }

    @GetMapping("/editarCrear")
    public String editarCrearUsuario(@RequestParam(value = "id", required = false) UUID id,
                                    @RequestParam(value = "idRol", required = true) Integer idRol,
                                   Model model) {
        Usuario usuario;
        Rol rol = this.rolRepository.findById(idRol).orElse(null);
        model.addAttribute("rol", rol);

        if (id != null) { // Editar
            usuario = this.usuarioRepository.findById(id).orElse(null);
            model.addAttribute("usuario", usuario);
        } // Crear
        return "editarCrearUsuario";
    }

    @PostMapping("/guardar")
    public String guardarUsuario(@RequestParam(value = "id", required = false) UUID id,
                                @RequestParam(value = "idRol", required = true) Integer idRol,
                                @RequestParam(value = "nombre", required = false) String nombre,
                                @RequestParam(value = "email", required = false) String email,
                                @RequestParam(value = "telefono", required = false) String telefono,
                                @RequestParam(value = "contrasenya", required = false) String contrasenya) {
        Usuario usuario;

        if (id == null) { // Guardar CREACIÓN
            usuario = new Usuario();
            usuario.setIdUsuario(UUID.randomUUID());

        } else { // Guardar EDICIÓN
            usuario = this.usuarioRepository.findById(id).orElse(null);
        }

        if (usuario != null) {
            if (nombre != null) {
                usuario.setNombre(nombre);
            }
            if (email != null) {
                usuario.setEmail(email);
            }
            if (telefono != null) {
                usuario.setTelefono(telefono);
            }
            if (contrasenya != null) {
                usuario.setContrasenya(contrasenya);
            }

            Rol rol = rolRepository.findById(idRol).orElseThrow();
            usuario.setRol(rol);
            usuarioRepository.save(usuario);
        }
        // PROVISIONAL - Debe redirigir a la página del rol
        return "redirect:/usuarios/coordinadores-capitanes";
    }

    @GetMapping("/borrar")
    public String borrarUsuario(@RequestParam(value = "id", required = true) UUID id) {
        Usuario usuario = this.usuarioRepository.findById(id).orElse(null);
        if (usuario != null) {
            usuarioRepository.delete(usuario);
        }
        // PROVISIONAL - Debe redirigir a la página del rol
        return "redirect:/usuarios/coordinadores-capitanes";
    }
}
