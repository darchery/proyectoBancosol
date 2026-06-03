<%
    /*
        Lucas: 80%
        Sergio: 10%
        IA: 10%
    */
%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.RolDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    RolDTO rol = (RolDTO) request.getAttribute("rol");
    UsuarioDTO usuario = (UsuarioDTO) request.getAttribute("usuario");
%>

<html>
<head>
    <title><%= usuario == null ? "Añadir" : "Editar"%> <%= rol.getNombreRol()%></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
<h1><%= usuario == null ? "Añadir" : "Editar"%> <%= rol.getNombreRol()%></h1>

<%
    String error = (String) request.getAttribute("error");
    if ("email_duplicado".equals(error)) {
%>
        <p style="color:red;">Ese email ya está registrado. Prueba con otro.</p>
<%
    }
%>

<form action="/usuarios/guardar" method="post">
    <%
        if (usuario != null) {
    %>
            <input type="hidden" name="id" value="<%= usuario.getIdUsuario()%>">
    <%
        }
    %>

    <input type="hidden" name="idRol" value="<%= rol.getIdRol()%>">

    <label>Nombre:</label><br>
    <input value="<%= usuario != null ? usuario.getNombre() : ""%>" type="text" name="nombre" required><br><br>

    <label>Correo:</label><br>
    <input value="<%= usuario != null ? usuario.getEmail() : ""%>" type="email" name="email" required><br><br>

    <label>Teléfono:</label><br>
    <input value="<%= usuario != null ? usuario.getTelefono() : ""%>" type="text" name="telefono"><br><br>

    <label>Contraseña:</label><br>
    <input value="<%= usuario != null ? usuario.getContrasenya() : ""/*) : ""*/%>" type="password" name="contrasenya" required><br><br>

    <button type="submit">Guardar</button>
    <a href="/usuarios/coordinadores-capitanes"><button type="button">Cancelar</button></a>
</form>

</body>
</html>

