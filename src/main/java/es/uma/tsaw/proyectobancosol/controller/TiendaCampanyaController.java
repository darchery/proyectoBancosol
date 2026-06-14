/**
 * Controlador que gestiona la relación entre tiendas y campañas.
 *
 * Autores:
 * - Sergio Aldana: 96%
 * - Lucas Díaz Ruiz: 4%
 */


package es.uma.tsaw.proyectobancosol.controller;

import es.uma.tsaw.proyectobancosol.service.TiendaCampanyaService;
import es.uma.tsaw.proyectobancosol.util.SecurityUtil;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@AllArgsConstructor
@RequestMapping("/tiendacampanya")
public class TiendaCampanyaController {

    private final TiendaCampanyaService tiendaCampanyaService;

    @PostMapping("/asignar-responsables")
    public String doAsignarResponsables(@RequestParam("idTiendaCampanya") Integer idTiendaCampanya,
                                      @RequestParam("idCoordinador") Integer idCoordinador,
                                      @RequestParam("idCapitan") Integer idCapitan,
                                      HttpSession session) {
        if (!SecurityUtil.tieneRol(session, 1)) return "redirect:/sinPermisos";

        tiendaCampanyaService.asignarResponsables(idTiendaCampanya, idCoordinador, idCapitan);
        return "redirect:/tiendas";
    }

}
