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
        //posible modif
    private String diaFranja;
    private String fecha;

    // Datos de la tienda
    private Integer idTienda;
        //posible modif
    private String nombreTienda;
    private String localidad;

    // Opción de sólo usar idUsuario y eliminar idTienda:
    // private Integer idUsuario;

    // Datos de la entidad colaboradora
    private Integer idEntidad;
    //posible modif
    private String nombreEntidad;
}