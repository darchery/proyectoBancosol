<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Menú Principal - Bancosol</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .container-menu {
            width: 100%;
            max-width: 1000px;
            padding: 20px;
        }
        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
        }
        .header h1 {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        .buttons-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .btn-menu {
            padding: 30px;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 10px;
            color: white;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 150px;
            text-align: center;
        }
        .btn-menu:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.3);
            text-decoration: none;
            color: white;
        }
        .btn-campanias {
            background-color: #3498db;
        }
        .btn-colaboradores {
            background-color: #e74c3c;
        }
        .btn-coordinadores {
            background-color: #2ecc71;
        }
        .btn-tiendas {
            background-color: #f39c12;
        }
        .btn-voluntarios {
            background-color: #9b59b6;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
        }
        .btn-logout {
            background-color: #95a5a6;
            color: white;
            padding: 10px 30px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s;
            display: inline-block;
        }
        .btn-logout:hover {
            background-color: #7f8c8d;
            text-decoration: none;
            color: white;
        }
        .user-info {
            color: white;
            text-align: center;
            margin-bottom: 20px;
            font-size: 0.95rem;
        }
    </style>
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
            <a href="/usuarios/coordinadores-capitanes" class="btn-menu btn-coordinadores">
                👔 Gestión Coordinadores-Capitanes
            </a>
            <a href="/tiendas" class="btn-menu btn-tiendas">
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

