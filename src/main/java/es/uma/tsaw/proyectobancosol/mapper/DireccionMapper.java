/**
 * Mapper que convierte entre entidad Direccion y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 50%
 * - IA generativa: 50%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.DireccionDTO;
import es.uma.tsaw.proyectobancosol.entity.DireccionEntity;
import org.springframework.stereotype.Component;

@Component
public class DireccionMapper extends MapperDTO<DireccionDTO, DireccionEntity> {

    @Override
    public DireccionDTO toDTO(DireccionEntity direccionEntity) {
        DireccionDTO dto = new DireccionDTO();

        dto.setIdDireccion(direccionEntity.getIdDireccion());
        dto.setDomicilio(direccionEntity.getDomicilio());
        dto.setDistritoLocal(direccionEntity.getDistritoLocal());
        dto.setZonaGeografica(direccionEntity.getZonaGeografica());

        return dto;
    }
}
