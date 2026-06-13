/**
 * Mapper que convierte entre entidad Cadena y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 50%
 * - IA generativa: 50%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.CadenaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import org.springframework.stereotype.Component;

@Component
public class CadenaMapper extends MapperDTO<CadenaDTO, CadenaEntity> {

    @Override
    public CadenaDTO toDTO(CadenaEntity cadenaEntity) {
        CadenaDTO dto = new CadenaDTO();

        dto.setIdCadena(cadenaEntity.getIdCadena());
        dto.setNombreCadena(cadenaEntity.getNombreCadena());
        dto.setResenyaCadena(cadenaEntity.getResenyaCadena());
        dto.setLogoUrl(cadenaEntity.getLogoUrl());

        return dto;
    }
}
