/**
 * Mapper que convierte entre entidad Tienda y su DTO.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.entity.TiendaEntity;
import org.springframework.stereotype.Component;

@Component
public class TiendaMapper extends MapperDTO<TiendaDTO, TiendaEntity> {

    @Override
    public TiendaDTO toDTO(TiendaEntity tiendaEntity) {
        TiendaDTO dto = new TiendaDTO();

        dto.setIdTienda(tiendaEntity.getIdTienda());
        dto.setNombreEstablecimiento(tiendaEntity.getNombreEstablecimiento());
        dto.setDireccionEstablecimiento(tiendaEntity.getDireccionEstablecimiento());
        dto.setFranquicia(tiendaEntity.getFranquicia());
        dto.setLineales(tiendaEntity.getLineales());
        dto.setCp(tiendaEntity.getCp());

        if (tiendaEntity.getCadenaEntity() != null) {
            dto.setCadenaId(tiendaEntity.getCadenaEntity().getIdCadena());
        }

        if (tiendaEntity.getDireccionEntity() != null) {
            dto.setDireccionId(tiendaEntity.getDireccionEntity().getIdDireccion());
        }

        return dto;
    }
}