<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<UsuarioDTO> voluntarios = (List<UsuarioDTO>) request.getAttribute("voluntarios");
%>
<html>
<head>
    <title>Lista de Voluntarios - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>LISTA DE VOLUNTARIOS</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NOMBRE</th>
                        <th>EMAIL</th>
                        <th>TELÉFONO</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (voluntarios != null) {
                        for (UsuarioDTO v : voluntarios) {
                %>
                <tr>
                    <td><%= v.getIdUsuario() %></td>
                    <td><%= v.getNombre() %></td>
                    <td><%= v.getEmail() %></td>
                    <td><%= v.getTelefono() != null ? v.getTelefono() : "-" %></td>
                    <td>
                        <a href="/voluntarios/listar?idUsuario=<%= v.getIdUsuario() %>" class="btn btn-sm btn-primary">Ver asignaciones</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5" class="text-center">No hay voluntarios registrados</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <div class="mt-20">
                <a href="/menu" class="btn btn-secondary">Volver al menú</a>
            </div>
        </section>

        <aside class="details-panel">
            <div class="panel-header">VOLUNTARIO SELECCIONADO</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>ID:</span><strong>---</strong></div>
                <div class="detail-row"><span>NOMBRE:</span><strong>---</strong></div>
                <div class="detail-row"><span>EMAIL:</span><strong>---</strong></div>
                <div class="detail-row"><span>TELÉFONO:</span><strong>---</strong></div>
            </div>
            <div class="action-buttons mt-10">
                <a href="/menu" class="btn-volver-menu" style="grid-column:1/-1;">Menú Principal</a>
            </div>
        </aside>

    </div>

    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>