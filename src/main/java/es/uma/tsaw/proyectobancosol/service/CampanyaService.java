package es.uma.tsaw.proyectobancosol.service;

import es.uma.tsaw.proyectobancosol.dao.CadenaRepositorio;
import es.uma.tsaw.proyectobancosol.dao.CampanyaRepositorio;
import es.uma.tsaw.proyectobancosol.dto.CampanyaDTO;
import es.uma.tsaw.proyectobancosol.entity.Cadena;
import es.uma.tsaw.proyectobancosol.entity.Campanya;
import es.uma.tsaw.proyectobancosol.mapper.CampanyaMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class CampanyaService {

    private final CampanyaRepositorio campanyaRepositorio;
    private final CadenaRepositorio cadenaRepositorio;
    private final CampanyaMapper campanyaMapper;

    public CampanyaService(CampanyaRepositorio campanyaRepositorio,
                           CadenaRepositorio cadenaRepositorio,
                           CampanyaMapper campanyaMapper) {
        this.campanyaRepositorio = campanyaRepositorio;
        this.cadenaRepositorio   = cadenaRepositorio;
        this.campanyaMapper      = campanyaMapper;
    }



    public List<CampanyaDTO> findAll() {
        return campanyaMapper.toDTOList(campanyaRepositorio.findAll());
    }

    public CampanyaDTO findById(Integer id) {
        return campanyaRepositorio.findById(id)
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
            cadenaRepositorio.deleteAllById(cadenasBorrar);
        }


        List<Integer> idsLimpios = new ArrayList<>();
        if (cadenaIds != null) {
            for (Integer id : cadenaIds) {
                if (cadenasBorrar == null || !cadenasBorrar.contains(id)) {
                    idsLimpios.add(id);
                }
            }
        }
        List<Cadena> cadenas = idsLimpios.isEmpty()
                ? List.of()
                : cadenaRepositorio.findAllById(idsLimpios);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


        if (campanaEditId != null) {
            Campanya campana = campanyaRepositorio.findById(campanaEditId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaEditId));
            if (nombre != null && !nombre.trim().isEmpty()) campana.setNombreCampanya(nombre.trim());
            if (tipo   != null) campana.setTipoCampanya(tipo);
            if (estado != null) campana.setEstado(estado);
            if (fechaInicio != null && !fechaInicio.isEmpty()) campana.setFechaInicio(sdf.parse(fechaInicio));
            if (fechaFin    != null && !fechaFin.isEmpty())    campana.setFechaFin(sdf.parse(fechaFin));
            campana.setCadenasParticipantes(cadenas);
            campanyaRepositorio.save(campana);
            return "ok:Cambios guardados correctamente.";


        } else if (nombre != null && !nombre.trim().isEmpty()) {
            List<Campanya> existentes = campanyaRepositorio.findByNombreCampanya(nombre.trim());
            if (!existentes.isEmpty()) {
                return "error:Ya existe una campaña llamada \"" + nombre.trim() + "\" este año.";
            }
            Campanya nueva = new Campanya();
            nueva.setNombreCampanya(nombre.trim());
            nueva.setTipoCampanya(tipo);
            nueva.setEstado(estado);
            if (fechaInicio != null && !fechaInicio.isEmpty()) nueva.setFechaInicio(sdf.parse(fechaInicio));
            if (fechaFin    != null && !fechaFin.isEmpty())    nueva.setFechaFin(sdf.parse(fechaFin));
            nueva.setCadenasParticipantes(cadenas);
            campanyaRepositorio.save(nueva);
            return "ok:Campaña \"" + nombre.trim() + "\" generada correctamente.";


        } else if (campanaId != null) {
            Campanya campana = campanyaRepositorio.findById(campanaId)
                    .orElseThrow(() -> new IllegalArgumentException("Campaña no encontrada: " + campanaId));
            campana.setCadenasParticipantes(cadenas);
            campanyaRepositorio.save(campana);
            return "ok:Cambios guardados correctamente.";
        }

        return null;
    }


    @Transactional
    public void borrarCampana(Integer id) {
        campanyaRepositorio.deleteById(id);
    }


    public List<Cadena> findAllCadenas() {
        return cadenaRepositorio.findAll();
    }

    public Cadena findCadenaById(Integer id) {
        return cadenaRepositorio.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + id));
    }

    @Transactional
    public void guardarCadena(Integer idCadena, String nombre, String resenya, String logoUrl) {
        Cadena cadena = (idCadena == null)
                ? new Cadena()
                : cadenaRepositorio.findById(idCadena)
                  .orElseThrow(() -> new IllegalArgumentException("Cadena no encontrada: " + idCadena));
        cadena.setNombreCadena(nombre);
        cadena.setResenyaCadena(resenya);
        cadena.setLogoUrl(logoUrl);
        cadenaRepositorio.save(cadena);
    }

    @Transactional
    public void borrarCadena(Integer id) {
        cadenaRepositorio.deleteById(id);
    }
}