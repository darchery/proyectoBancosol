/**
 * DTO que transfiere los datos de una dirección.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
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