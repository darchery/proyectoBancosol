/**
 * Mapper que convierte entre entidad EntidadColaboradora y su DTO.
 *
 * Autores:
 * - Daniela Calderón: 100%
 */

package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity;
import org.springframework.stereotype.Component;

@Component
public class EntidadColaboradoraMapper extends MapperDTO<EntidadColaboradoraDTO, EntidadColaboradoraEntity> {

    @Override
    public EntidadColaboradoraDTO toDTO(EntidadColaboradoraEntity entidad) {
        EntidadColaboradoraDTO dto = new EntidadColaboradoraDTO();
        dto.setIdEntidad(entidad.getIdEntidad());
        dto.setNombreEntidad(entidad.getNombreEntidad());
        dto.setTipo(entidad.getTipo());
        dto.setLigadoBancosol(entidad.getLigadoBancosol());
        dto.setCodigoColaborador(entidad.getCodigoColaborador());
        dto.setEstadoAprobacion(entidad.getEstadoAprobacion());
        dto.setObservaciones(entidad.getObservaciones());

        if (entidad.getResponsable() != null) {
            dto.setResponsableId(entidad.getResponsable().getIdUsuario());  // ← idUsuario
            dto.setNombreResponsable(entidad.getResponsable().getNombre());
        }
        if (entidad.getDireccionEntity() != null) {
            dto.setDireccionId(entidad.getDireccionEntity().getIdDireccion());    // ← idDireccion
            dto.setDomicilio(entidad.getDireccionEntity().getDomicilio());
            dto.setDistritoLocal(entidad.getDireccionEntity().getDistritoLocal());
            dto.setZonaGeografica(entidad.getDireccionEntity().getZonaGeografica());
        }
        if (entidad.getContactoEntities() != null) {
            entidad.getContactoEntities().stream()
                    .filter(c -> Boolean.TRUE.equals(c.getEsPrincipal()))
                    .findFirst()
                    .ifPresent(c -> {
                        dto.setNombreContactoPrincipal(c.getNombre());
                        dto.setTelefonoContactoPrincipal(c.getTelefono());
                    });
        }
        return dto;
    }
}
