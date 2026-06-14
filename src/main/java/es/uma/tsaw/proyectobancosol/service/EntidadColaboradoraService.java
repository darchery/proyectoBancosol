/**
 * Servicio que implementa la lógica de negocio para las entidades colaboradoras.
 *
 * Autores:
 * - Daniela Calderón: 60%
 * - Lucas Díaz: 40%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.DireccionRepository;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepository;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.entity.ContactoEntity;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import es.uma.tsaw.proyectobancosol.mapper.EntidadColaboradoraMapper;
import java.util.List;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class EntidadColaboradoraService {

    private final EntidadColaboradoraRepository entidadRepo;
    private final UsuarioRepository usuarioRepo;
    private final DireccionRepository direccionRepo;
    private final EntidadColaboradoraMapper mapper;

    public List<EntidadColaboradoraDTO> listarTodas() {
        return mapper.toDTOList(entidadRepo.findAll(Sort.by(Sort.Direction.ASC, "idEntidad")));
    }

    public EntidadColaboradoraDTO buscarPorId(Integer id) {
        return mapper.toDTO(entidadRepo.findById(id).get());
    }

    public void guardar(Integer idEntidad, String nombreEntidad, String tipo,
                        Boolean ligadoBancosol, Integer responsableId, Integer direccionId,
                        String observaciones) {

        EntidadColaboradoraEntity entidad = (idEntidad == null)
                ? new EntidadColaboradoraEntity()
                : entidadRepo.findById(idEntidad).get();

        entidad.setNombreEntidad(nombreEntidad);
        entidad.setTipo(tipo);
        entidad.setLigadoBancosol(ligadoBancosol);
        entidad.setObservaciones(observaciones);

        if (responsableId != null) {
            entidad.setResponsable(usuarioRepo.findById(responsableId).get());
        }
        if (direccionId != null) {
            entidad.setDireccionEntity(direccionRepo.findById(direccionId).get());
        }

        if (idEntidad == null && responsableId != null) {
            var responsable = usuarioRepo.findById(responsableId).get();
            ContactoEntity contacto = new ContactoEntity();

            contacto.setEntidad(entidad);
            contacto.setNombre(responsable.getNombre());
            contacto.setEmail(responsable.getEmail());
            contacto.setTelefono(responsable.getTelefono());
            contacto.setEsPrincipal(true);
            entidad.setContactoEntities(List.of(contacto));
        }

        entidadRepo.save(entidad);
    }

    public void borrar(Integer id) {
        entidadRepo.deleteById(id);
    }
}