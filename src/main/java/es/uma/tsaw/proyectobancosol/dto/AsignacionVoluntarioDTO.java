package es.uma.tsaw.proyectobancosol.dto;

import lombok.Data;

@Data
public class AsignacionVoluntarioDTO {
    // Datos de la asignación
    private Integer idAsignacion;
    private Boolean asistencia;

    // Datos del turno activo
    private Integer idTurnoActivo;
    private String diaFranja;
    private String fechaExacta;

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