/**
 * DTO que transfiere los datos de un turno activo.
 *
 * Autores:
 * - IA generativa: 90%
 * - Sergio Aldana González: 10%
 */

package es.uma.tsaw.proyectobancosol.dto;

import lombok.Data;

@Data
public class TurnoActivoDTO {
    private Integer idTurnoActivo;
    private String diaFranja;
    private String fecha;
    private Integer idTienda;
}
