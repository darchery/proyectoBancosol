<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>


<html>
<head>
    <title>Asignaciones del Voluntario</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <h1>Asignacion voluntarios</h1>

    <%
        Integer idUsuario = (Integer) request.getAttribute("idUsuario");
        String nombreUsuario = (String) request.getAttribute("nombreUsuario");
        List<AsignacionVoluntarioDTO> asignaciones = (List<AsignacionVoluntarioDTO>) request.getAttribute("asignaciones");
    %>

    <br>
    <p>
        <%= nombreUsuario %>
        ID Usuario: <%= idUsuario %>
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
            <tr> <td>Voluntario sin asignaciones</td> </tr>
        <%
        } else {

            for (AsignacionVoluntarioDTO av : asignaciones) {
        %>

        <tr>

            <td><%= av.getIdAsignacion() %></td>

            <td><%= av.getNombreTienda() %></td>

            <td><%= av.getLocalidad() != null ? av.getLocalidad() : "-" %></td>

            <td><%= av.getDiaFranja() != null ? av.getDiaFranja() : "-" %></td>

            <td><%= av.getFecha() != null ? av.getFecha() : "-" %></td>

            <td><%= Boolean.TRUE.equals(av.getAsistencia()) ? "Sí" : "No" %></td>

            <td><%= av.getIdEntidad() != null ? av.getIdEntidad() : "-" %></td>

            <td><%= av.getNombreEntidad() != null ? av.getNombreEntidad() : "-" %></td>

            <td><a href="/voluntarios/edit?idUsuario=<%= idUsuario %>&id=<%= av.getIdAsignacion() %>">Editar</a></td>
            <td><a href="/voluntarios/borrar?id=<%= av.getIdAsignacion() %>&idUsuario=<%= idUsuario %>">Borrar</a></td>

        </tr>

        <%
            }} //else y for
        %>

        </tbody>
    </table>
    <a href="/voluntarios/edit?idUsuario=<%= idUsuario %>"><button type="button">Añadir Asignación</button></a>
</body>
</html>