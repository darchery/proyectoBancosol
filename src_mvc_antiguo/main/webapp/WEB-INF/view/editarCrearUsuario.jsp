<%@ page import="es.uma.tsaw.proyectobancosol.entity.RolEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    RolEntity rolEntity = (RolEntity) request.getAttribute("rolEntity");
    UsuarioEntity usuarioEntity = (UsuarioEntity) request.getAttribute("usuarioEntity");
%>

<html>
<head>
    <title><%= usuarioEntity == null ? "Añadir" : "Editar"%> <%= rolEntity.getNombreRol()%></title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
<h1><%= usuarioEntity == null ? "Añadir" : "Editar"%> <%= rolEntity.getNombreRol()%></h1>

<form action="/usuarioEntities/guardar" method="post">
    <input type="hidden" name="id" value="<%= usuarioEntity != null ? usuarioEntity.getIdUsuario() : ""%>">
    <input type="hidden" name="idRol" value="<%= rolEntity.getIdRol()%>">

    <label>Nombre:</label><br>
    <input value="<%= usuarioEntity != null ? usuarioEntity.getNombre() : ""%>" type="text" name="nombre" required><br><br>

    <label>Correo:</label><br>
    <input value="<%= usuarioEntity != null ? usuarioEntity.getEmail() : ""%>" type="email" name="email" required><br><br>

    <label>Teléfono:</label><br>
    <input value="<%= usuarioEntity != null ? usuarioEntity.getTelefono() : ""%>" type="text" name="telefono"><br><br>

    <label>Contraseña:</label><br>
    <input value="<%= /*usuarioEntity != null ? usuarioEntity.tranformarContrasenya(*/ usuarioEntity != null ? usuarioEntity.getContrasenya() : ""/*) : ""*/%>" type="password" name="contrasenya" required><br><br>

    <button type="submit">Guardar</button>
    <a href="/usuarioEntities/coordinadores-capitanes"><button type="button">Cancelar</button></a>
</form>

</body>
</html>

