/**
 * DTO que transfiere los datos de una asignación de voluntario.
 *
 * Autores:
 * - IA generativa: 40%
 * - Lucas Díaz: 20%
 * - Laia Díaz: 20%
 * - Sergio Aldana: 20%
 */

package es.uma.tsaw.proyectobancosol.dto;

import lombok.Data;

@Data
public class AsignacionVoluntarioDTO {
    // Datos de la asignación
    private Integer idAsignacion;
    private Boolean asistencia;

    // Datos del turno
    private Integer idTurno;
    private String diaFranja;
    private String fecha;

    // Datos de la tienda
    private Integer idTienda;
    private String nombreTienda;
    private String localidad;

    // Datos de la entidad colaboradora
    private Integer idEntidad;
    private String nombreEntidad;
}