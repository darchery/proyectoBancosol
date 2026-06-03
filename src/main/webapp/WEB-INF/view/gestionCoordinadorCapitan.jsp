<%
    /*
        Lucas: 90%
        Sergio: 10%
    */
%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<UsuarioDTO> coordinadores = (List<UsuarioDTO>) request.getAttribute("coordinadores");
    List<UsuarioDTO> capitanes = (List<UsuarioDTO>) request.getAttribute("capitanes");
    List<UsuarioDTO> coordinadoresCapitanes = (List<UsuarioDTO>) request.getAttribute("coordinadoresCapitanes");
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
            for (UsuarioDTO c: coordinadores) {
    %>
    <tr>
        <td><%= c.getRolNombre() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= c.getEntidad()%></td>
        <td><%= c.getArea()%></td>
        <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
        <td><%= c.getEmail() %></td>
        <td><%= c.getNumTiendas()%></td>
        <td><%= c.getIdUsuario()%></td>
        <td><%= c.tranformarContrasenya(c.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= c.getIdUsuario()%>&idRol=<%= c.getRolId()%>">Editar</a></td>
        <td><a href="/usuarios/borrar?id=<%= c.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>


    <%
        if(capitanes != null){
            for (UsuarioDTO cap: capitanes) {
    %>
    <tr>
        <td><%=  cap.getRolNombre()%></td>
        <td><%= cap.getNombre() %></td>
        <td><%= cap.getEntidad()%></td>
        <td><%= cap.getArea()%></td>
        <td><%= (cap.getTelefono() != null) ? cap.getTelefono() : "-" %></td>
        <td><%= cap.getEmail() %></td>
        <td><%= cap.getNumTiendas()%></td>
        <td><%= cap.getIdUsuario()%></td>
        <td><%= cap.tranformarContrasenya(cap.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= cap.getIdUsuario()%>&idRol=<%= cap.getRolId()%>">Editar</a></td>
        <td><a href="/usuarios/borrar?id=<%= cap.getIdUsuario()%>">Borrar</a></td>
    </tr>
    <%
            }
        }
    %>

    <%
        if(coordinadoresCapitanes != null){
            for (UsuarioDTO cc: coordinadoresCapitanes) {
    %>
    <tr>
        <td><%= cc.getRolNombre() %></td>
        <td><%= cc.getNombre() %></td>
        <td><%= cc.getEntidad()%></td>
        <td><%= cc.getArea()%></td>
        <td><%= (cc.getTelefono() != null) ? cc.getTelefono() : "-" %></td>
        <td><%= cc.getEmail() %></td>
        <td><%= cc.getNumTiendas()%></td>
        <td><%= cc.getIdUsuario()%></td>
        <td><%= cc.tranformarContrasenya(cc.getContrasenya())%></td>
        <td><a href="/usuarios/editarCrear?id=<%= cc.getIdUsuario()%>&idRol=<%= cc.getRolId()%>">Editar</a></td>
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
