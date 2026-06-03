/*
    IA: 50%
    Lucas: 50%
*/

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.AsignacionVoluntarioRepositorio;
import es.uma.tsaw.proyectobancosol.dao.RolRepositorio;
import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepositorio;
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
    private final UsuarioRepositorio usuarioRepositorio;
    private final UsuarioMapper usuarioMapper;

    private final RolRepositorio rolRepositorio;
    private final RolMapper rolMapper;

    private final AsignacionVoluntarioRepositorio asignacionVoluntarioRepositorio;
    private final TiendaCampanyaRepositorio tiendaCampanyaRepositorio;

    // Listar usuarios por rol
    public List<UsuarioDTO> listarPorRol(Integer rolId) {
        List<Usuario> usuarios = this.usuarioRepositorio.findUsuarioByRolID(rolId);

        return  this.usuarioMapper.toDTOList(usuarios);
    }

    // Listar coordinadores/capitanes con datos enriquecidos
    //    (entidad, area, numTiendas)
    public List<UsuarioDTO> listarCoordinadoresCapitanes(Integer rolId) {
        // Valores a usar 2(Coordinador), 3() y 6
        List<Usuario> usuarios = this.usuarioRepositorio.findUsuarioByRolID(rolId);
        List<UsuarioDTO> usuarioDTOS = new ArrayList<>();

        for (Usuario u : usuarios) {
            usuarioDTOS.add(enriquecerCoordinadorCapitan(u));
        }
        return usuarioDTOS;
    }

    // Enriquecce el meodo listarCoordinadores/Capitanes
    // Mét0do auxiliar para añadir los campos entidad, area y numTiendas a un coordinador/capitán
    private UsuarioDTO enriquecerCoordinadorCapitan(Usuario usuario) {
        UsuarioDTO dto = this.usuarioMapper.toDTO(usuario);

        List<AsignacionVoluntario> asignaciones = this.asignacionVoluntarioRepositorio.findByUsuario(usuario);
        if (!asignaciones.isEmpty() && asignaciones.get(0).getEntidadColaboradora() != null) {
            dto.setEntidad(asignaciones.get(0).getEntidadColaboradora().getNombreEntidad());
        } else {
            dto.setEntidad("-");
        }

        List<TiendaCampanya> tiendas = this.tiendaCampanyaRepositorio.findByCoordinador(usuario);
        dto.setNumTiendas(tiendas.size());

        if (!tiendas.isEmpty() && tiendas.get(0).getTienda().getDireccion() != null) {
            Direccion direccion = tiendas.get(0).getTienda().getDireccion();
            if (direccion.getZonaGeografica().equals("Málaga Capital")) {
                dto.setArea(direccion.getDistritoLocal());
            } else {
                dto.setArea(direccion.getZonaGeografica());
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
            Usuario usuario = this.usuarioRepositorio.findById(id).orElse(null);
            if (usuario != null) {
                return this.usuarioMapper.toDTO(usuario);
            } else {
                return null;
            }
        }
    }

    // Buscar rol (para el formulario)
    public RolDTO buscarRol(Integer idRol) {
        Rol rol = this.rolRepositorio.findById(idRol).orElse(null);
        if (rol != null) {
            return this.rolMapper.toDTO(rol);
        }  else {
            return null;
        }
    }

    // Guardar (crear o editar)
    public void guardar(Integer id, Integer idRol, String nombre,
                              String email, String telefono, String contrasenya) {
        Usuario usuario;

        if (id == null) { // Guardar CREACIÓN
            usuario = new Usuario();
            // id_usuario se auto-genera en BD (SERIAL)
            usuario.setNombreUsuario(email.split("@")[0]);

        } else { // Guardar EDICIÓN
            usuario = this.usuarioRepositorio.findById(id).orElse(null);
        }

        if (usuario != null) {
            if (nombre != null) {
                usuario.setNombre(nombre);
            }
            if (email != null) {
                usuario.setEmail(email);
            }
            if (telefono != null) {
                usuario.setTelefono(telefono);
            }
            if (contrasenya != null) {
                usuario.setContrasenya(contrasenya);
            }

            Rol rol = this.rolRepositorio.findById(idRol).orElseThrow();
            usuario.setRol(rol);
            this.usuarioRepositorio.save(usuario);
        }
    }

    // Borrar para coordinador, coordinadorCapitan y capitan
    public void borrar(Integer id) {
        Usuario usuario = usuarioRepositorio.findById(id).orElse(null);

        if (usuario != null) {
            // 1. Desvincular tiendas donde es coordinador
            List<TiendaCampanya> tiendas = this.tiendaCampanyaRepositorio.findByCoordinador(usuario);
            for (TiendaCampanya tc : tiendas) {
                tc.setCoordinador(null);
                this.tiendaCampanyaRepositorio.save(tc);
            }

            // 2. Borrar asignaciones de voluntario
            List<AsignacionVoluntario> asignaciones = this.asignacionVoluntarioRepositorio.findByUsuario(usuario);
            this.asignacionVoluntarioRepositorio.deleteAll(asignaciones);

            // 3. Borrar usuario
            this.usuarioRepositorio.delete(usuario);
        }
    }

    // Función para listar los voluntarios(para asignación voluntario de laia)
    public List<UsuarioDTO> listarVoluntarios() {
        List<Usuario> usuarios = this.usuarioRepositorio.findUsuarioByRolID(4);
        if (usuarios != null) {
            return this.usuarioMapper.toDTOList(usuarios);
        } else {
            return null;
        }
    }

    public boolean existeEmail(String email, Integer idUsuario) {
        Usuario existente = this.usuarioRepositorio.findByEmail(email);
        if (existente == null) return false;
        // Si es edición y el email es del mismo usuario, no hay conflicto
        if (idUsuario != null && existente.getIdUsuario().equals(idUsuario)) return false;
        return true; // email en uso por OTRO usuario
    }
}
