/**
 * Servicio que implementa la lógica de negocio para las tiendas.
 *
 * Autores:
 * - Sergio Aldana: 100%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepository;
import es.uma.tsaw.proyectobancosol.dao.DireccionRepository;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepository;
import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.entity.TiendaEntity;
import es.uma.tsaw.proyectobancosol.mapper.TiendaMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class TiendaService {

    private final TiendaRepository tiendaRepository;
    private final CadenaRepository cadenaRepository;
    private final DireccionRepository direccionRepository;
    private final TiendaMapper tiendaMapper;

    public List<TiendaDTO> listarTodas() {
        return tiendaMapper.toDTOList(tiendaRepository.findAll());
    }

    public TiendaDTO buscarOCrear(Integer id) {
        if (id == null) return new TiendaDTO();
        TiendaEntity tiendaEntity = tiendaRepository.findByIdConRelaciones(id).orElse(null);
        return tiendaMapper.toDTO(tiendaEntity);
    }

    public void guardar(Integer idTienda, String nombreEstablecimiento, String direccionEstablecimiento,
                        Boolean franquicia, String lineales, String cp,
                        Integer idCadena, Integer idDireccion) {

        TiendaEntity tiendaEntity = (idTienda == null)
                ? new TiendaEntity()
                : tiendaRepository.findById(idTienda).orElseThrow();

        tiendaEntity.setNombreEstablecimiento(nombreEstablecimiento);
        tiendaEntity.setDireccionEstablecimiento(direccionEstablecimiento);
        tiendaEntity.setFranquicia(franquicia);
        tiendaEntity.setLineales(lineales);
        tiendaEntity.setCp(cp);
        tiendaEntity.setCadenaEntity(cadenaRepository.findById(idCadena).orElse(null));

        if (idDireccion != null) {
            tiendaEntity.setDireccionEntity(direccionRepository.findById(idDireccion).orElse(null));
        }

        tiendaRepository.save(tiendaEntity);
    }

    public void borrar(Integer id) {
        tiendaRepository.deleteById(id);
    }
}
