<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<UsuarioEntity> coordinadores = (List<UsuarioEntity>) request.getAttribute("coordinadores");
    List<UsuarioEntity> capitanes = (List<UsuarioEntity>) request.getAttribute("capitanes");
    List<UsuarioEntity> capitanesCoordinadores = (List<UsuarioEntity>) request.getAttribute("capitanesCoordinadores");

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
            for (UsuarioEntity c: coordinadores) {
    %>
    <tr>
        <td><%= c.getRolEntity().getNombreRol() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + c.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + c.getIdUsuario())%></td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + c.getIdUsuario())%></td>
        <td><%= c.getIdUsuario()%></td>
        <td><%= c.transformarContrasenya(c.getContrasenya())%></td>
        <td><a href="/usuarioEntities/editarCrear?id=<%= c.getIdUsuario()%>&idRol=<%= c.getRolEntity().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarioEntities/borrar?id=<%= c.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>


    <%
        if(capitanes != null){
            for (UsuarioEntity cap: capitanes) {
    %>
    <tr>
        <td><%= cap.getRolEntity().getNombreRol() %></td>
        <td><%= cap.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + cap.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + cap.getIdUsuario())%></td>
        <td><%= (cap.getTelefono() != null) ? cap.getTelefono() : "-" %></td>
        <td><%= cap.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + cap.getIdUsuario())%></td>
        <td><%= cap.getIdUsuario()%></td>
        <td><%= cap.transformarContrasenya(cap.getContrasenya())%></td>
        <td><a href="/usuarioEntities/editarCrear?id=<%= cap.getIdUsuario()%>&idRol=<%= cap.getRolEntity().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarioEntities/borrar?id=<%= cap.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>

    <%
        if(capitanesCoordinadores != null){
            for (UsuarioEntity cc: capitanesCoordinadores) {
    %>
    <tr>
        <td><%= cc.getRolEntity().getNombreRol() %></td>
        <td><%= cc.getNombre() %></td>
        <td><%= request.getAttribute("entidad_" + cc.getIdUsuario())%></td>
        <td><%= request.getAttribute("area_" + cc.getIdUsuario())%></td>
        <td><%= (cc.getTelefono() != null) ? cc.getTelefono() : "-" %></td>
        <td><%= cc.getEmail() %></td>
        <td><%= request.getAttribute("tiendas_" + cc.getIdUsuario())%></td>
        <td><%= cc.getIdUsuario()%></td>
        <td><%= cc.transformarContrasenya(cc.getContrasenya())%></td>
        <td><a href="/usuarioEntities/editarCrear?id=<%= cc.getIdUsuario()%>&idRol=<%= cc.getRolEntity().getIdRol()%>">Editar</a></td>
        <td><a href="/usuarioEntities/borrar?id=<%= cc.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>
</table>

<section>
    <a href="/usuarioEntities/editarCrear?idRol=<%=2%>"><button type="button">Añadir Coordinador</button></a>
    <a href="/usuarioEntities/editarCrear?idRol=<%=3%>"><button type="button">Añadir Capitán</button></a>
    <a href="/usuarioEntities/editarCrear?idRol=<%=6%>"><button type="button">Añadir Coordinador - Capitán</button></a>
</section>

</body>
</html>
