<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
</head>
<%
    List<Usuario> coordinadores = (List<Usuario>) request.getAttribute("coordinadores");
%>

<body>
<h1>Lista de Coordinadores</h1>

<table border="1">
    <tr>
        <th>NOMBRE</th>
        <th>ENTIDAD</th>
        <th>AREA ASIGNADA</th>
        <th>TELÉFONO</th>
        <th>CORREO</th>
        <th>TIENDAS</th>
        <th>ID</th>
        <th>CONTRASEÑA</th>
        <th></th>
        <th></th>
    </tr>
    <%
        for (Usuario c: coordinadores) {
    %>
    <tr>
        <td><%= c.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + c.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + c.getIdUsuario())%></td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + c.getIdUsuario())%></td>
        <td><%= c.getIdUsuario()%></td>
        <td><%= c.tranformarContrasenya(c.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= c.getIdUsuario()%>&idRol=<%= c.getRol().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarios/borrar?id=<%= c.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
        }
    %>
</table>

<section>
    <a href="/usuarios/editarCrear?idRol=<%=2%>"><button type="button">Añadir Coordinador</button></a>
</section>

</body>
</html>
