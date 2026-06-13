package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepository;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepository;
import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.CadenaEntity;
import es.uma.tsaw.proyectobancosol.entity.CampanyaEntity;
import es.uma.tsaw.proyectobancosol.mapper.CampanyaMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class CampanyaService {

    private final CampanyaRepository campanyaRepository;
    private final CadenaRepository cadenaRepository;
    private final CampanyaMapper campanyaMapper;

    public CampanyaService(CampanyaRepository campanyaRepository,
                           CadenaRepository cadenaRepository,
                           CampanyaMapper campanyaMapper) {
        this.campanyaRepository = campanyaRepository;
        this.cadenaRepository = cadenaRepository;
        this.campanyaMapper      = campanyaMapper;
    }



    public List<CampanyaDTO> findAll() {
        return campanyaMapper.toDTOList(campanyaRepository.findAll());
    }

    public CampanyaDTO findById(Integer id) {
        return campanyaRepository.findById(id)
                .map(campanyaMapper::toDTO)
                .orElse(null);
    }


    @Transactional
    public String guardarTodo(Integer campanaId,
                              Integer campanaEditId,
                              List<Integer> cadenaIds,
                              List<Integer> cadenasBorrar,
                              String nombre,
                              String tipo,
                              String estado,
                              String fechaInicio,
                              String fechaFin) throws ParseException {


        if (cadenasBorrar != null && !cadenasBorrar.isEmpty()) {
            cadenaRepository.deleteAllById(cadenasBorrar);
        }


        List<Integer> idsLimpios = new ArrayList<>();
        if (cadenaIds != null) {
            for (Integer id : cadenaIds) {
                if (cadenasBorrar == null || !cadenasBorrar.contains(id)) {
                    idsLimpios.add(id);
                }
            }
        }
        List<CadenaEntity> cadenaEntities = idsLimpios.isEmpty()
                ? List.of()
                : cadenaRepository.findAllById(idsLimpios);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


        if (campanaEditId != null) {
            CampanyaEntity campana = campanyaRepository.findById(campanaEditId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaEditId));
            if (nombre != null && !nombre.trim().isEmpty()) campana.setNombreCampanya(nombre.trim());
            if (tipo   != null) campana.setTipoCampanya(tipo);
            if (estado != null) campana.setEstado(estado);
            if (fechaInicio != null && !fechaInicio.isEmpty()) campana.setFechaInicio(sdf.parse(fechaInicio));
            if (fechaFin    != null && !fechaFin.isEmpty())    campana.setFechaFin(sdf.parse(fechaFin));
            campana.setCadenasParticipantes(cadenaEntities);
            campanyaRepository.save(campana);
            return "ok:Cambios guardados correctamente.";


        } else if (nombre != null && !nombre.trim().isEmpty()) {
            List<CampanyaEntity> existentes = campanyaRepository.findByNombreCampanya(nombre.trim());
            if (!existentes.isEmpty()) {
                return "error:Ya existe una campaña llamada \"" + nombre.trim() + "\" este año.";
            }
            CampanyaEntity nueva = new CampanyaEntity();
            nueva.setNombreCampanya(nombre.trim());
            nueva.setTipoCampanya(tipo);
            nueva.setEstado(estado);
            if (fechaInicio != null && !fechaInicio.isEmpty()) nueva.setFechaInicio(sdf.parse(fechaInicio));
            if (fechaFin    != null && !fechaFin.isEmpty())    nueva.setFechaFin(sdf.parse(fechaFin));
            nueva.setCadenasParticipantes(cadenaEntities);
            campanyaRepository.save(nueva);
            return "ok:Campaña \"" + nombre.trim() + "\" generada correctamente.";


        } else if (campanaId != null) {
            CampanyaEntity campana = campanyaRepository.findById(campanaId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaId));
            campana.setCadenasParticipantes(cadenaEntities);
            campanyaRepository.save(campana);
            return "ok:Cambios guardados correctamente.";
        }

        return null;
    }


    @Transactional
    public void borrarCampana(Integer id) {
        campanyaRepository.deleteById(id);
    }


    public List<CadenaEntity> findAllCadenas() {
        return cadenaRepository.findAll();
    }

    public CadenaEntity findCadenaById(Integer id) {
        return cadenaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + id));
    }

    @Transactional
    public void guardarCadena(Integer idCadena, String nombre, String resenya, String logoUrl) {
        CadenaEntity cadenaEntity = (idCadena == null)
                ? new CadenaEntity()
                : cadenaRepository.findById(idCadena)
                  .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + idCadena));
        cadenaEntity.setNombreCadena(nombre);
        cadenaEntity.setResenyaCadena(resenya);
        cadenaEntity.setLogoUrl(logoUrl);
        cadenaRepository.save(cadenaEntity);
    }

    @Transactional
    public void borrarCadena(Integer id) {
        cadenaRepository.deleteById(id);
    }
}