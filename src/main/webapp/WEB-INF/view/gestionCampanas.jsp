<%@ page import="es.uma.tsaw.proyectobancosol.entity.Campanya" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Campanya> campanas    = (List<Campanya>) request.getAttribute("campanas");
    List<Cadena>   cadenas     = (List<Cadena>)   request.getAttribute("cadenas");
    String         cadenasJson = (String)          request.getAttribute("cadenasJson");
    String         campanasJson = (String)         request.getAttribute("campanasJson");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>

<h1>Gestión de Campañas</h1>

<form method="post" action="campanas/guardarTodo">

    <!-- id de la campaña que se está editando (vacío si es nueva) -->
    <input type="hidden" name="campanaEditId" id="campanaEditId" value="">

    <!-- ── CAMPAÑAS EXISTENTES ── -->
    <h2>Campaña</h2>
    <%
        if (campanas != null) {
            for (Campanya camp : campanas) {
    %>
    <div>
        <input type="radio" name="campanaId" value="<%= camp.getIdCampanya() %>" id="camp_<%= camp.getIdCampanya() %>">
        <a href="#" onclick="abrirEdicion(<%= camp.getIdCampanya() %>); return false;">
            <%= camp.getNombreCampanya() != null ? camp.getNombreCampanya() : "(sin nombre)" %>
        </a>
        (<%= camp.getEstado() %>)
    </div>
    <%
            }
        }
    %>

    <!-- ── FORMULARIO NUEVA / EDITAR CAMPAÑA ── -->
    <br>
    <button type="button" onclick="abrirNueva()">Añadir campaña</button>

    <div id="formCampana" style="display:none; margin-top:8px;">
        <b id="formCampanaTitulo">Nueva campaña:</b><br>
        Nombre: <input type="text" name="campanaNombre" id="campanaNombre">
        &nbsp;
        Tipo: <input type="text" name="campanaTipo" id="campanaTipo">
        &nbsp;
        Estado: <input type="text" name="campanaEstado" id="campanaEstado">
        &nbsp;
        Fecha inicio: <input type="date" name="campanaFechaInicio" id="campanaFechaInicio">
        &nbsp;
        Fecha fin: <input type="date" name="campanaFechaFin" id="campanaFechaFin">
    </div>

    <hr>

    <!-- ── CADENAS ── -->
    <h2>Cadenas</h2>
    <p id="mensajeCadenas"><em>Selecciona una campaña para ver sus cadenas.</em></p>

    <%
        if (cadenas != null) {
            for (Cadena cad : cadenas) {
    %>
    <div class="fila-cadena" id="fila_<%= cad.getIdCadena() %>" style="display:none;">
        <input type="checkbox" name="cadenaIds" value="<%= cad.getIdCadena() %>" id="cad_<%= cad.getIdCadena() %>">
        <a href="campanas/cadenas/editar?id=<%= cad.getIdCadena() %>"><%= cad.getNombreCadena() %></a>
        <input type="hidden" name="cadenasBorrar" value="<%= cad.getIdCadena() %>" id="borrar_<%= cad.getIdCadena() %>" disabled>
        <button type="button" onclick="marcarParaBorrar(<%= cad.getIdCadena() %>)">Eliminar</button>
    </div>
    <%
            }
        }
    %>

    <br>
    <a href="campanas/cadenas/nueva">Añadir cadena</a>

    <hr>

    <input type="submit" name="accion" value="Guardar cambios">

</form>

<br>
<a href="/">Salir</a>

<script>
    var cadenasporCampana = <%= cadenasJson  != null ? cadenasJson  : "{}" %>;
    var datosCampanas     = <%= campanasJson != null ? campanasJson : "{}" %>;

    function mostrarCadenas(marcarIds) {
        var ids = marcarIds || [];
        document.querySelectorAll('.fila-cadena').forEach(function (fila) {
            fila.style.display = 'block';
            var cb = fila.querySelector('input[type="checkbox"]');
            cb.checked = ids.indexOf(parseInt(cb.value)) !== -1;
        });
        document.getElementById('mensajeCadenas').style.display = 'none';
    }

    function cerrarFormulario() {
        document.getElementById('formCampana').style.display = 'none';
        document.getElementById('campanaEditId').value = '';
        document.getElementById('campanaNombre').value = '';
        document.getElementById('campanaTipo').value = '';
        document.getElementById('campanaEstado').value = '';
        document.getElementById('campanaFechaInicio').value = '';
        document.getElementById('campanaFechaFin').value = '';
    }

    function abrirNueva() {
        var div = document.getElementById('formCampana');
        if (div.style.display !== 'none' && document.getElementById('campanaEditId').value === '') {
            cerrarFormulario();
            return;
        }
        cerrarFormulario();
        document.getElementById('formCampanaTitulo').textContent = 'Nueva campaña:';
        div.style.display = 'block';
        // Deseleccionar radios y mostrar cadenas sin marcar
        document.querySelectorAll('input[name="campanaId"]').forEach(function (rb) { rb.checked = false; });
        mostrarCadenas([]);
    }

    function abrirEdicion(id) {
        var datos = datosCampanas[id];
        if (!datos) return;
        cerrarFormulario();
        document.getElementById('campanaEditId').value        = id;
        document.getElementById('campanaNombre').value        = datos.nombre;
        document.getElementById('campanaTipo').value          = datos.tipo;
        document.getElementById('campanaEstado').value        = datos.estado;
        document.getElementById('campanaFechaInicio').value   = datos.fechaInicio;
        document.getElementById('campanaFechaFin').value      = datos.fechaFin;
        document.getElementById('formCampanaTitulo').textContent = 'Modificar campaña:';
        document.getElementById('formCampana').style.display = 'block';
        // Seleccionar el radio y mostrar sus cadenas
        var rb = document.getElementById('camp_' + id);
        if (rb) rb.checked = true;
        mostrarCadenas(cadenasporCampana[id] || []);
    }

    function marcarParaBorrar(idCadena) {
        document.getElementById('fila_' + idCadena).style.display = 'none';
        document.getElementById('cad_' + idCadena).checked = false;
        document.getElementById('borrar_' + idCadena).disabled = false;
    }

    document.querySelectorAll('input[name="campanaId"]').forEach(function (rb) {
        rb.addEventListener('change', function () {
            mostrarCadenas(cadenasporCampana[this.value] || []);
            cerrarFormulario();
        });
    });
</script>

</body>
</html>
