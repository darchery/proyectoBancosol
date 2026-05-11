<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Cadena cadena = (Cadena) request.getAttribute("cadena");
    String ctx = request.getContextPath();
    boolean esNueva = (cadena.getIdCadena() == null);
%>

<html>
<head>
    <title><%= esNueva ? "Nueva cadena" : "Editar cadena" %> - Bancosol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<h1><%= esNueva ? "Nueva cadena" : "Editar cadena" %></h1>

<form method="post" action="<%= ctx %>/campanas/cadenas/guardar">

    <input type="hidden" name="idCadena" value="<%= esNueva ? "" : cadena.getIdCadena() %>">

    Nombre: <input type="text" name="nombreCadena" value="<%= esNueva ? "" : cadena.getNombreCadena() %>" required><br><br>

    Reseña: <input type="text" name="resenyaCadena" value="<%= esNueva ? "" : (cadena.getResenyaCadena() != null ? cadena.getResenyaCadena() : "") %>"><br><br>

    Logo URL: <input type="text" name="logoUrl" value="<%= esNueva ? "" : (cadena.getLogoUrl() != null ? cadena.getLogoUrl() : "") %>"><br><br>

    <input type="submit" value="Guardar">
    <a href="<%= ctx %>/campanas">Cancelar</a>

</form>

</body>
</html>
