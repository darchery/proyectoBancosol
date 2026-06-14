<%--
Página JSP que muestra la ifnormación de asignación de voluntario.

Autores:
- Daniela Calderón: 100%

--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.AsignacionVoluntarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Mis Asignaciones</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<AsignacionVoluntarioDTO> asignaciones = (List<AsignacionVoluntarioDTO>) request.getAttribute("asignaciones");
%>
<body>
<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>MIS ASIGNACIONES</h1>
        </div>
    </div>
</header>

<main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                <tr>
                    <th>TIENDA</th>
                    <th>LOCALIDAD</th>
                    <th>FECHA</th>
                    <th>DÍA / FRANJA</th>
                    <th>ENTIDAD</th>
                    <th>ASISTENCIA</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (AsignacionVoluntarioDTO a : asignaciones) {
                %>
                <tr>
                    <td><strong><%= a.getNombreTienda() != null ? a.getNombreTienda() : "<em class='text-muted'>-</em>" %></strong></td>
                    <td><%= a.getLocalidad() != null ? a.getLocalidad() : "<em class='text-muted'>-</em>" %></td>
                    <td><%= a.getFecha() != null ? a.getFecha() : "<em class='text-muted'>-</em>" %></td>
                    <td><%= a.getDiaFranja() != null ? a.getDiaFranja() : "<em class='text-muted'>-</em>" %></td>
                    <td><%= a.getNombreEntidad() != null ? a.getNombreEntidad() : "<em class='text-muted'>-</em>" %></td>
                    <td><%= Boolean.TRUE.equals(a.getAsistencia()) ? "✓" : "✗" %></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div class="mt-20" style="display:flex;gap:10px;flex-wrap:wrap;">
                <a href="/menu" class="btn btn-secondary">Menú Principal</a>
            </div>
        </section>

    </div>

</main>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>

</body>
</html>