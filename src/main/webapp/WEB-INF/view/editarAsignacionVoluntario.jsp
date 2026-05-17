<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.TurnoActivo" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Asignacion Voluntarios Editar/Añadir</title>
</head>

<body>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    AsignacionVoluntario asignacion = (AsignacionVoluntario) request.getAttribute("asignacion");
    List<TurnoActivo> turnos = (List<TurnoActivo>) request.getAttribute("turnos");
    List<EntidadColaboradora> entidades = (List<EntidadColaboradora>) request.getAttribute("entidades");
    boolean esEdicion = (asignacion != null);
%>

<h1><%= esEdicion ? "Editar" : "Añadir" %> Asignación</h1>

<p>
    Voluntario: <strong><%= usuario.getNombre() %></strong>
    (ID: <%= usuario.getIdUsuario() %>)
</p>

<form action="/voluntarios/guardar" method="post">

    <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsuario() %>">
    <input type="hidden" name="id" value="<%= esEdicion ? asignacion.getIdAsignacion() : "" %>">

    <label>Turno:</label><br>
    <select name="idTurno" required>
        <option value="">-- Selecciona un turno --</option>
        <%
            for (TurnoActivo turno : turnos) {

                String dia = "";
                String franja = "";

                if (turno.getPlantillaTurno() != null) {
                    if (turno.getPlantillaTurno().getDiaSemana() != null) {
                        dia = turno.getPlantillaTurno().getDiaSemana();
                    }
                    if (turno.getPlantillaTurno().getFranjaHoraria() != null) {
                        franja = turno.getPlantillaTurno().getFranjaHoraria();
                    }
                }

                String tienda = turno.getTiendaCampanya()
                        .getTienda()
                        .getNombreEstablecimiento();

                String fecha = turno.getFechaExacta() != null
                        ? turno.getFechaExacta().toString()
                        : "";

                String label = tienda + " · " + dia + " " + franja + " · " + fecha;

                boolean seleccionado = esEdicion
                        && asignacion.getTurnoActivo() != null
                        && asignacion.getTurnoActivo().getIdTurnoActivo()
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
            for (EntidadColaboradora entidad : entidades) {

                boolean seleccionada = esEdicion
                        && asignacion.getEntidadColaboradora() != null
                        && asignacion.getEntidadColaboradora().getIdEntidad()
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
    <a href="/voluntarios/listar?idUsuario=<%= usuario.getIdUsuario() %>"><button type="button">Cancelar</button></a>

</form>

</body>
</html>