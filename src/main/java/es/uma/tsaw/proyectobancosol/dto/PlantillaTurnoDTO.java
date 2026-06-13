/**
 * DTO que transfiere los datos de una plantilla de turno.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class PlantillaTurnoDTO {
    private Integer idPlantilla;
    private String diaSemana;
    private String franjaHoraria;
}