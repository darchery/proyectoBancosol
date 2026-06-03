package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.DireccionDTO;
import es.uma.tsaw.proyectobancosol.entity.Direccion;
import org.springframework.stereotype.Component;

@Component
public class DireccionMapper extends MapperDTO<DireccionDTO, Direccion> {

    @Override
    public DireccionDTO toDTO(Direccion direccion) {
        DireccionDTO dto = new DireccionDTO();

        dto.setIdDireccion(direccion.getIdDireccion());
        dto.setDomicilio(direccion.getDomicilio());
        dto.setDistritoLocal(direccion.getDistritoLocal());
        dto.setZonaGeografica(direccion.getZonaGeografica());

        return dto;
    }
}
