/**
 * Mapper que convierte entre entidad AsignacionVoluntario y su DTO.
 *
 * Autores:
 * - Laia Díaz: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;


import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity;
import es.uma.tsaw.proyectobancosol.entity.PlantillaTurnoEntity;
import org.springframework.stereotype.Component;

@Component
public class AsignacionVoluntarioMapper extends MapperDTO<AsignacionVoluntarioDTO, AsignacionVoluntarioEntity> {


    @Override
    public AsignacionVoluntarioDTO toDTO(AsignacionVoluntarioEntity asigVol) {
        AsignacionVoluntarioDTO voluntario = new AsignacionVoluntarioDTO();

        voluntario.setIdAsignacion(asigVol.getIdAsignacion());
        voluntario.setAsistencia(asigVol.getAsistencia());

        // Turno
        voluntario.setIdTurno(asigVol.getTurnoActivoEntity().getIdTurnoActivo());
        PlantillaTurnoEntity plantilla = asigVol.getTurnoActivoEntity().getPlantillaTurnoEntity();
        if (plantilla != null) {
            voluntario.setDiaFranja(plantilla.getDiaSemana() + " " + plantilla.getFranjaHoraria());
        }
        if (asigVol.getTurnoActivoEntity().getFechaExacta() != null) {
            voluntario.setFecha(asigVol.getTurnoActivoEntity().getFechaExacta().toString());
        }

        // Tienda
        voluntario.setIdTienda(asigVol.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getIdTienda());
        voluntario.setNombreTienda(asigVol.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getNombreEstablecimiento());
        voluntario.setLocalidad(asigVol.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getDireccionEntity() != null
                ? asigVol.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getDireccionEntity().getZonaGeografica()
                : null);

        // Entidad colaboradora
        if (asigVol.getEntidadColaboradoraEntity() != null) {
            voluntario.setIdEntidad(asigVol.getEntidadColaboradoraEntity().getIdEntidad());
            voluntario.setNombreEntidad(asigVol.getEntidadColaboradoraEntity().getNombreEntidad());
        }

        return voluntario;
    }
}