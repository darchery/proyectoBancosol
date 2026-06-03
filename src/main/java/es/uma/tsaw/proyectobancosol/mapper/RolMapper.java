/*
    Lucas: 100%
*/

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.RolDTO;
import es.uma.tsaw.proyectobancosol.entity.Rol;
import org.springframework.stereotype.Component;

@Component
public class RolMapper extends MapperDTO<RolDTO, Rol>{
    @Override
    public RolDTO toDTO(Rol rol) {
        RolDTO rolDTO = new RolDTO();

        rolDTO.setIdRol(rol.getIdRol());
        rolDTO.setNombreRol(rol.getNombreRol());

        return rolDTO;
    }
}