/**
 * Servicio que implementa la lógica de negocio de la relación tienda-campaña
 *
 * Autores:
 * - IA generativa: 60%
 * - Sergio Aldana: 20%
 * - Lucas Díaz: 20%
 */

package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.TiendaCampanyaRepository;
import es.uma.tsaw.proyectobancosol.dao.UsuarioRepository;
import es.uma.tsaw.proyectobancosol.entity.TiendaCampanyaEntity;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class TiendaCampanyaService {

    private final TiendaCampanyaRepository tiendaCampanyaRepository;
    private final UsuarioRepository usuarioRepository;

    public void asignarResponsables(Integer idTiendaCampanya, Integer idCoordinador, Integer idCapitan) {

        TiendaCampanyaEntity tiendaCampanyaEntity = tiendaCampanyaRepository.findById(idTiendaCampanya).orElse(null);

        if(tiendaCampanyaEntity != null){

            tiendaCampanyaEntity.setCoordinador(usuarioRepository.findById(idCoordinador).orElse(null));
            tiendaCampanyaEntity.setCapitan(usuarioRepository.findById(idCapitan).orElse(null));

            tiendaCampanyaRepository.save(tiendaCampanyaEntity);
        }
        
    }
}
