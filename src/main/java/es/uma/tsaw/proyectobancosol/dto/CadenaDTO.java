/**
 * DTO que transfiere los datos de una cadena de tiendas.
 *
 * Autores:
 *  - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;

@Data
public class CadenaDTO {
    private Integer idCadena;
    private String nombreCadena;
    private String resenyaCadena;
    private String logoUrl;
}