<%--
Página JSP que muestra el formulario para crear o editar una cadenaEntity de tiendaEntities.

Autores:
- Sergio Aldana: 75%
- Marina Ruiz: 25%

--%>

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
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1><%= esNueva ? "NUEVA CADENA" : "EDITAR CADENA" %></h1>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="form-container">

            <form method="post" action="<%= ctx %>/campanas/cadenaEntities/guardar">

                <input type="hidden" name="idCadena" value="<%= esNueva ? "" : cadenaEntity.getIdCadena() %>">

                <div class="form-group">
                    <label>Nombre:</label>
                    <input type="text" name="nombreCadena" value="<%= esNueva ? "" : cadenaEntity.getNombreCadena() %>" required>
                </div>

                <div class="form-group">
                    <label>Reseña:</label>
                    <input type="text" name="resenyaCadena" value="<%= esNueva ? "" : (cadenaEntity.getResenyaCadena() != null ? cadenaEntity.getResenyaCadena() : "") %>">
                </div>

                <div class="form-group">
                    <label>Logo URL:</label>
                    <input type="text" name="logoUrl" value="<%= esNueva ? "" : (cadenaEntity.getLogoUrl() != null ? cadenaEntity.getLogoUrl() : "") %>">
                </div>

                <div class="actions-row">
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <a href="<%= ctx %>/campanas" class="btn btn-secondary">Cancelar</a>
                </div>

            </form>

        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>