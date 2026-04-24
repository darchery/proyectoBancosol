<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.EntidadColaboradora" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Entidades Colaboradoras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<EntidadColaboradora> entidadesColaboradoras =  (List<EntidadColaboradora>) request.getAttribute("pelis");
%>
<body>
<h1>Lista de Entidades Colaboradoras</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>COLABORADOR</th>
        <th>TIPO</th>
        <th>LIGADO A BANCOSOL</th>
        <th>RESPONSABLE (Contacto)</th>
        <th>EMAIL RESPONSABLE</th>
        <th>TELÉFONO</th>
    </tr>
    <%
        for (EntidadColaboradora e: entidadesColaboradoras) {
    %>
    <tr>
        <td><strong><%= e.getNombreEntidad() %></strong></td>
        <td><%= (e.getTipo() != null) ? e.getTipo() : "No definido" %></td>
        <td class="text-center">
            <input type="checkbox" disabled <%= e.getLigadoBancosol() ? "checked" : "" %> />
        </td>
        <td><%= (e.getResponsable() != null) ? e.getResponsable().getNombre() : "<em class='text-muted'>Sin asignar</em>" %></td>
        <td><%= (e.getResponsable() != null) ? e.getResponsable().getEmail() : "-" %></td>
        <td><%= (e.getResponsable() != null) ? e.getResponsable().getTelefono() : "-" %></td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
