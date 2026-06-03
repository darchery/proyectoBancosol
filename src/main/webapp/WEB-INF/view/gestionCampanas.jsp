<%@ page import="es.uma.tsaw.proyectobancosol.dto.CampanyaDTO" %>
<%@ page import="es.uma.tsaw.proyectobancosol.entity.Cadena" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<CampanyaDTO> campanas = (List<CampanyaDTO>) request.getAttribute("campanas");
    List<Cadena>      cadenas  = (List<Cadena>)      request.getAttribute("cadenas");
    String cadenasJson         = (String) request.getAttribute("cadenasJson");
    String campanasJson        = (String) request.getAttribute("campanasJson");
%>

<html>
<head>
    <title>Gestión de Campañas - Bancosol</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style_bancosol.css">
</head>
<body>

<h1>Gestión de Campañas</h1>

<%
    String msg = (String) request.getAttribute("msg");
    if (msg != null) {
        boolean esError = msg.startsWith("error:");
        String texto = msg.substring(msg.indexOf(":") + 1);
        String color = esError ? "#c0392b" : "#27ae60";
%>
<p style="color:<%= color %>; font-weight:bold;"><%= texto %></p>
<% } %>

<form method="post" action="campanas/guardarTodo">

    <input type="hidden" name="campanaEditId"      id="campanaEditId"      value="">
    <input type="hidden" name="campanaNombre"       id="campanaNombre"      value="">
    <input type="hidden" name="campanaEstado"       id="campanaEstado"      value="">
    <input type="hidden" name="campanaTipo"         id="campanaTipo"        value="">
    <input type="hidden" name="campanaFechaInicio"  id="campanaFechaInicio" value="">
    <input type="hidden" name="campanaFechaFin"     id="campanaFechaFin"    value="">

    <div style="display:flex; gap:40px; align-items:flex-start;">

        <!-- ── COLUMNA IZQUIERDA: TIPO DE CAMPAÑA ── -->
        <div>
            <h2>Tipo de campaña</h2>
            <div>
                <input type="radio" name="tipoCampanyaSeleccionado" value="GR"
                       id="tipo_GR" onchange="seleccionarTipo('GR')">
                <label for="tipo_GR">Gran Recogida</label>
            </div>
            <div>
                <input type="radio" name="tipoCampanyaSeleccionado" value="primavera"
                       id="tipo_primavera" onchange="seleccionarTipo('primavera')">
                <label for="tipo_primavera">Operación Primavera</label>
            </div>
        </div>

        <!-- ── COLUMNA DERECHA: CADENAS ── -->
        <div>
            <h2>Cadenas
                <span id="campanaSeleccionadaLabel" style="font-weight:normal; font-size:0.85em;"></span>
            </h2>
            <%
                if (cadenas != null) {
                    for (Cadena cad : cadenas) {
            %>
            <div id="fila_<%= cad.getIdCadena() %>">
                <input type="checkbox" name="cadenaIds"
                       value="<%= cad.getIdCadena() %>"
                       id="cad_<%= cad.getIdCadena() %>">
                <a href="campanas/cadenas/editar?id=<%= cad.getIdCadena() %>">
                    <%= cad.getNombreCadena() %>
                </a>
                <input type="hidden" name="cadenasBorrar"
                       value="<%= cad.getIdCadena() %>"
                       id="borrar_<%= cad.getIdCadena() %>"
                       disabled>
                <button type="button" onclick="marcarParaBorrar(<%= cad.getIdCadena() %>)">
                    Eliminar
                </button>
            </div>
            <%
                    }
                }
            %>
            <br>
            <a href="campanas/cadenas/nueva">Añadir cadena</a>
        </div>

    </div>

    <hr>

    <!-- ── HISTORIAL (oculto por defecto) ── -->
    <div id="divHistorial" style="display:none;">
        <h2>Historial de campañas</h2>
        <table border="1" cellpadding="5">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Tipo</th>
                <th>Estado</th>
                <th>Fecha inicio</th>
                <th>Fecha fin</th>
            </tr>
            </thead>
            <tbody id="tbodyHistorial"></tbody>
        </table>
        <br>
        <button type="button" onclick="document.getElementById('divHistorial').style.display='none'">Cerrar historial</button>
        <br>
    </div>

    <!-- ── BOTONES ── -->
    <button type="button" onclick="generarCampana()">Generar campaña</button>
    &nbsp;
    <button type="button" onclick="verHistorial()">Ver historial</button>
    &nbsp;
    <input type="submit" value="Guardar cambios">

    <!-- ── FORMULARIO NUEVA CAMPAÑA ── -->
    <div id="modalFechas" style="display:none;">
        <hr>
        <h3>Nueva campaña</h3>
        <p id="modalTipoLabel"></p>

        <label for="inputFechaInicio">Fecha de inicio:</label>
        <input type="date" id="inputFechaInicio">
        <br><br>

        <label for="inputFechaFin">Fecha de fin:</label>
        <input type="date" id="inputFechaFin">
        <br><br>

        <p id="errorFechas" style="display:none; color:red;"></p>

        <button type="button" onclick="confirmarGeneracion()">Confirmar</button>
        <button type="button" onclick="cerrarModal()">Cancelar</button>
        <hr>
    </div>

</form>

<br>
<a href="/">Salir</a>

<script>

    var cadenasporCampana = <%= cadenasJson  != null ? cadenasJson  : "{}" %>;
    var datosCampanas     = <%= campanasJson != null ? campanasJson : "{}" %>;

    var todasCampanas = [];
    <%
        if (campanas != null) {
            for (CampanyaDTO c : campanas) {
                String nombre = c.getNombreCampanya() != null ? c.getNombreCampanya().replace("\"","\\\"") : "";
                String estado = c.getEstado()         != null ? c.getEstado().replace("\"","\\\"")         : "";
                String tipo   = c.getTipoCampanya()   != null ? c.getTipoCampanya().replace("\"","\\\"")   : "";
                String fi     = c.getFechaInicio()    != null ? c.getFechaInicio()                         : "";
                String ff     = c.getFechaFin()       != null ? c.getFechaFin()                            : "";
    %>
    todasCampanas.push({ id: <%= c.getIdCampanya() %>, nombre: "<%= nombre %>", tipo: "<%= tipo %>", estado: "<%= estado %>", fechaInicio: "<%= fi %>", fechaFin: "<%= ff %>" });
    <%
            }
        }
    %>

    var tipoSeleccionado = null;

    function seleccionarTipo(tipo) {
        tipoSeleccionado = tipo;
    }

    function generarCampana() {
        if (!tipoSeleccionado) {
            alert('Selecciona un tipo de campaña.');
            return;
        }

        var anyo = new Date().getFullYear();
        var etiquetas = { GR: 'Gran Recogida', primavera: 'Operación Primavera' };

        var yaExiste = todasCampanas.some(function(c) {
            return c.tipo === tipoSeleccionado && c.nombre.indexOf(String(anyo)) !== -1;
        });

        if (yaExiste) {
            alert('Ya existe una campaña de tipo "' + (etiquetas[tipoSeleccionado] || tipoSeleccionado) + '" para ' + anyo + '.');
            return;
        }

        document.getElementById('modalTipoLabel').textContent =
            (etiquetas[tipoSeleccionado] || tipoSeleccionado) + ' ' + anyo;

        document.getElementById('inputFechaInicio').value = '';
        document.getElementById('inputFechaFin').value    = '';
        document.getElementById('errorFechas').style.display = 'none';
        document.getElementById('modalFechas').style.display = 'block';
    }

    function confirmarGeneracion() {
        var fi  = document.getElementById('inputFechaInicio').value;
        var ff  = document.getElementById('inputFechaFin').value;
        var err = document.getElementById('errorFechas');

        if (!fi || !ff) {
            err.textContent = 'Ambas fechas son obligatorias.';
            err.style.display = 'block';
            return;
        }
        if (ff <= fi) {
            err.textContent = 'La fecha de fin debe ser posterior a la de inicio.';
            err.style.display = 'block';
            return;
        }

        var anyo = new Date().getFullYear();
        document.getElementById('campanaNombre').value      = tipoSeleccionado + ' ' + anyo;
        document.getElementById('campanaTipo').value        = tipoSeleccionado;
        document.getElementById('campanaEstado').value      = 'ACTIVA';
        document.getElementById('campanaEditId').value      = '';
        document.getElementById('campanaFechaInicio').value = fi;
        document.getElementById('campanaFechaFin').value    = ff;

        cerrarModal();
        document.querySelector('form').submit();
    }

    function cerrarModal() {
        document.getElementById('modalFechas').style.display = 'none';
    }

    function verHistorial() {
        var tbody = document.getElementById('tbodyHistorial');
        tbody.innerHTML = '';

        if (todasCampanas.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5"><em>No hay campañas registradas.</em></td></tr>';
        } else {
            todasCampanas.forEach(function(c) {
                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td><a href="#" onclick="seleccionarCampana(' + c.id + '); return false;">' + (c.nombre || '(sin nombre)') + '</a></td>' +
                    '<td>' + (c.tipo        || '') + '</td>' +
                    '<td>' + (c.estado      || '') + '</td>' +
                    '<td>' + (c.fechaInicio || '') + '</td>' +
                    '<td>' + (c.fechaFin    || '') + '</td>';
                tbody.appendChild(tr);
            });
        }

        document.getElementById('divHistorial').style.display = 'block';
    }

    function seleccionarCampana(id) {
        var datos = datosCampanas[id];
        if (!datos) return;

        document.getElementById('campanaEditId').value       = id;
        document.getElementById('campanaNombre').value       = datos.nombre;
        document.getElementById('campanaTipo').value         = datos.tipo;
        document.getElementById('campanaEstado').value       = datos.estado;
        document.getElementById('campanaFechaInicio').value  = datos.fechaInicio;
        document.getElementById('campanaFechaFin').value     = datos.fechaFin;

        document.getElementById('campanaSeleccionadaLabel').textContent =
            '— editando: ' + (datos.nombre || '(sin nombre)');

        var ids = cadenasporCampana[id] || [];
        document.querySelectorAll('input[name="cadenaIds"]').forEach(function(cb) {
            cb.checked = ids.indexOf(parseInt(cb.value)) !== -1;
        });
    }

    function marcarParaBorrar(idCadena) {
        document.getElementById('fila_'   + idCadena).style.display = 'none';
        document.getElementById('cad_'    + idCadena).checked = false;
        document.getElementById('borrar_' + idCadena).disabled = false;
    }

</script>

</body>
</html>
