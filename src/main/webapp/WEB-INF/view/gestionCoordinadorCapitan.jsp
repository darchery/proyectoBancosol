<%--
Página JSP que muestra la gestión de coordinadores y capitanes.

Autores:
- Lucas Díaz Ruiz: 90%
- Sergio Aldana: 10%

--%>

<%@ page import="java.util.List" %>
<%@ page import="es.uma.tsaw.proyectobancosol.dto.UsuarioDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Coordinadores</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<%
    List<UsuarioDTO> coordinadores = (List<UsuarioDTO>) request.getAttribute("coordinadores");
    List<UsuarioDTO> capitanes = (List<UsuarioDTO>) request.getAttribute("capitanes");
    List<UsuarioDTO> coordinadoresCapitanes = (List<UsuarioDTO>) request.getAttribute("coordinadoresCapitanes");
%>

<body>
    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
            <div>
                <h1>GESTIÓN DE COORDINADORES / CAPITANES</h1>
            </div>
        </div>
    </header>

    <main class="dashboard">

    <div class="content-layout">

        <section class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ROL</th>
                        <th>NOMBRE</th>
                        <th>ENTIDAD</th>
                        <th>AREA ASIGNADA</th>
                        <th>TELÉFONO</th>
                        <th>CORREO</th>
                        <th>TIENDAS</th>
                        <th>ID</th>
                        <th>CONTRASEÑA</th>
                        <th colspan="2">ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if(coordinadores != null){
                        for (UsuarioDTO c: coordinadores) {
                %>
                <tr>
                    <td><%= c.getRolNombre() %></td>
                    <td><%= c.getNombre() %></td>
                    <td><%= c.getEntidad()%></td>
                    <td><%= c.getArea()%></td>
                    <td><%= (c.getTelefono() != null) ? c.getTelefono() : "-" %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getNumTiendas()%></td>
                    <td><%= c.getIdUsuario()%></td>
                    <td><%= c.tranformarContrasenya(c.getContrasenya())%></td>
                    <td><a href="/usuarioEntities/editarCrear?id=<%= c.getIdUsuario()%>&idRol=<%= c.getRolId()%>" class="btn btn-sm btn-warning">Editar</a></td>
                    <td><a href="/usuarioEntities/borrar?id=<%= c.getIdUsuario()%>" class="btn btn-sm btn-danger">Borrar</a></td>
                </tr>
                <%
                        }
                    }
                %>

                <%
                    if(capitanes != null){
                        for (UsuarioDTO cap: capitanes) {
                %>
                <tr>
                    <td><%=  cap.getRolNombre()%></td>
                    <td><%= cap.getNombre() %></td>
                    <td><%= cap.getEntidad()%></td>
                    <td><%= cap.getArea()%></td>
                    <td><%= (cap.getTelefono() != null) ? cap.getTelefono() : "-" %></td>
                    <td><%= cap.getEmail() %></td>
                    <td><%= cap.getNumTiendas()%></td>
                    <td><%= cap.getIdUsuario()%></td>
                    <td><%= cap.tranformarContrasenya(cap.getContrasenya())%></td>
                    <td><a href="/usuarioEntities/editarCrear?id=<%= cap.getIdUsuario()%>&idRol=<%= cap.getRolId()%>" class="btn btn-sm btn-warning">Editar</a></td>
                    <td><a href="/usuarioEntities/borrar?id=<%= cap.getIdUsuario()%>" class="btn btn-sm btn-danger">Borrar</a></td>
                </tr>
                <%
                        }
                    }
                %>

                <%
                    if(coordinadoresCapitanes != null){
                        for (UsuarioDTO cc: coordinadoresCapitanes) {
                %>
                <tr>
                    <td><%= cc.getRolNombre() %></td>
                    <td><%= cc.getNombre() %></td>
                    <td><%= cc.getEntidad()%></td>
                    <td><%= cc.getArea()%></td>
                    <td><%= (cc.getTelefono() != null) ? cc.getTelefono() : "-" %></td>
                    <td><%= cc.getEmail() %></td>
                    <td><%= cc.getNumTiendas()%></td>
                    <td><%= cc.getIdUsuario()%></td>
                    <td><%= cc.tranformarContrasenya(cc.getContrasenya())%></td>
                    <td><a href="/usuarioEntities/editarCrear?id=<%= cc.getIdUsuario()%>&idRol=<%= cc.getRolId()%>" class="btn btn-sm btn-warning">Editar</a></td>
                    <td><a href="/usuarioEntities/borrar?id=<%= cc.getIdUsuario()%>" class="btn btn-sm btn-danger">Borrar</a></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>

            <div class="mt-20" style="display:flex;gap:10px;flex-wrap:wrap;">
                <a href="/usuarioEntities/editarCrear?idRol=<%=2%>" class="btn btn-primary">Añadir Coordinador</a>
                <a href="/usuarioEntities/editarCrear?idRol=<%=3%>" class="btn btn-primary">Añadir Capitán</a>
                <a href="/usuarioEntities/editarCrear?idRol=<%=6%>" class="btn btn-primary">Añadir Coordinador - Capitán</a>
                <a href="/menu" class="btn btn-secondary">Volver al menú</a>
            </div>
        </section>

        <aside class="details-panel">
            <div class="panel-header">USUARIO SELECCIONADO</div>
            <div id="vista-detalle">
                <div class="detail-row"><span>ID:</span><strong>---</strong></div>
                <div class="detail-row"><span>ENTIDAD:</span><strong>---</strong></div>
                <div class="detail-row"><span>ÁREA:</span><strong>---</strong></div>
                <div class="detail-row"><span>TELÉFONO:</span><strong>---</strong></div>
                <div class="detail-row"><span>CORREO:</span><strong>---</strong></div>
                <div class="detail-row"><span>TIENDAS:</span><strong>---</strong></div>
                <div class="detail-row"><span>USUARIO:</span><strong>---</strong></div>
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