package es.uma.tsaw.proyectobancosol.mapper;


import es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO;
import es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario;
import es.uma.tsaw.proyectobancosol.entity.PlantillaTurno;
import org.springframework.stereotype.Component;

@Component
public class AsignacionVoluntarioMapper extends MapperDTO<AsignacionVoluntarioDTO, AsignacionVoluntario> {


    @Override
    public AsignacionVoluntarioDTO toDTO(AsignacionVoluntario asigVol) {
        AsignacionVoluntarioDTO voluntario = new AsignacionVoluntarioDTO();

        voluntario.setIdAsignacion(asigVol.getIdAsignacion());
        voluntario.setAsistencia(asigVol.getAsistencia());

        // Turno
        voluntario.setIdTurno(asigVol.getTurnoActivo().getIdTurnoActivo());
        PlantillaTurno plantilla = asigVol.getTurnoActivo().getPlantillaTurno();
        if (plantilla != null) {
            voluntario.setDiaFranja(plantilla.getDiaSemana());
            voluntario.setDiaFranja(plantilla.getFranjaHoraria());
        }

        // Tienda
        voluntario.setIdTienda(asigVol.getTurnoActivo().getTiendaCampanya().getTienda().getIdTienda());
        voluntario.setNombreTienda(asigVol.getTurnoActivo().getTiendaCampanya().getTienda().getNombreEstablecimiento());
        voluntario.setLocalidad(asigVol.getTurnoActivo().getTiendaCampanya().getTienda().getDireccion() != null
                ? asigVol.getTurnoActivo().getTiendaCampanya().getTienda().getDireccion().getZonaGeografica()
                : null);

        // Entidad colaboradora
        if (asigVol.getEntidadColaboradora() != null) {
            voluntario.setIdEntidad(asigVol.getEntidadColaboradora().getIdEntidad());
            voluntario.setNombreEntidad(asigVol.getEntidadColaboradora().getNombreEntidad());
        }

        return voluntario;
    }
}