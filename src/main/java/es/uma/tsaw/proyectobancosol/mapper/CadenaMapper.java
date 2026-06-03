package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.CadenaDTO;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import org.springframework.stereotype.Component;

@Component
public class CadenaMapper extends MapperDTO<CadenaDTO, Cadena> {

    @Override
    public CadenaDTO toDTO(Cadena cadena) {
        CadenaDTO dto = new CadenaDTO();

        dto.setIdCadena(cadena.getIdCadena());
        dto.setNombreCadena(cadena.getNombreCadena());
        dto.setResenyaCadena(cadena.getResenyaCadena());
        dto.setLogoUrl(cadena.getLogoUrl());

        return dto;
    }
}
