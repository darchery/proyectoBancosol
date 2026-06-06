package es.uma.tsaw.proyectobancosol.service;
import es.uma.tsaw.proyectobancosol.dao.DireccionRepositorio;
import es.uma.tsaw.proyectobancosol.dto.DireccionDTO;
import es.uma.tsaw.proyectobancosol.entity.Direccion;
import es.uma.tsaw.proyectobancosol.mapper.DireccionMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class DireccionService {
    private final DireccionRepositorio direccionRepositorio;
    private final DireccionMapper direccionMapper;

    public List<DireccionDTO> listarTodas() {
        return direccionMapper.toDTOList(direccionRepositorio.findAll());
    }

    public void actualizar(Integer idDireccion, String domicilio, String distritoLocal, String zonaGeografica) {
        Direccion direccion = direccionRepositorio.findById(idDireccion).orElse(null);
        if (direccion != null) {
            direccion.setDomicilio(domicilio);
            direccion.setDistritoLocal(distritoLocal);
            direccion.setZonaGeografica(zonaGeografica);
            direccionRepositorio.save(direccion);
        }
    }

}