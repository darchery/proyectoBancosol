/*
    IA: 50%
    Lucas: 50%
*/

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.*;
import es.uma.tsaw.proyectobancosol.dto.RolDTO;
import es.uma.tsaw.proyectobancosol.dto.UsuarioDTO;
import es.uma.tsaw.proyectobancosol.entity.*;
import es.uma.tsaw.proyectobancosol.mapper.RolMapper;
import es.uma.tsaw.proyectobancosol.mapper.UsuarioMapper;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class UsuarioService {
    private final UsuarioRepository usuarioRepository;
    private final UsuarioMapper usuarioMapper;

    private final RolRepository rolRepository;
    private final RolMapper rolMapper;

    private final AsignacionVoluntarioRepository asignacionVoluntarioRepository;
    private final TiendaCampanyaRepository tiendaCampanyaRepository;

    // Listar usuarios por rol
    public List<UsuarioDTO> listarPorRol(Integer rolId) {
        List<UsuarioEntity> usuarioEntities = this.usuarioRepository.findUsuarioByRolID(rolId);

        return  this.usuarioMapper.toDTOList(usuarioEntities);
    }

    // Listar coordinadores/capitanes con datos enriquecidos
    //    (entidad, area, numTiendas)
    public List<UsuarioDTO> listarCoordinadoresCapitanes(Integer rolId) {
        // Valores a usar 2(Coordinador), 3() y 6
        List<UsuarioEntity> usuarioEntities = this.usuarioRepository.findUsuarioByRolID(rolId);
        List<UsuarioDTO> usuarioDTOS = new ArrayList<>();

        for (UsuarioEntity u : usuarioEntities) {
            usuarioDTOS.add(enriquecerCoordinadorCapitan(u));
        }
        return usuarioDTOS;
    }

    // Enriquecce el meodo listarCoordinadores/Capitanes
    // Mét0do auxiliar para añadir los campos entidad, area y numTiendas a un coordinador/capitán
    private UsuarioDTO enriquecerCoordinadorCapitan(UsuarioEntity usuarioEntity) {
        UsuarioDTO dto = this.usuarioMapper.toDTO(usuarioEntity);

        List<AsignacionVoluntarioEntity> asignaciones = this.asignacionVoluntarioRepository.findByUsuarioEntity(usuarioEntity);
        if (!asignaciones.isEmpty() && asignaciones.get(0).getEntidadColaboradoraEntity() != null) {
            dto.setEntidad(asignaciones.get(0).getEntidadColaboradoraEntity().getNombreEntidad());
        } else {
            dto.setEntidad("-");
        }

        List<TiendaCampanyaEntity> tiendas = this.tiendaCampanyaRepository.findByCoordinador(usuarioEntity);
        dto.setNumTiendas(tiendas.size());

        if (!tiendas.isEmpty() && tiendas.get(0).getTiendaEntity().getDireccionEntity() != null) {
            DireccionEntity direccionEntity = tiendas.get(0).getTiendaEntity().getDireccionEntity();
            if (direccionEntity.getZonaGeografica().equals("Málaga Capital")) {
                dto.setArea(direccionEntity.getDistritoLocal());
            } else {
                dto.setArea(direccionEntity.getZonaGeografica());
            }
        } else {
            dto.setArea("-");
        }

        return dto;
    }


    // Buscar usuario por id (o crear vacío si null)
    public UsuarioDTO buscarOCrear(Integer id) {
        if (id == null) {
            return new UsuarioDTO();
        } else {
            UsuarioEntity usuarioEntity = this.usuarioRepository.findById(id).orElse(null);
            if (usuarioEntity != null) {
                return this.usuarioMapper.toDTO(usuarioEntity);
            } else {
                return null;
            }
        }
    }

    // Buscar rol (para el formulario)
    public RolDTO buscarRol(Integer idRol) {
        RolEntity rolEntity = this.rolRepository.findById(idRol).orElse(null);
        if (rolEntity != null) {
            return this.rolMapper.toDTO(rolEntity);
        }  else {
            return null;
        }
    }

    // Guardar (crear o editar)
    public void guardar(Integer id, Integer idRol, String nombre,
                              String email, String telefono, String contrasenya) {
        UsuarioEntity usuarioEntity;

        if (id == null) { // Guardar CREACIÓN
            usuarioEntity = new UsuarioEntity();
            // id_usuario se auto-genera en BD (SERIAL)
            usuarioEntity.setNombreUsuario(email.split("@")[0]);

        } else { // Guardar EDICIÓN
            usuarioEntity = this.usuarioRepository.findById(id).orElse(null);
        }

        if (usuarioEntity != null) {
            if (nombre != null) {
                usuarioEntity.setNombre(nombre);
            }
            if (email != null) {
                usuarioEntity.setEmail(email);
            }
            if (telefono != null) {
                usuarioEntity.setTelefono(telefono);
            }
            if (contrasenya != null) {
                usuarioEntity.setContrasenya(contrasenya);
            }

            RolEntity rolEntity = this.rolRepository.findById(idRol).orElseThrow();
            usuarioEntity.setRolEntity(rolEntity);
            this.usuarioRepository.save(usuarioEntity);
        }
    }

    // Borrar para coordinador, coordinadorCapitan y capitan
    public void borrar(Integer id) {
        UsuarioEntity usuarioEntity = usuarioRepository.findById(id).orElse(null);

        if (usuarioEntity != null) {
            // 1. Desvincular tiendas donde es coordinador
            List<TiendaCampanyaEntity> tiendas = this.tiendaCampanyaRepository.findByCoordinador(usuarioEntity);
            for (TiendaCampanyaEntity tc : tiendas) {
                tc.setCoordinador(null);
                this.tiendaCampanyaRepository.save(tc);
            }

            // 2. Borrar asignaciones de voluntario
            List<AsignacionVoluntarioEntity> asignaciones = this.asignacionVoluntarioRepository.findByUsuarioEntity(usuarioEntity);
            this.asignacionVoluntarioRepository.deleteAll(asignaciones);

            // 3. Borrar usuario
            this.usuarioRepository.delete(usuarioEntity);
        }
    }

    // Función para listar los voluntarios(para asignación voluntario de laia)
    public List<UsuarioDTO> listarVoluntarios() {
        List<UsuarioEntity> usuarioEntities = this.usuarioRepository.findUsuarioByRolID(4);
        if (usuarioEntities != null) {
            return this.usuarioMapper.toDTOList(usuarioEntities);
        } else {
            return null;
        }
    }
    // Función listar coordinadores
    public List<UsuarioDTO> listarCoordinadores() {
        List<UsuarioEntity> coordinadores = new ArrayList<>();
        coordinadores.addAll(this.usuarioRepository.findUsuarioByRolID(2));  // Coordinador
        coordinadores.addAll(this.usuarioRepository.findUsuarioByRolID(6));  // CoordinadorCapitan
        return this.usuarioMapper.toDTOList(coordinadores);
    }

    public boolean existeEmail(String email, Integer idUsuario) {
        UsuarioEntity existente = this.usuarioRepository.findByEmail(email);
        if (existente == null) return false;
        // Si es edición y el email es del mismo usuario, no hay conflicto
        if (idUsuario != null && existente.getIdUsuario().equals(idUsuario)) return false;
        return true; // email en uso por OTRO usuario
    }
}
