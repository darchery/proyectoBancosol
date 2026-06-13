<%--
Página JSP que muestra el listado de contactos de una entidad colaboradora.

Autores:
- Sergio Aldana: 83%
- Daniela Calderón: 17%

--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.ContactoDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<ContactoDTO> contactos = (List<ContactoDTO>) request.getAttribute("contactos");
    Integer idEntidad = (Integer) request.getAttribute("idEntidad");
%>
<html>
<head>
    <title>Contactos de la Entidad</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
<header class="main-header">
    <div class="logo-area">
        <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        <div>
            <h1>CONTACTOS DE LA ENTIDAD</h1>
        </div>
    </div>
</header>

<main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                <tr>
                    <th>NOMBRE</th>
                    <th>EMAIL</th>
                    <th>TELÉFONO</th>
                    <th>PRINCIPAL</th>
                    <th colspan="2" class="text-center">ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (ContactoDTO c : contactos) {
                %>
                <tr class="fila-contacto"
                    data-nombre="<%= c.getNombre() != null ? c.getNombre() : "" %>"
                    data-email="<%= c.getEmail() != null ? c.getEmail() : "" %>"
                    data-telefono="<%= c.getTelefono() != null ? c.getTelefono() : "" %>"
                    data-principal="<%= Boolean.TRUE.equals(c.getEsPrincipal()) ? "Sí" : "No" %>">
                    <td><%= c.getNombre() %></td>
                    <td><%= c.getEmail() != null ? c.getEmail() : "" %></td>
                    <td><%= c.getTelefono() != null ? c.getTelefono() : "" %></td>
                    <td><%= Boolean.TRUE.equals(c.getEsPrincipal()) ? "✓" : "" %></td>
                    <td class="text-center">
                        <a href="/entidades/<%= idEntidad %>/contactos/editar?id=<%= c.getIdContacto() %>" class="btn btn-sm btn-warning">Editar</a>
                    </td>
                    <td class="text-center">
                        <a href="/entidades/<%= idEntidad %>/contactos/borrar?id=<%= c.getIdContacto() %>" class="btn btn-sm btn-danger">Eliminar</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <div class="mt-20">
                <a href="/entidades/<%= idEntidad %>/contactos/nuevo" class="btn btn-success">Añadir contacto</a>
                <a href="/entidades" class="btn btn-secondary">Volver a entidades</a>
            </div>
        </section>

        <aside class="details-panel">
            <div class="panel-header">CONTACTO SELECCIONADO</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>NOMBRE:</span><strong id="det-nombre">---</strong></div>
                <div class="detail-row"><span>EMAIL:</span><strong id="det-email">---</strong></div>
                <div class="detail-row"><span>TELÉFONO:</span><strong id="det-telefono">---</strong></div>
                <div class="detail-row"><span>PRINCIPAL:</span><strong id="det-principal">---</strong></div>
            </div>
            <div class="action-buttons mt-10">
                <a href="/entidades/<%= idEntidad %>/contactos/nuevo" class="btn-volver-menu">Añadir contacto</a>
                <a href="/entidades" class="btn-volver-menu" style="grid-column:1/-1;">Volver a entidades</a>
            </div>
        </aside>

    </div>

</main>

<footer>
    <p>&copy; 2026 Bancosol | Grupo 4</p>
</footer>

<script>
    window.scrollTo(0, 0);

    document.querySelectorAll('.fila-contacto').forEach(function(fila) {
        fila.style.cursor = 'pointer';
        fila.addEventListener('click', function() {
            document.querySelectorAll('.fila-contacto').forEach(f => f.classList.remove('fila-seleccionada'));
            this.classList.add('fila-seleccionada');
            document.getElementById('det-nombre').textContent = this.dataset.nombre || '---';
            document.getElementById('det-email').textContent = this.dataset.email || '---';
            document.getElementById('det-telefono').textContent = this.dataset.telefono || '---';
            document.getElementById('det-principal').textContent = this.dataset.principal || '---';
        });
    });
</script>
</body>
</html>