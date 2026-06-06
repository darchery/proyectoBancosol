package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.ContactoDTO;
import es.uma.tsaw.proyectobancosol.entity.Contacto;
import org.springframework.stereotype.Component;

@Component
public class ContactoMapper extends MapperDTO<ContactoDTO, Contacto> {

    @Override
    public ContactoDTO toDTO(Contacto contacto) {
        ContactoDTO dto = new ContactoDTO();
        dto.setIdContacto(contacto.getIdContacto());
        dto.setIdEntidad(contacto.getEntidad().getIdEntidad());
        dto.setNombre(contacto.getNombre());
        dto.setEmail(contacto.getEmail());
        dto.setTelefono(contacto.getTelefono());
        dto.setEsPrincipal(contacto.getEsPrincipal());
        return dto;
    }
}