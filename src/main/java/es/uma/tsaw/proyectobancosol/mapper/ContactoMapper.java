/**
 * Mapper que convierte entre entidad Contacto y su DTO.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.ContactoDTO;
import es.uma.tsaw.proyectobancosol.entity.ContactoEntity;
import org.springframework.stereotype.Component;

@Component
public class ContactoMapper extends MapperDTO<ContactoDTO, ContactoEntity> {

    @Override
    public ContactoDTO toDTO(ContactoEntity contactoEntity) {
        ContactoDTO dto = new ContactoDTO();
        dto.setIdContacto(contactoEntity.getIdContacto());
        dto.setIdEntidad(contactoEntity.getEntidad().getIdEntidad());
        dto.setNombre(contactoEntity.getNombre());
        dto.setEmail(contactoEntity.getEmail());
        dto.setTelefono(contactoEntity.getTelefono());
        dto.setEsPrincipal(contactoEntity.getEsPrincipal());
        return dto;
    }
}