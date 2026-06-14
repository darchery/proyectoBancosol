/**
 * Servicio que implementa la lógica de negocio para los contactos de entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 50%
 * - Lucas Díaz: 50%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.ContactoRepository;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepository;
import es.uma.tsaw.proyectobancosol.dto.ContactoDTO;
import es.uma.tsaw.proyectobancosol.entity.ContactoEntity;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import es.uma.tsaw.proyectobancosol.mapper.ContactoMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ContactoService {

    private final ContactoRepository contactoRepo;
    private final EntidadColaboradoraRepository entidadRepo;
    private final ContactoMapper mapper;

    public List<ContactoDTO> listarPorEntidad(Integer idEntidad) {
        EntidadColaboradoraEntity entidad = entidadRepo.findById(idEntidad).get();
        return mapper.toDTOList(contactoRepo.findByEntidad(entidad));
    }

    public void guardar(Integer idContacto, Integer idEntidad, String nombre,
                        String email, String telefono, Boolean esPrincipal) {

        ContactoEntity contactoEntity = (idContacto == null)
                ? new ContactoEntity()
                : contactoRepo.findById(idContacto).get();

        EntidadColaboradoraEntity entidad = entidadRepo.findById(idEntidad).get();
        contactoEntity.setEntidad(entidad);
        contactoEntity.setNombre(nombre);
        contactoEntity.setEmail(email);
        contactoEntity.setTelefono(telefono);
        contactoEntity.setEsPrincipal(esPrincipal != null ? esPrincipal : false);

        contactoRepo.save(contactoEntity);
    }

    public ContactoDTO buscarPorId(Integer id) {
        return mapper.toDTO(contactoRepo.findById(id).get());
    }

    public void borrar(Integer id) {
        contactoRepo.deleteById(id);
    }
}