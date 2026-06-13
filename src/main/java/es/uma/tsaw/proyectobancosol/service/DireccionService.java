/**
 * Servicio que implementa la lógica de negocio para las direcciones.
 *
 * Autores:
 * - Sergio Aldana: 67%
 * - Daniela Calderón: 33%
 */

package es.uma.tsaw.proyectobancosol.service;
import es.uma.tsaw.proyectobancosol.dao.DireccionRepository;
import es.uma.tsaw.proyectobancosol.dto.DireccionDTO;
import es.uma.tsaw.proyectobancosol.entity.DireccionEntity;
import es.uma.tsaw.proyectobancosol.mapper.DireccionMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class DireccionService {
    private final DireccionRepository direccionRepository;
    private final DireccionMapper direccionMapper;

    public List<DireccionDTO> listarTodas() {
        return direccionMapper.toDTOList(direccionRepository.findAll());
    }

    public void actualizar(Integer idDireccion, String domicilio, String distritoLocal, String zonaGeografica) {
        DireccionEntity direccionEntity = direccionRepository.findById(idDireccion).orElse(null);
        if (direccionEntity != null) {
            direccionEntity.setDomicilio(domicilio);
            direccionEntity.setDistritoLocal(distritoLocal);
            direccionEntity.setZonaGeografica(zonaGeografica);
            direccionRepository.save(direccionEntity);
        }
    }

}