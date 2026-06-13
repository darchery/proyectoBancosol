/**
 * DTO que transfiere los datos de una tienda.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;

@Data
public class TiendaDTO {
    private Integer idTienda;
    private String nombreEstablecimiento;
    private String direccionEstablecimiento;
    private Boolean franquicia;
    private String lineales;
    private String cp;
    private Integer cadenaId;
    private Integer direccionId;
}