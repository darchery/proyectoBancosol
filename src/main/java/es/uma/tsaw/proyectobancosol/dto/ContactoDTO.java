/**
 * DTO que transfiere los datos de un contacto.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;

import lombok.Data;

@Data
public class ContactoDTO {
    private Integer idContacto;
    private Integer idEntidad;
    private String nombre;
    private String email;
    private String telefono;
    private Boolean esPrincipal;
}