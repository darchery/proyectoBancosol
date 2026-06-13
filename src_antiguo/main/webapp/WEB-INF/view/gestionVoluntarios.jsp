<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Asignaciones del Voluntario</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>

<body>
    <h1>Asignacion voluntarios</h1>

    <%
        UsuarioEntity usuarioEntity = (UsuarioEntity) request.getAttribute("usuarioEntity");
        List<AsignacionVoluntarioEntity> asignaciones = (List<AsignacionVoluntarioEntity>) request.getAttribute("asignaciones");
    %>

    <br>
    <p>
        <%= usuarioEntity.getNombre() %>
        ID Usuario: <%= usuarioEntity.getIdUsuario() %>
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

            for (AsignacionVoluntarioEntity av : asignaciones) {
        %>

        <tr>

            <td><%= av.getIdAsignacion() %></td>

            <td><%= av.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getNombreEstablecimiento() %></td>

            <td>
                <%if (av.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getDireccionEntity() != null) {%>
                        <%= av.getTurnoActivoEntity().getTiendaCampanyaEntity().getTiendaEntity().getDireccionEntity().getZonaGeografica() %>
                <%}%>
            </td>

            <td>
                <%if (av.getTurnoActivoEntity().getPlantillaTurnoEntity() != null) {
                    String dia = av.getTurnoActivoEntity().getPlantillaTurnoEntity().getDiaSemana();
                    String franja = av.getTurnoActivoEntity().getPlantillaTurnoEntity().getFranjaHoraria();
                %>
                        <%= (dia != null ? dia : "") + " " + (franja != null ? franja : "") %>
                <%}%>
            </td>

            <td><%= av.getTurnoActivoEntity().getFechaExacta() != null ? av.getTurnoActivoEntity().getFechaExacta().toString() : "-" %></td>

            <td><%= Boolean.TRUE.equals(av.getAsistencia()) ? "Sí" : "No" %></td>

            <td><%= av.getEntidadColaboradoraEntity() != null ? av.getEntidadColaboradoraEntity().getIdEntidad() : "-" %></td>

            <td><%= av.getEntidadColaboradoraEntity() != null ? av.getEntidadColaboradoraEntity().getNombreEntidad() : "-" %></td>

            <td><a href="/voluntarios/edit?idUsuario=<%= usuarioEntity.getIdUsuario() %>&id=<%= av.getIdAsignacion() %>">Editar</a></td>
            <td><a href="/voluntarios/borrar?id=<%= av.getIdAsignacion() %>&idUsuario=<%= usuarioEntity.getIdUsuario() %>">Borrar</a></td>

        </tr>

        <%
            }} //else y for
        %>

        </tbody>
    </table>
    <a href="/voluntarios/edit?idUsuario=<%= usuarioEntity.getIdUsuario() %>"><button type="button">Añadir Asignación</button></a>
</body>
</html>