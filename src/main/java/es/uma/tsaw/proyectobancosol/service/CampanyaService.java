/**
 * Servicio que implementa la lógica de negocio para las campañas de recogida.
 *
 * Autores:
 * - Marina Ruiz: 90 %
 * - Sergio Aldana: 10 %
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepository;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepository;
import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import es.uma.tsaw.proyectobancosol.entity.CampanyaEntity;
import es.uma.tsaw.proyectobancosol.mapper.CampanyaMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@AllArgsConstructor
public class CampanyaService {

    private final CampanyaRepository campanyaRepository;
    private final CadenaRepository cadenaRepository;
    private final CampanyaMapper campanyaMapper;

    public List<CampanyaDTO> listarTodas() {
        return campanyaMapper.toDTOList(campanyaRepository.findAll());
    }

    public CampanyaDTO buscarOCrear(Integer id) {
        if (id == null) return new CampanyaDTO();
        return campanyaRepository.findById(id)
                .map(campanyaMapper::toDTO)
                .orElse(null);
    }

    public void guardar(CampanyaDTO dto) {
        CampanyaEntity campana;
        if (dto.getIdCampanya() == null) {
            List<CampanyaEntity> existentes = campanyaRepository.findByNombreCampanya(dto.getNombreCampanya().trim());
            if (!existentes.isEmpty()) {
                throw new IllegalArgumentException("Ya existe una campaña llamada \"" + dto.getNombreCampanya().trim() + "\".");
            }
            campana = new CampanyaEntity();
            campana.setNombreCampanya(dto.getNombreCampanya().trim());
        } else {
            campana = campanyaRepository.findById(dto.getIdCampanya())
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + dto.getIdCampanya()));
            if (dto.getNombreCampanya() != null && !dto.getNombreCampanya().trim().isEmpty()) {
                campana.setNombreCampanya(dto.getNombreCampanya().trim());
            }
        }

        if (dto.getTipoCampanya() != null) campana.setTipoCampanya(dto.getTipoCampanya());
        if (dto.getEstado() != null) campana.setEstado(dto.getEstado());
        if (dto.getFechaInicio() != null && !dto.getFechaInicio().isEmpty())
            campana.setFechaInicio(java.sql.Date.valueOf(LocalDate.parse(dto.getFechaInicio())));
        if (dto.getFechaFin() != null && !dto.getFechaFin().isEmpty())
            campana.setFechaFin(java.sql.Date.valueOf(LocalDate.parse(dto.getFechaFin())));

        List<Integer> cadenaIds = dto.getCadenaIds();
        List<CadenaEntity> cadenas = (cadenaIds == null || cadenaIds.isEmpty())
                ? List.of()
                : cadenaRepository.findAllById(cadenaIds);
        campana.setCadenasParticipantes(cadenas);

        campanyaRepository.save(campana);
    }

    public void borrarCadenas(List<Integer> ids) {
        if (ids != null && !ids.isEmpty()) {
            cadenaRepository.deleteAllById(ids);
        }
    }

    public void borrar(Integer id) {
        campanyaRepository.deleteById(id);
    }
}