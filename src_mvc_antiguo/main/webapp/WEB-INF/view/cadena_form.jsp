<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    CadenaEntity cadenaEntity = (CadenaEntity) request.getAttribute("cadenaEntity");
    String ctx = request.getContextPath();
    boolean esNueva = (cadenaEntity.getIdCadena() == null);
%>

<html>
<head>
    <title><%= esNueva ? "Nueva cadenaEntity" : "Editar cadenaEntity" %> - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>

<h1><%= esNueva ? "Nueva cadenaEntity" : "Editar cadenaEntity" %></h1>

<form method="post" action="<%= ctx %>/campanas/cadenaEntities/guardar">

    <input type="hidden" name="idCadena" value="<%= esNueva ? "" : cadenaEntity.getIdCadena() %>">

    Nombre: <input type="text" name="nombreCadena" value="<%= esNueva ? "" : cadenaEntity.getNombreCadena() %>" required><br><br>

    Reseña: <input type="text" name="resenyaCadena" value="<%= esNueva ? "" : (cadenaEntity.getResenyaCadena() != null ? cadenaEntity.getResenyaCadena() : "") %>"><br><br>

    Logo URL: <input type="text" name="logoUrl" value="<%= esNueva ? "" : (cadenaEntity.getLogoUrl() != null ? cadenaEntity.getLogoUrl() : "") %>"><br><br>

    <input type="submit" value="Guardar">
    <a href="<%= ctx %>/campanas">Cancelar</a>

</form>

</body>
</html>
