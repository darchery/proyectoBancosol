/**
 * DTO que transfiere los datos de una entidad colaboradora.
 *
 * Autores:
 * - IA generativa: 100%
 */

package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class EntidadColaboradoraDTO {
    private Integer idEntidad;
    private String nombreEntidad;
    private String tipo;
    private Boolean ligadoBancosol;
    private String codigoColaborador;
    private String fechaAlta;
    private Boolean estadoAprobacion;
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