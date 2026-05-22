package es.uma.tsaw.proyectobancosol.dto;
import lombok.Data;
@Data
public class TurnoActivoDTO {
    private Integer idTurnoActivo;
    private String fechaExacta;
    private String horaInicio;
    private String horaFin;
    private Integer plazasDisponibles;
    private Integer tiendaCampanyaId;
    private Integer plantillaTurnoId;
}