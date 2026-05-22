<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<Usuario> coordinadores = (List<Usuario>) request.getAttribute("coordinadores");
    List<Usuario> capitanes = (List<Usuario>) request.getAttribute("capitanes");
    List<Usuario> capitanesCoordinadores = (List<Usuario>) request.getAttribute("capitanesCoordinadores");

%>

<body>
<h1>Lista de Coordinadores</h1>

<table>
    <tr>
        <th>ROL</th>
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
        if(coordinadores != null){
            for (Usuario c: coordinadores) {
    %>
    <tr>
        <td><%= c.getRol().getNombreRol() %></td>
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
        }
    %>


    <%
        if(capitanes != null){
            for (Usuario cap: capitanes) {
    %>
    <tr>
        <td><%= cap.getRol().getNombreRol() %></td>
        <td><%= cap.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + cap.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + cap.getIdUsuario())%></td>
        <td><%= (cap.getTelefono() != null) ? cap.getTelefono() : "-" %></td>
        <td><%= cap.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + cap.getIdUsuario())%></td>
        <td><%= cap.getIdUsuario()%></td>
        <td><%= cap.tranformarContrasenya(cap.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= cap.getIdUsuario()%>&idRol=<%= cap.getRol().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarios/borrar?id=<%= cap.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>

    <%
        if(capitanesCoordinadores != null){
            for (Usuario cc: capitanesCoordinadores) {
    %>
    <tr>
        <td><%= cc.getRol().getNombreRol() %></td>
        <td><%= cc.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + cc.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + cc.getIdUsuario())%></td>
        <td><%= (cc.getTelefono() != null) ? cc.getTelefono() : "-" %></td>
        <td><%= cc.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + cc.getIdUsuario())%></td>
        <td><%= cc.getIdUsuario()%></td>
        <td><%= cc.tranformarContrasenya(cc.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= cc.getIdUsuario()%>&idRol=<%= cc.getRol().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarios/borrar?id=<%= cc.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>
</table>

<section>
    <a href="/usuarios/editarCrear?idRol=<%=2%>"><button type="button">Añadir Coordinador</button></a>
    <a href="/usuarios/editarCrear?idRol=<%=3%>"><button type="button">Añadir Capitán</button></a>
    <a href="/usuarios/editarCrear?idRol=<%=6%>"><button type="button">Añadir Coordinador - Capitán</button></a>
</section>

</body>
</html>
