<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Direccion" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Entidades Colaboradoras</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<EntidadColaboradora> entidadesColaboradoras =  (List<EntidadColaboradora>) request.getAttribute("entidades");
%>
<body>
<h1>Lista de Entidades Colaboradoras</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>ENTIDAD</th>
        <th>DOMICILIO</th>
        <th>LOCALIDAD</th>
        <th>COLABORA EN</th>
        <th>COORDINADOR</th>
        <th>CONTACTO PRINCIPAL</th>
        <th>OBSERVACIONES</th>
        <th colspan="2" class="text-center">ACCIONES</th>
    </tr>
    <%
        for (EntidadColaboradora e: entidadesColaboradoras) {
            Direccion direccion = e.getDireccion();
            Usuario coordinador = e.getResponsable();
    %>
    <tr>
        <td><strong><%= e.getNombreEntidad() %></strong></td>
        <td><%= direccion.getDomicilio() %></td>
        <td><%= direccion.getDistritoLocal() %></td>
        <td><%= direccion.getZonaGeografica() %></td>
        <td><%= coordinador.getNombre() %></td>
        <td><%= e.getNombreContactoPrincipal() %> (<%= e.getTelefonoContactoPrincipal() %>)</td>
        <td><%= (e.getObservaciones() != null) ? e.getObservaciones() : "<em class='text-muted'>No hay observaciones</em>" %></td>
        <td class="text-center">
            <a href="/entidades/editar?id=<%= e.getIdEntidad() %>" class="btn btn-sm btn-warning">Editar</a>
        </td>
        <td class="text-center">
            <a href="/entidades/borrar?id=<%= e.getIdEntidad() %>" class="btn btn-sm btn-danger">Eliminar</a>
        </td>
    </tr>
    <%
        }
    %>

</table>

<div class="mt-20">
    <a href="/entidades/nueva" class="btn btn-success">Añadir nueva entidad</a>
</div>

</body>
</html>
