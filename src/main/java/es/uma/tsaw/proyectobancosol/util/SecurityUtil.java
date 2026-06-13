/**
 * Clase que verifica si un usuario tiene el rol necesario para acceder a un recurso
 *
 * Autores:
 * - Lucas Díaz Ruiz: 50%
 * - IA generativa: 50%
 * */

package es.uma.tsaw.proyectobancosol.util;

import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import jakarta.servlet.http.HttpSession;

public class SecurityUtil {

    public static boolean tieneRol(HttpSession session, Integer... rolesPermitidos) {
        UsuarioEntity usuario = (UsuarioEntity) session.getAttribute("user");

        if (usuario == null || usuario.getRolEntity() == null) return false;
        Integer userRol = usuario.getRolEntity().getIdRol();

        // Cuando encuentra un rol que coincide => permite el acceso
        for (Integer r : rolesPermitidos) {
            if (r.equals(userRol)) return true;
        }
        return false;
    }
}