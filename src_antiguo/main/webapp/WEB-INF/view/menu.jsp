<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú Principal - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>
    <div class="container-menu">
        <%
            Object userObj = session.getAttribute("user");
            String userName = userObj != null ? userObj.toString() : "Usuario";
        %>

        <div class="user-info">
            Bienvenido, <strong><%= userName %></strong>
        </div>

        <div class="header">
            <h1>Bancosol</h1>
            <p>Gestión y Administración</p>
        </div>

        <div class="buttons-grid">
            <a href="/campanas" class="btn-menu btn-campanias">
                📋 Gestión Campañas
            </a>
            <a href="/entidades" class="btn-menu btn-colaboradores">
                🤝 Gestión Colaboradores
            </a>
            <a href="/usuarioEntities/coordinadores-capitanes" class="btn-menu btn-coordinadores">
                👔 Gestión Coordinadores-Capitanes
            </a>
            <a href="/tiendaEntities" class="btn-menu btn-tiendaEntities">
                🏪 Gestión Tiendas
            </a>
            <a href="/voluntarios/listar" class="btn-menu btn-voluntarios">
                👥 Gestión Voluntarios
            </a>
        </div>

        <div class="footer">
            <a href="/salir" class="btn-logout">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>

