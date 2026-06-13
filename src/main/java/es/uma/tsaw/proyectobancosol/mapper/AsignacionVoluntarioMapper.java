/**
 * Mapper que convierte entre entidad AsignacionVoluntario y su DTO.
 *
 * Autores:
 * - Laia Díaz: 90%
 * - IA generativa: 10%
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
        AsignacionVoluntarioDTO dto = new AsignacionVoluntarioDTO();

        dto.setIdAsignacion(asigVol.getIdAsignacion());
        dto.setAsistencia(asigVol.getAsistencia());

        // Turno
        var turno = asigVol.getTurnoActivoEntity();
        dto.setIdTurno(turno.getIdTurnoActivo());

        PlantillaTurnoEntity plantilla = turno.getPlantillaTurnoEntity();
        if (plantilla != null) {
            dto.setDiaFranja(plantilla.getDiaSemana() + " " + plantilla.getFranjaHoraria());
        }
        if (turno.getFechaExacta() != null) {
            dto.setFecha(turno.getFechaExacta().toString());
        }

        // Tienda
        var tienda = turno.getTiendaCampanyaEntity().getTiendaEntity();

        dto.setIdTienda(tienda.getIdTienda());
        dto.setNombreTienda(tienda.getNombreEstablecimiento());

        if (tienda.getDireccionEntity() != null) {
            dto.setLocalidad(tienda.getDireccionEntity().getZonaGeografica());
        }

        // Entidad colaboradora
        var entidadColab = asigVol.getEntidadColaboradoraEntity();

        if (entidadColab != null) {
            dto.setIdEntidad(entidadColab.getIdEntidad());
            dto.setNombreEntidad(entidadColab.getNombreEntidad());
        }

        return dto;
    }
}