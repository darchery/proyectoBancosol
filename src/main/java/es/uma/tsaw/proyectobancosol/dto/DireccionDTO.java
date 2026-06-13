/**
 * DTO que transfiere los datos de una dirección.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class DireccionDTO {
    private Integer idDireccion;
    private String domicilio;
    private String distritoLocal;
    private String zonaGeografica;
}