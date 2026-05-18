<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Entidades Colaboradoras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<EntidadColaboradora> entidadesColaboradoras =  (List<EntidadColaboradora>) request.getAttribute("entidades");
%>
<body>
<h1>Lista de Entidades Colaboradoras</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>ENTIDAD</th>
        <th>COLABORADOR</th>
        <th>DOMICILIO</th>
        <th>LOCALIDAD</th>
        <th>COLABORA EN</th>
        <th>COORDINADOR</th>
        <th>CONTACTO PRINCIPAL</th>
        <th>OBSERVACIONES</th>
        <th></th>
        <th></th>
    </tr>
    <%
        for (EntidadColaboradora e: entidadesColaboradoras) {
    %>
    <tr>
        <td><strong><%= e.getNombreEntidad() %></strong></td>
        <td><%= (e.getResponsable() != null) ? e.getResponsable().getNombre() : "<em class='text-muted'>Sin asignar</em>" %></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <th><a href="/entidades/editar?id=<%= e.getIdEntidad() %>">Editar</a></th>
        <th><a href="/entidades/borrar">Eliminar</a></th>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
