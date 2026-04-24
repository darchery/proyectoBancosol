<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity" %>
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
        <th>DOMICILIO</th>
        <th>LOCALIDAD</th>
        <th>COLABORA EN</th>
        <%-- FALTA RELACION COORDINADOR- COLABORADORES<th>COORDINADOR</th> --%>
        <th>CONTACTO PRINCIPAL</th>
        <th>OBSERVACIONES</th>
    </tr>
    <%
        for (EntidadColaboradora e: entidadesColaboradoras) {
    %>
    <tr>
        <td><%= e.getNombreColaborador() %> </td>
        <td><%= e.getDomicilio() %> </td>
        <td><%= e.getDireccion().getDistrito()%> </td>
        <td><%= e.getTipo() %> </td>
      <%--FALTA   <td><%= e.get%> </td> --%>
        <td><%= e.getContactoList().getFirst()%> </td>
        <td><%= e.getObservaciones()%> </td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
