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

    // Datos de la entidad colaboradora
    private Integer idEntidad;
    //posible modif
    private String nombreEntidad;
}