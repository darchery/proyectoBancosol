package es.uma.tsaw.proyectobancosol.service;
import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dto.CadenaDTO;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import es.uma.tsaw.proyectobancosol.mapper.CadenaMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class CadenaService {
    private final CadenaRepositorio cadenaRepositorio;
    private final CadenaMapper cadenaMapper;

    public List<CadenaDTO> listarTodas() {
        return cadenaMapper.toDTOList(cadenaRepositorio.findAll());
    }

}
