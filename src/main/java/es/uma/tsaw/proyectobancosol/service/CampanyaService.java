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

    public void guardar(Integer idCampanya, String nombreCampanya, String tipoCampanya, String estado,
                        String fechaInicio, String fechaFin, List<Integer> cadenaIds) {
        CampanyaEntity campana;
        if (idCampanya == null) {
            List<CampanyaEntity> existentes = campanyaRepository.findByNombreCampanya(nombreCampanya.trim());
            if (!existentes.isEmpty()) {
                throw new IllegalArgumentException("Ya existe una campaña llamada \"" + nombreCampanya.trim() + "\".");
            }
            campana = new CampanyaEntity();
            campana.setNombreCampanya(nombreCampanya.trim());
        } else {
            campana = campanyaRepository.findById(idCampanya)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + idCampanya));
            if (nombreCampanya != null && !nombreCampanya.trim().isEmpty()) {
                campana.setNombreCampanya(nombreCampanya.trim());
            }
        }

        if (tipoCampanya != null) campana.setTipoCampanya(tipoCampanya);
        if (estado != null) campana.setEstado(estado);
        if (fechaInicio != null && !fechaInicio.isEmpty())
            campana.setFechaInicio(java.sql.Date.valueOf(LocalDate.parse(fechaInicio)));
        if (fechaFin != null && !fechaFin.isEmpty())
            campana.setFechaFin(java.sql.Date.valueOf(LocalDate.parse(fechaFin)));

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