/**
 * Mapper que convierte entre entidad Usuario y su DTO.
 *
 * Autores:
 * - Lucas Díaz Ruiz: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;


import es.uma.tsaw.proyectobancosol.dto.UsuarioDTO;
import es.uma.tsaw.proyectobancosol.entity.UsuarioEntity;
import org.springframework.stereotype.Component;

@Component
public class UsuarioMapper extends MapperDTO<UsuarioDTO, UsuarioEntity>{

    @Override
    public UsuarioDTO toDTO(UsuarioEntity usuarioEntity) {
        UsuarioDTO usuarioDTO = new UsuarioDTO();

        usuarioDTO.setIdUsuario(usuarioEntity.getIdUsuario());
        usuarioDTO.setNombre(usuarioEntity.getNombre());
        usuarioDTO.setEmail(usuarioEntity.getEmail());
        usuarioDTO.setTelefono(usuarioEntity.getTelefono());
        usuarioDTO.setContrasenya(usuarioEntity.getContrasenya());
        usuarioDTO.setNombreUsuario(usuarioEntity.getNombreUsuario());

        if (usuarioEntity.getRolEntity() != null) {
            usuarioDTO.setRolId(usuarioEntity.getRolEntity().getIdRol());
            usuarioDTO.setRolNombre(usuarioEntity.getRolEntity().getNombreRol());
        }

        return usuarioDTO;
    }
}
