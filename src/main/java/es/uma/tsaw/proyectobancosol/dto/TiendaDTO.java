/**
 * DTO que transfiere los datos de una tienda.
 *
 * Autores:
 * - IA generativa: 100%
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