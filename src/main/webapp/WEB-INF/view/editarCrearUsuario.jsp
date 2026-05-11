<%@ page import="es.uma.tsaw.proyectobancosol.entity.Rol" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Rol rol = (Rol) request.getAttribute("rol");
    Usuario usuario = (Usuario) request.getAttribute("usuario");
%>

<html>
<head>
    <title><%= usuario == null ? "Añadir" : "Editar"%> <%= rol.getNombreRol()%></title>
</head>
<body>
<h1><%= usuario == null ? "Añadir" : "Editar"%> <%= rol.getNombreRol()%></h1>

<form action="/usuarios/guardar" method="post">
    <input type="hidden" name="id" value="<%= usuario != null ? usuario.getIdUsuario() : ""%>">
    <input type="hidden" name="idRol" value="<%= rol.getIdRol()%>">

    <label>Nombre:</label><br>
    <input value="<%= usuario != null ? usuario.getNombre() : ""%>" type="text" name="nombre" required><br><br>

    <label>Correo:</label><br>
    <input value="<%= usuario != null ? usuario.getEmail() : ""%>" type="email" name="email" required><br><br>

    <label>Teléfono:</label><br>
    <input value="<%= usuario != null ? usuario.getTelefono() : ""%>" type="text" name="telefono"><br><br>

    <label>Contraseña:</label><br>
    <input value="<%= /*usuario != null ? usuario.tranformarContrasenya(*/ usuario != null ? usuario.getContrasenya() : ""/*) : ""*/%>" type="password" name="contrasenya" required><br><br>

    <button type="submit">Guardar</button>
    <a href="/usuarios/coordinadores-capitanes"><button type="button">Cancelar</button></a>
</form>

</body>
</html>

