INSERT INTO "public"."entidad_colaboradora" ("id_entidad", "id_responsable", "nombre_entidad", "tipo",
                                             "ligado_bancosol", "id_direccion", "codigo_colaborador", "fecha_alta",
                                             "estado_aprobacion", "observaciones")
VALUES (1, 9, 'Colegio San José', 'Colegio', true, 1, 'A0421', '2026-01-10', true, null),
       (2, 7, 'Asociación Vecinos Centro', 'Asociación', false, 2, 'B0001', '2026-02-15', false, null),
       (4, 7, 'Empresa Logística S.A.', 'Empresa', true, 4, 'A0423', '2026-03-05', true, null),
       (5, 2, 'Voluntarios Solidarios', 'Independiente', false, 5, 'B0002', '2026-03-10', true, null),
       (6, 5, 'IES Málaga', 'Centro Educativo', true, 1, 'A0424', '2026-03-12', true, null),
       (7, 5, 'Pareja Pérez-Ruiz', 'Pareja', true, 2, 'A0425', '2026-03-15', true, null),
       (8, 5, 'Asociación Barriada', 'Asociación', true, 3, 'B0003', '2026-03-20', false, null),
       (12, 19, 'IES Sierra de Mijas', 'Asociación', true, 7, null, null, false, null),
       (13, 8, 'Asociación Barriada', 'Asociación', true, 8, null, null, false, null);