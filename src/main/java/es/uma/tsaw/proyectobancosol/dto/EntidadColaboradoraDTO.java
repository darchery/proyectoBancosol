/**
 * DTO que transfiere los datos de una entidad colaboradora.
 *
 * Autores:
 * - IA generativa: 70%
 * - Lucas Díaz Ruiz: 30%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class EntidadColaboradoraDTO {
    private Integer idEntidad;
    private String nombreEntidad;
    private String tipo;
    private Boolean ligadoBancosol;
    private String observaciones;
    private Integer responsableId;
    private String nombreResponsable;
    private Integer direccionId;
    private String domicilio;
    private String distritoLocal;
    private String zonaGeografica;
    private String nombreContactoPrincipal;
    private String telefonoContactoPrincipal;
}