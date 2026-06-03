package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.entity.Tienda;
import org.springframework.stereotype.Component;

@Component
public class TiendaMapper extends MapperDTO<TiendaDTO, Tienda> {

    @Override
    public TiendaDTO toDTO(Tienda tienda) {
        TiendaDTO dto = new TiendaDTO();

        dto.setIdTienda(tienda.getIdTienda());
        dto.setNombreEstablecimiento(tienda.getNombreEstablecimiento());
        dto.setDireccionEstablecimiento(tienda.getDireccionEstablecimiento());
        dto.setFranquicia(tienda.getFranquicia());
        dto.setLineales(tienda.getLineales());
        dto.setCp(tienda.getCp());

        if (tienda.getCadena() != null) {
            dto.setCadenaId(tienda.getCadena().getIdCadena());
        }

        if (tienda.getDireccion() != null) {
            dto.setDireccionId(tienda.getDireccion().getIdDireccion());
        }

        return dto;
    }
}