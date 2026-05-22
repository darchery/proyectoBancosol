<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Asignaciones del Voluntario</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <h1>Asignacion voluntarios</h1>

    <%
        Usuario usuario = (Usuario) request.getAttribute("usuario");
        List<AsignacionVoluntario> asignaciones = (List<AsignacionVoluntario>) request.getAttribute("asignaciones");
    %>

    <br>
    <p>
        <%= usuario.getNombre() %>
        ID Usuario: <%= usuario.getIdUsuario() %>
    </p>

    <table border="1 px">
        <thead>
            <tr>
                <th>ID ASIGNACION</th>
                <th>TIENDA</th>
                <th>LOCALIDAD</th>
                <th>FRANJA</th>
                <th>FECHA</th>
                <th>ASISTENCIA</th>
                <th>ID ENTIDAD</th>
                <th>ENTIDAD COLABORADORA</th>
                <th></th>
                <th></th>
            </tr>
        </thead>

        <tbody>

        <%
            if (asignaciones == null || asignaciones.isEmpty()) {
        %>
            <tr> <td colspan="8">Voluntario sin asignaciones</td> </tr>
        <%
        } else {

            for (AsignacionVoluntario av : asignaciones) {
        %>

        <tr>

            <td><%= av.getIdAsignacion() %></td>

            <td><%= av.getTurnoActivo().getTiendaCampanya().getTienda().getNombreEstablecimiento() %></td>

            <td>
                <%if (av.getTurnoActivo().getTiendaCampanya().getTienda().getDireccion() != null) {%>
                        <%= av.getTurnoActivo().getTiendaCampanya().getTienda().getDireccion().getZonaGeografica() %>
                <%}%>
            </td>

            <td>
                <%if (av.getTurnoActivo().getPlantillaTurno() != null) {
                    String dia = av.getTurnoActivo().getPlantillaTurno().getDiaSemana();
                    String franja = av.getTurnoActivo().getPlantillaTurno().getFranjaHoraria();
                %>
                        <%= (dia != null ? dia : "") + " " + (franja != null ? franja : "") %>
                <%}%>
            </td>

            <td><%= av.getTurnoActivo().getFechaExacta() != null ? av.getTurnoActivo().getFechaExacta().toString() : "-" %></td>

            <td><%= Boolean.TRUE.equals(av.getAsistencia()) ? "Sí" : "No" %></td>

            <td><%= av.getEntidadColaboradora() != null ? av.getEntidadColaboradora().getIdEntidad() : "-" %></td>

            <td><%= av.getEntidadColaboradora() != null ? av.getEntidadColaboradora().getNombreEntidad() : "-" %></td>

            <td><a href="/voluntarios/edit?idUsuario=<%= usuario.getIdUsuario() %>&id=<%= av.getIdAsignacion() %>">Editar</a></td>
            <td><a href="/voluntarios/borrar?id=<%= av.getIdAsignacion() %>&idUsuario=<%= usuario.getIdUsuario() %>">Borrar</a></td>

        </tr>

        <%
            }} //else y for
        %>

        </tbody>
    </table>
    <a href="/voluntarios/edit?idUsuario=<%= usuario.getIdUsuario() %>"><button type="button">Añadir Asignación</button></a>
</body>
</html>