/**
 * Mapper que convierte entre entidad Rol y su DTO.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.RolDTO;
import es.uma.tsaw.proyectobancosol.entity.RolEntity;
import org.springframework.stereotype.Component;

@Component
public class RolMapper extends MapperDTO<RolDTO, RolEntity>{
    @Override
    public RolDTO toDTO(RolEntity rolEntity) {
        RolDTO rolDTO = new RolDTO();

        rolDTO.setIdRol(rolEntity.getIdRol());
        rolDTO.setNombreRol(rolEntity.getNombreRol());

        return rolDTO;
    }
}