/**
 * Mapper que convierte entre entidad Turno Activo y su DTO.
 *
 * Autores:
 * - IA generativa: 50%
 * - Sergio Aldana González: 50%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.TurnoActivoDTO;
import es.uma.tsaw.proyectobancosol.entity.TurnoActivoEntity;
import org.springframework.stereotype.Component;

@Component
public class TurnoActivoMapper extends MapperDTO<TurnoActivoDTO, TurnoActivoEntity> {

    @Override
    public TurnoActivoDTO toDTO(TurnoActivoEntity entity) {
        TurnoActivoDTO dto = new TurnoActivoDTO();
        dto.setIdTurnoActivo(entity.getIdTurnoActivo());

        String dia = "";
        String franja = "";

        if (entity.getPlantillaTurnoEntity() != null) {
            if (entity.getPlantillaTurnoEntity().getDiaSemana() != null)
                dia = entity.getPlantillaTurnoEntity().getDiaSemana();
            if (entity.getPlantillaTurnoEntity().getFranjaHoraria() != null)
                franja = entity.getPlantillaTurnoEntity().getFranjaHoraria();
        }
        dto.setDiaFranja((dia + " " + franja).trim());

        dto.setFecha(entity.getFechaExacta() != null ? entity.getFechaExacta().toString() : "");

        if (entity.getTiendaCampanyaEntity() != null
                && entity.getTiendaCampanyaEntity().getTiendaEntity() != null) {
            dto.setIdTienda(entity.getTiendaCampanyaEntity().getTiendaEntity().getIdTienda());
        }

        return dto;
    }
}
