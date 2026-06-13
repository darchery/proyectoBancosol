<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Asignacion Voluntarios Editar/Añadir</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>

<%
    UsuarioEntity usuarioEntity = (UsuarioEntity) request.getAttribute("usuarioEntity");
    AsignacionVoluntarioEntity asignacion = (AsignacionVoluntarioEntity) request.getAttribute("asignacion");
    List<TurnoActivoEntity> turnos = (List<TurnoActivoEntity>) request.getAttribute("turnos");
    List<es.uma.tsaw.proyectobancosol.entity.EntidadColaboradoraEntity> entidades = (List<EntidadColaboradoraEntity>) request.getAttribute("entidades");
    boolean esEdicion = (asignacion != null);
%>

<h1><%= esEdicion ? "Editar" : "Añadir" %> Asignación</h1>

<p>
    Voluntario: <strong><%= usuarioEntity.getNombre() %></strong>
    (ID: <%= usuarioEntity.getIdUsuario() %>)
</p>

<form action="/voluntarios/guardar" method="post">

    <input type="hidden" name="idUsuario" value="<%= usuarioEntity.getIdUsuario() %>">
    <input type="hidden" name="id" value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">

    <label>Turno:</label><br>
    <select name="idTurno" required>
        <option value="">-- Selecciona un turno --</option>
        <%
            for (TurnoActivoEntity turno : turnos) {

                String dia = "";
                String franja = "";

                if (turno.getPlantillaTurnoEntity() != null) {
                    if (turno.getPlantillaTurnoEntity().getDiaSemana() != null) {
                        dia = turno.getPlantillaTurnoEntity().getDiaSemana();
                    }
                    if (turno.getPlantillaTurnoEntity().getFranjaHoraria() != null) {
                        franja = turno.getPlantillaTurnoEntity().getFranjaHoraria();
                    }
                }

                String tiendaEntity = turno.getTiendaCampanya()
                        .getTiendaEntity()
                        .getNombreEstablecimiento();

                String fecha = turno.getFechaExacta() != null
                        ? turno.getFechaExacta().toString()
                        : "";

                String label = tiendaEntity + " · " + dia + " " + franja + " · " + fecha;

                boolean seleccionado = esEdicion
                        && asignacion.getTurnoActivoEntity() != null
                        && asignacion.getTurnoActivoEntity().getIdTurnoActivo()
                        .equals(turno.getIdTurnoActivo());
        %>
        <option value="<%= turno.getIdTurnoActivo() %>"
                <%= seleccionado ? "selected" : "" %>>
            <%= label %>
        </option>
        <%
            }
        %>
    </select>
    <br>

    <label>Entidad Colaboradora:</label><br>
    <select name="idEntidad">
        <option value="">-- Sin entidad --</option>

        <%
            for (EntidadColaboradoraEntity entidad : entidades) {

                boolean seleccionada = esEdicion
                        && asignacion.getEntidadColaboradoraEntity() != null
                        && asignacion.getEntidadColaboradoraEntity().getIdEntidad()
                        .equals(entidad.getIdEntidad());
        %>

        <option value="<%= entidad.getIdEntidad() %>"
                <%= seleccionada ? "selected" : "" %>>
            <%= entidad.getNombreEntidad() %>
        </option>

        <%
            }
        %>
    </select>
    <br>

    <label>Asistencia:</label>
    <input type="checkbox" name="asistencia" value="true"
        <%= esEdicion && Boolean.TRUE.equals(asignacion.getAsistencia())
                ? "checked"
                : "" %>>
    <br>

    <button type="submit">Guardar</button>
    <a href="/voluntarios/listar?idUsuario=<%= usuarioEntity.getIdUsuario() %>"><button type="button">Cancelar</button></a>

</form>

</body>
</html>