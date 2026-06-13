/**
 * DTO que transfiere los datos de la relación tienda-campaña.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;

@Data
public class TiendaCampanyaDTO {
    private Integer idTiendaCampanya;
    private Integer tiendaId;
    private Integer campanyaId;
    private Integer coordinadorId;
    private Integer capitanId;
}