package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.ContactoRepositorio;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepositorio;
import es.uma.tsaw.proyectobancosol.dto.ContactoDTO;
import es.uma.tsaw.proyectobancosol.entity.Contacto;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import es.uma.tsaw.proyectobancosol.mapper.ContactoMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ContactoService {

    private final ContactoRepositorio contactoRepo;
    private final EntidadColaboradoraRepositorio entidadRepo;
    private final ContactoMapper mapper;

    public List<ContactoDTO> listarPorEntidad(Integer idEntidad) {
        EntidadColaboradora entidad = entidadRepo.findById(idEntidad).get();
        return mapper.toDTOList(contactoRepo.findByEntidad(entidad));
    }

    public void guardar(Integer idContacto, Integer idEntidad, String nombre,
                        String email, String telefono, Boolean esPrincipal) {

        Contacto contacto = (idContacto == null)
                ? new Contacto()
                : contactoRepo.findById(idContacto).get();

        EntidadColaboradora entidad = entidadRepo.findById(idEntidad).get();
        contacto.setEntidad(entidad);
        contacto.setNombre(nombre);
        contacto.setEmail(email);
        contacto.setTelefono(telefono);
        contacto.setEsPrincipal(esPrincipal != null ? esPrincipal : false);

        contactoRepo.save(contacto);
    }

    public ContactoDTO buscarPorId(Integer id) {
        return mapper.toDTO(contactoRepo.findById(id).get());
    }

    public void borrar(Integer id) {
        contactoRepo.deleteById(id);
    }
}