<%--
Página JSP que muestra el menú principal de la aplicación con acceso a los distintos módulos.

Autores:
- Sergio Aldana: 67%
- IA generativa: 33%

--%>

<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.UsuarioEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú Principal - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body class="welcome-page">

    <header class="main-header">
        <div class="logo-area">
            <img src="${pageContext.request.contextPath}/images/LOGO_BANCOSOL_FOOTER.png" alt="Bancosol Logo">
        </div>
    </header>

    <main>
        <div class="welcome-box">

            <%
                UsuarioEntity userObj = (UsuarioEntity) session.getAttribute("user");
                String userName = userObj != null ? userObj.getNombre() : "Usuario";
            %>

            <div class="panel-control">
                Bienvenido, <strong><%= userName %></strong>
            </div>

            <section>
                <a href="/campanas" class="menu-btn">Gestión Campañas</a>
                <a href="/entidades" class="menu-btn">Gestión Colaboradores</a>
                <a href="/usuarios/coordinadores-capitanes" class="menu-btn">Gestión Coordinadores-Capitanes</a>
                <a href="/tiendas" class="menu-btn">Gestión Tiendas</a>
                <a href="/voluntarios/listar" class="menu-btn">Gestión Voluntarios</a>
            </section>

            <div class="logout-container">
                <a href="/salir" class="boton-logout">Cerrar Sesión</a>
            </div>

        </div>
    </main>

    <footer>
        <p>&copy; 2026 Bancosol | Grupo 4</p>
    </footer>
</body>
</html>