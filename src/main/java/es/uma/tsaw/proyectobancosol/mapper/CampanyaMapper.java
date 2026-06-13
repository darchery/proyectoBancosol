/**
 * Mapper que convierte entre entidad Campanya y su DTO.
 *
 * Autores:
 * - Marina Ruiz: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import es.uma.tsaw.proyectobancosol.entity.CampanyaEntity;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Component
public class CampanyaMapper extends MapperDTO<CampanyaDTO, CampanyaEntity> {

    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public CampanyaDTO toDTO(CampanyaEntity campanyaEntity) {
        CampanyaDTO dto = new CampanyaDTO();

        dto.setIdCampanya(campanyaEntity.getIdCampanya());
        dto.setNombreCampanya(campanyaEntity.getNombreCampanya());
        dto.setTipoCampanya(campanyaEntity.getTipoCampanya());
        dto.setEstado(campanyaEntity.getEstado());

        dto.setFechaInicio(campanyaEntity.getFechaInicio() != null
                ? SDF.format(campanyaEntity.getFechaInicio())
                : null);

        dto.setFechaFin(campanyaEntity.getFechaFin() != null
                ? SDF.format(campanyaEntity.getFechaFin())
                : null);

        List<Integer> cadenaIds = new ArrayList<>();
        if (campanyaEntity.getCadenasParticipantes() != null) {
            for (CadenaEntity cadenaEntity : campanyaEntity.getCadenasParticipantes()) {
                cadenaIds.add(cadenaEntity.getIdCadena());
            }
        }
        dto.setCadenaIds(cadenaIds);

        return dto;
    }
}