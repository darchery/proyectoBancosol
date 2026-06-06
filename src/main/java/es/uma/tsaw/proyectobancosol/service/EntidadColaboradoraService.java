package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.DireccionRepositorio;
import es.uma.tsaw.proyectobancosol.dao.EntidadColaboradoraRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
import es.uma.tsaw.proyectobancosol.dto.EntidadColaboradoraDTO;
import es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora;
import es.uma.tsaw.proyectobancosol.mapper.EntidadColaboradoraMapper;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class EntidadColaboradoraService {

    private final EntidadColaboradoraRepositorio entidadRepo;
    private final UsuarioRepositorio usuarioRepo;
    private final DireccionRepositorio direccionRepo;
    private final EntidadColaboradoraMapper mapper;

    public List<EntidadColaboradoraDTO> listarTodas() {
        return mapper.toDTOList(entidadRepo.findAll(Sort.by(Sort.Direction.ASC, "idEntidad")));
    }

    public EntidadColaboradoraDTO buscarPorId(Integer id) {
        return mapper.toDTO(entidadRepo.findById(id).get());
    }

    public void guardar(Integer idEntidad, String nombreEntidad, String tipo,
                        Boolean ligadoBancosol, Integer responsableId, Integer direccionId) {

        EntidadColaboradora entidad = (idEntidad == null)
                ? new EntidadColaboradora()
                : entidadRepo.findById(idEntidad).get();

        entidad.setNombreEntidad(nombreEntidad);
        entidad.setTipo(tipo);
        entidad.setLigadoBancosol(ligadoBancosol);

        if (responsableId != null) {
            entidad.setResponsable(usuarioRepo.findById(responsableId).get());
        }
        if (direccionId != null) {
            entidad.setDireccion(direccionRepo.findById(direccionId).get());
        }

        entidadRepo.save(entidad);
    }

    public void borrar(Integer id) {
        entidadRepo.deleteById(id);
    }
}