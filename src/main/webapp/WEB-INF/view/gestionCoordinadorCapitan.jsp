<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.AsignacionVoluntario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    List<Usuario> coordinadores =  (List<Usuario>) request.getAttribute("coordinadores");
%>

<%!
    public String tranformarContrasenya(String contrasenya) {
        String res = "";

        for (Character c : contrasenya.toCharArray()) {
            res += "*";
        }
        return res;
    }
%>

<body>
<h1>Lista de Coordinadores</h1>

<table class="table table-striped table-bordered table-hover align-middle">
    <tr>
        <th>NOMBRE</th>
        <th>ENTIDAD</th>
        <th>AREA ASIGNADA</th>
        <th>TELÉFONO</th>
        <th>CORREO ELECTRÓNICO</th>
        <th>TIENDAS</th>
        <th>ID-USUARIO</th>
        <th>CONTRASEÑA</th>
    </tr>
    <%
        for (Usuario c: coordinadores) {
    %>
    <tr>
        <td><strong><%= c.getNombre() %></strong></td>
        <td><%= request.getAttribute("entidad_" + c.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + c.getIdUsuario())%></td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + c.getIdUsuario())%></td>
        <td><%= c.getIdUsuario()%></td>
        <td><%= tranformarContrasenya(c.getContrasenya())%></td>
    </tr>
    <%
        }
    %>

</table>

</div>

</body>
</html>
