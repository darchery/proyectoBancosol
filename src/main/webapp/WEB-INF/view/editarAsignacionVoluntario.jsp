<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TurnoActivo" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Tienda" %>

<html>
<head>
    <title>Asignacion Voluntarios Editar/Añadir</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>

<%
    Integer idUsuario = (Integer) request.getAttribute("idUsuario");
    String nombreUsuario = (String) request.getAttribute("nombreUsuario");
    AsignacionVoluntarioDTO asignacion = (AsignacionVoluntarioDTO) request.getAttribute("asignacion");
    List<TurnoActivo> turnos = (List<TurnoActivo>) request.getAttribute("turnos");
    List<EntidadColaboradora> entidades = (List<EntidadColaboradora>) request.getAttribute("entidades");

    List<Tienda> tiendas = (List<Tienda>) request.getAttribute("tiendas");
    boolean esEdicion = (asignacion != null);

    Integer idTiendaActual = esEdicion ? asignacion.getIdTienda() : null;
    Integer idTurnoActual   = esEdicion ? asignacion.getIdTurno() : null;
    Integer idEntidadActual = esEdicion ? asignacion.getIdEntidad() : null;
%>

<h1><%= esEdicion ? "Editar" : "Añadir" %> Asignación</h1>

<p>
    Voluntario: <%= nombreUsuario %>
    (ID: <%= idUsuario %>)
</p>

<form action="/voluntarios/guardar" method="post">

    <input type="hidden" name="idUsuario" value="<%= idUsuario %>">
    <input type="hidden" name="id" value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">
    <input type="hidden" name="idTurno" id="idTurnoHidden" value="<%= idTurnoActual != null ? idTurnoActual : "" %>">

    Tienda:
    <select>
        <%
            for (Tienda t : tiendas) {
                boolean sel = (idTiendaActual != null && idTiendaActual.equals(t.getIdTienda()));
                String localidadTienda = (t.getDireccion() != null ? t.getDireccion().getZonaGeografica() : "");
        %>
        <option value="<%= t.getIdTienda() %>" <%= sel ? "selected" : "" %>>
            <%= t.getNombreEstablecimiento() %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    Turno:
    <select id="selectTurno">
        <%
            for (TurnoActivo t : turnos) {
                String dia = "";
                String franja = "";
                if (t.getPlantillaTurno() != null) {
                    if (t.getPlantillaTurno().getDiaSemana() != null) dia = t.getPlantillaTurno().getDiaSemana();
                    if (t.getPlantillaTurno().getFranjaHoraria() != null) franja = t.getPlantillaTurno().getFranjaHoraria();
                }
                String fechaTurno = t.getFechaExacta() != null ? t.getFechaExacta().toString() : "";
                boolean sel = idTurnoActual != null && idTurnoActual.equals(t.getIdTurnoActivo());
        %>
        <option value="<%= t.getIdTurnoActivo() %>"
                data-fecha="<%= fechaTurno %>"
                <%= sel ? "selected" : "" %>>
            <%= dia + " " + franja + " · " + fechaTurno %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    Asistencia:
    <input type="checkbox" name="asistencia" value="true"
        <%= esEdicion && Boolean.TRUE.equals(asignacion.getAsistencia()) ? "checked" : "" %>
    >
    <br>


    Entidad Colaboradora:
    <select name="idEntidad">
        <%
            for (EntidadColaboradora e : entidades) {
                boolean seleccionada = idEntidadActual!= null && idEntidadActual.equals(e.getIdEntidad());
        %>
        <option value="<%= e.getIdEntidad() %>" <%= seleccionada ? "selected" : "" %>>
            <%= e.getNombreEntidad() %>
        </option>
        <%
            }
        %>
    </select>
    <br>
    
    <button type="submit">Guardar</button>
    <a href="/voluntarios/listar?idUsuario=<%= idUsuario %>"><button type="button">Cancelar</button></a>

</form>

</body>
</html>