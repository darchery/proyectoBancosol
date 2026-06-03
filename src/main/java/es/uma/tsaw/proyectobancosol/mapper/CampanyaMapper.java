package es.uma.tsaw.proyectobancosol.mapper;

import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import es.uma.tsaw.proyectobancosol.entity.Campanya;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Component
public class CampanyaMapper extends MapperDTO<CampanyaDTO, Campanya> {

    private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public CampanyaDTO toDTO(Campanya campanya) {
        CampanyaDTO dto = new CampanyaDTO();

        dto.setIdCampanya(campanya.getIdCampanya());
        dto.setNombreCampanya(campanya.getNombreCampanya());
        dto.setTipoCampanya(campanya.getTipoCampanya());
        dto.setEstado(campanya.getEstado());

        dto.setFechaInicio(campanya.getFechaInicio() != null
                ? SDF.format(campanya.getFechaInicio())
                : null);

        dto.setFechaFin(campanya.getFechaFin() != null
                ? SDF.format(campanya.getFechaFin())
                : null);

        List<Integer> cadenaIds = new ArrayList<>();
        if (campanya.getCadenasParticipantes() != null) {
            for (Cadena cadena : campanya.getCadenasParticipantes()) {
                cadenaIds.add(cadena.getIdCadena());
            }
        }
        dto.setCadenaIds(cadenaIds);

        return dto;
    }
}