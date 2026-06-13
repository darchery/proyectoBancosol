/**
 * DTO que transfiere los datos de un rol.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;

@Data
public class RolDTO {
    private Integer idRol;
    private String nombreRol;
}