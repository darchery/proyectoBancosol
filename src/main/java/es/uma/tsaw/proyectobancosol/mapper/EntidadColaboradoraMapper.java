package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import org.springframework.stereotype.Component;

@Component
public class EntidadColaboradoraMapper extends MapperDTO<EntidadColaboradoraDTO, EntidadColaboradora> {

    @Override
    public EntidadColaboradoraDTO toDTO(EntidadColaboradora entidad) {
        EntidadColaboradoraDTO dto = new EntidadColaboradoraDTO();
        dto.setIdEntidad(entidad.getIdEntidad());
        dto.setNombreEntidad(entidad.getNombreEntidad());
        dto.setTipo(entidad.getTipo());
        dto.setLigadoBancosol(entidad.getLigadoBancosol());
        dto.setCodigoColaborador(entidad.getCodigoColaborador());
        dto.setEstadoAprobacion(entidad.getEstadoAprobacion());
        dto.setNombreContactoPrincipal(entidad.getNombreContactoPrincipal());
        dto.setTelefonoContactoPrincipal(entidad.getTelefonoContactoPrincipal());
        dto.setObservaciones(entidad.getObservaciones());

        if (entidad.getResponsable() != null) {
            dto.setResponsableId(entidad.getResponsable().getIdUsuario());  // ← idUsuario
            dto.setNombreResponsable(entidad.getResponsable().getNombre());
        }
        if (entidad.getDireccion() != null) {
            dto.setDireccionId(entidad.getDireccion().getIdDireccion());    // ← idDireccion
            dto.setDomicilio(entidad.getDireccion().getDomicilio());
            dto.setDistritoLocal(entidad.getDireccion().getDistritoLocal());
            dto.setZonaGeografica(entidad.getDireccion().getZonaGeografica());
        }
        return dto;
    }
}
