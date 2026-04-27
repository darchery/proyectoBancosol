<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<Usuario> coordinadores =  (List<Usuario>) request.getAttribute("coordinadores");
%>
<body>
<h1>Lista de Voluntarios</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>NOMBRE</th>
        <th>ENTIDAD</th>
        <th>AREA ASIGNADA</th>
        <th>TELÉFONO</th>
        <th>CORREO ELECTRÓNICO</th>
        <th>TIENDAS</th>
        <th>USUARIO</th>
        <th>CONTRASEÑA(poner así ****** -> borrar cuando se haga)</th>
    </tr>
    <%
        for (Usuario c: coordinadores) {
    %>
    <tr>
        <td><strong><%= c.getNombre() %></strong></td>
        <td>poner entidad</td>
        <td>poner área asignada</td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td>poner numero tiendas</td>
        <td><%= c.getIdUsuario()%></td>
        <td>poner contraseña(****)</td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
