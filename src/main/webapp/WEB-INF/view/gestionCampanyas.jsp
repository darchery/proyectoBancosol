<%--
Página JSP que muestra la gestión de campañas de recogida.

Autores:
- Marina Ruiz: 50%
- Sergio Aldana: 40%
- IA Generativa: 10%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.CadenaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<CampanyaDTO> campanas = (List<CampanyaDTO>) request.getAttribute("campanas");
    List<CadenaDTO> cadenaEntities = (List<CadenaDTO>) request.getAttribute("cadenas");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="page-campanya">

<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>GESTIÓN DE CAMPAÑAS</h1>
        </div>
    </div>
</header>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
        boolean esError = msg.startsWith("error:");
        String texto = msg.substring(msg.indexOf(":") + 1);
        String cssClass = esError ? "msg-error" : "msg-ok";
%>
<div class="<%= cssClass %>"><%= texto %></div>
<% } %>

<form method="post" action="/campanyas/generarCampanyaConDatos">

    <div class="management-container">

        <div class="campanya-column">
            <div class="box">
                <h2>Tipo de campaña</h2>
                <div class="radio-grid">
                    <div class="checkbox-item">
                        <input type="radio" name="tipoCampanya" value="GR"
                               id="tipo_GR">
                        <label for="tipo_GR">Gran Recogida</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="radio" name="tipoCampanya" value="primavera"
                               id="tipo_primavera">
                        <label for="tipo_primavera">Operación Primavera</label>
                    </div>
                </div>
            </div>

            <div class="box">
                <h2>Fechas</h2>
                <div class="form-group">
                    <label for="fechaInicio">Fecha de inicio:</label>
                    <input type="date" name="fechaInicio" id="fechaInicio" required>
                </div>
                <div class="form-group">
                    <label for="fechaFin">Fecha de fin:</label>
                    <input type="date" name="fechaFin" id="fechaFin" required>
                </div>
            </div>

            <div class="actions-frame">
                <button type="submit">Generar campaña con los datos seleccionados</button>
                <a href="/campanyas/generarCampanya" class="btn btn-primary">Generar campaña desde cero</a>
                <a href="/campanyas/historial" class="btn btn-primary">Ver historial</a>
                <a href="/menu" class="btn-volver-menu">Menú Principal</a>
            </div>
        </div>

        <div class="box cadenas-box">
            <h2>Cadenas</h2>
            <div class="checkbox-grid">
                <%
                    if (cadenaEntities != null) {
                        for (CadenaDTO cad : cadenaEntities) {
                %>
                <div class="checkbox-item" id="fila_<%= cad.getIdCadena() %>">
                    <input type="checkbox" name="cadenaIds"
                           value="<%= cad.getIdCadena() %>"
                           id="cad_<%= cad.getIdCadena() %>">
                    <label for="cad_<%= cad.getIdCadena() %>"><%= cad.getNombreCadena() %></label>

                    <div class="cadena-btn-group">
                        <a href="/cadenas/editar?id=<%= cad.getIdCadena() %>" class="btn btn-sm btn-warning">Editar</a>
                        <a href="/cadenas/borrar?id=<%= cad.getIdCadena() %>" class="btn btn-sm btn-danger">Eliminar</a>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
            <div class="cadenas-actions">
                <a href="/cadenas/nueva" class="add-cadena-link">+ Añadir cadena</a>
            </div>
        </div>

        <div class="right-column">
            <div class="character-container">
                <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL.png" alt="Bancosol">
            </div>
        </div>

    </div>

</form>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>

</body>
</html>
