/**
 * DTO que transfiere los datos de una campaña.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
import java.util.List;
@Data
public class CampanyaDTO {
    private Integer idCampanya;
    private String nombreCampanya;
    private String tipoCampanya;
    private String estado;
    private String fechaInicio;
    private String fechaFin;
    private List<Integer> cadenaIds;
}