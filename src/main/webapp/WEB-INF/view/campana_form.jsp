<%--
Página JSP que muestra el formulario para editar una campaña existente.

Autores:
- Marina Ruiz: 100%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.CadenaEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    CampanyaDTO campana = (CampanyaDTO) request.getAttribute("campana");
    List<CadenaEntity> cadenas = (List<CadenaEntity>) request.getAttribute("cadenas");
    List<Integer> cadenaIds = campana.getCadenaIds();
%>

<html>
<head>
    <title>Editar Campaña - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="page-campanya">

<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>EDITAR CAMPAÑA</h1>
        </div>
    </div>
</header>

<main class="container">
    <div class="form-container">
        <form method="post" action="${pageContext.request.contextPath}/campanas/guardarTodo">

            <input type="hidden" name="campanaEditId" value="<%= campana.getIdCampanya() %>">

            <div class="form-group">
                <label>Nombre de la campaña:</label>
                <input type="text" name="campanaNombre"
                       value="<%= campana.getNombreCampanya() != null ? campana.getNombreCampanya() : "" %>" required>
            </div>

            <div class="form-group">
                <label>Tipo de campaña:</label>
                <input type="text" name="campanaTipo"
                       value="<%= campana.getTipoCampanya() != null ? campana.getTipoCampanya() : "" %>">
            </div>

            <div class="form-group">
                <label>Estado:</label>
                <select name="campanaEstado">
                    <%
                        String estado = campana.getEstado() != null ? campana.getEstado() : "";
                        String[] estados = { "ACTIVA", "FINALIZADA", "CANCELADA" };
                        for (String e : estados) {
                            String selected = e.equals(estado) ? "selected" : "";
                    %>
                    <option value="<%= e %>" <%= selected %>><%= e %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Fecha de inicio:</label>
                <input type="date" name="campanaFechaInicio"
                       value="<%= campana.getFechaInicio() != null ? campana.getFechaInicio() : "" %>">
            </div>

            <div class="form-group">
                <label>Fecha de fin:</label>
                <input type="date" name="campanaFechaFin"
                       value="<%= campana.getFechaFin() != null ? campana.getFechaFin() : "" %>">
            </div>

            <div class="form-group">
                <label>Cadenas participantes:</label>
                <div class="checkbox-grid" style="grid-template-columns:1fr;">
                    <%
                        if (cadenas != null) {
                            for (CadenaEntity cad : cadenas) {
                                boolean marcado = cadenaIds != null && cadenaIds.contains(cad.getIdCadena());
                    %>
                    <div class="checkbox-item">
                        <input type="checkbox" name="cadenaIds"
                               value="<%= cad.getIdCadena() %>"
                               id="cad_<%= cad.getIdCadena() %>"
                            <%= marcado ? "checked" : "" %>>
                        <label for="cad_<%= cad.getIdCadena() %>"><%= cad.getNombreCadena() %></label>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>

            <div class="actions-row">
                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="${pageContext.request.contextPath}/campanas" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</main>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>
</body>
</html>
