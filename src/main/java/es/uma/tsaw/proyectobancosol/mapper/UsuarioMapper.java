package es.uma.tsaw.proyectobancosol.mapper;


import es.uma.tsaw.proyectobancosol.dto.UsuarioDTO;
import es.uma.tsaw.proyectobancosol.entity.Usuario;
import org.springframework.stereotype.Component;

@Component
public class UsuarioMapper extends MapperDTO<UsuarioDTO, Usuario>{

    @Override
    public UsuarioDTO toDTO(Usuario usuario) {
        UsuarioDTO usuarioDTO = new UsuarioDTO();

        usuarioDTO.setIdUsuario(usuario.getIdUsuario());
        usuarioDTO.setNombre(usuario.getNombre());
        usuarioDTO.setEmail(usuario.getEmail());
        usuarioDTO.setTelefono(usuario.getTelefono());
        usuarioDTO.setContrasenya(usuario.getContrasenya());
        usuarioDTO.setNombreUsuario(usuario.getNombreUsuario());

        if (usuario.getRol() != null) {
            usuarioDTO.setRolId(usuario.getRol().getIdRol());
            usuarioDTO.setRolNombre(usuario.getRol().getNombreRol());
        }

        return usuarioDTO;
    }
}
