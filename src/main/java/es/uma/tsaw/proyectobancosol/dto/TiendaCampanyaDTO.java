/**
 * DTO que transfiere los datos de la relación tienda-campaña.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
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