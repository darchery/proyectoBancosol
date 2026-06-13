/**
 * DTO que transfiere los datos de una plantilla de turno.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class PlantillaTurnoDTO {
    private Integer idPlantilla;
    private String diaSemana;
    private String franjaHoraria;
}