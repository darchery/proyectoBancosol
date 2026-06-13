<%--
Página JSP que muestra el historial de campañas.

Autores:
- Sergio Aldana: 80%
- IA Generativa: 20%
--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<CampanyaDTO> campanas = (List<CampanyaDTO>) request.getAttribute("campanas");
%>

<html>
<head>
    <title>Historial de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="page-campanya">

<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>HISTORIAL DE CAMPAÑAS</h1>
        </div>
    </div>
</header>

<main class="container">
    <table class="tabla-historial">
        <thead>
        <tr>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Estado</th>
            <th>Fecha inicio</th>
            <th>Fecha fin</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (campanas != null && !campanas.isEmpty()) {
                for (CampanyaDTO c : campanas) {
                    String nombre = c.getNombreCampanya() != null ? c.getNombreCampanya() : "(sin nombre)";
                    String estado = c.getEstado() != null ? c.getEstado() : "";
                    String tipo = c.getTipoCampanya() != null ? c.getTipoCampanya() : "";
                    String fi = c.getFechaInicio() != null ? c.getFechaInicio() : "";
                    String ff = c.getFechaFin() != null ? c.getFechaFin() : "";
        %>
        <tr>
            <td><%= nombre %></td>
            <td><%= tipo %></td>
            <td><%= estado %></td>
            <td><%= fi %></td>
            <td><%= ff %></td>
            <td><a href="/campanyas/generarCampanya?id=<%= c.getIdCampanya() %>" class="btn-editar-historial">Editar</a></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="6"><em>No hay campañas registradas.</em></td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <div class="actions-row text-center">
        <a href="/campanyas" class="btn-volver-menu">Volver a Gestión de Campañas</a>
    </div>
</main>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>

</body>
</html>
