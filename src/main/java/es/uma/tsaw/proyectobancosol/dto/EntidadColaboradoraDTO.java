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
    private String nombreContactoPrincipal;
    private String telefonoContactoPrincipal;
    private String observaciones;
    private Integer responsableId;
    private Integer direccionId;
}