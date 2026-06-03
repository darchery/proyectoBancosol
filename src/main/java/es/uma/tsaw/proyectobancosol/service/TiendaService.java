package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.DireccionRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaRepositorio;
import es.uma.tsaw.proyectobancosol.dto.TiendaDTO;
import es.uma.tsaw.proyectobancosol.entity.Tienda;
import es.uma.tsaw.proyectobancosol.mapper.TiendaMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class TiendaService {

    private final TiendaRepositorio tiendaRepositorio;
    private final CadenaRepositorio cadenaRepositorio;
    private final DireccionRepositorio direccionRepositorio;
    private final TiendaMapper tiendaMapper;

    public List<TiendaDTO> listarTodas() {
        return tiendaMapper.toDTOList(tiendaRepositorio.findAll());
    }

    public TiendaDTO buscarOCrear(Integer id) {
        if (id == null) return new TiendaDTO();
        Tienda tienda = tiendaRepositorio.findByIdConRelaciones(id).orElse(null);
        return tiendaMapper.toDTO(tienda);
    }

    public void guardar(TiendaDTO dto, Integer idCadena, Integer idDireccion) {
        Tienda tienda = (dto.getIdTienda() == null)
                ? new Tienda()
                : tiendaRepositorio.findById(dto.getIdTienda()).orElseThrow();

        tienda.setNombreEstablecimiento(dto.getNombreEstablecimiento());
        tienda.setDireccionEstablecimiento(dto.getDireccionEstablecimiento());
        tienda.setFranquicia(dto.getFranquicia());
        tienda.setLineales(dto.getLineales());
        tienda.setCp(dto.getCp());
        tienda.setCadena(cadenaRepositorio.findById(idCadena).orElse(null));

        if (idDireccion != null) {
            tienda.setDireccion(direccionRepositorio.findById(idDireccion).orElse(null));
        }

        tiendaRepositorio.save(tienda);
    }

    public void borrar(Integer id) {
        tiendaRepositorio.deleteById(id);
    }
}
