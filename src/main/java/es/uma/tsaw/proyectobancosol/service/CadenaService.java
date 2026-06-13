/**
 * Servicio que implementa la lógica de negocio para las cadenas de tiendas.
 *
 * Autores:
 * - IA Generativa: 20 %
 * - Sergio Aldana: 80%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepository;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepository;
import es.uma.tsaw.proyectobancosol.dto.CadenaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import es.uma.tsaw.proyectobancosol.entity.CampanyaEntity;
import es.uma.tsaw.proyectobancosol.mapper.CadenaMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class CadenaService {
    private final CadenaRepository cadenaRepository;
    private final CampanyaRepository campanyaRepository;
    private final CadenaMapper cadenaMapper;

    public List<CadenaDTO> listarTodas() {
        return cadenaMapper.toDTOList(cadenaRepository.findAll());
    }

    public CadenaDTO buscarOCrear(Integer id) {
        if (id == null) return new CadenaDTO();
        return cadenaMapper.toDTO(cadenaRepository.findById(id).orElse(null));
    }

    public void guardar(CadenaDTO dto) {
        CadenaEntity entity = (dto.getIdCadena() == null)
                ? new CadenaEntity()
                : cadenaRepository.findById(dto.getIdCadena())
                    .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + dto.getIdCadena()));
        entity.setNombreCadena(dto.getNombreCadena());
        entity.setResenyaCadena(dto.getResenyaCadena());
        entity.setLogoUrl(dto.getLogoUrl());
        cadenaRepository.save(entity);
    }

    public void borrar(Integer id) {
        List<CampanyaEntity> todasCampanas = campanyaRepository.findAll();
        for (CampanyaEntity camp : todasCampanas) {
            camp.getCadenasParticipantes().removeIf(c -> c.getIdCadena().equals(id));
            campanyaRepository.save(camp);
        }
        cadenaRepository.deleteById(id);
    }
}
