-- ACT1: Vista de directorio de oficinas
CREATE VIEW
    vista_directorio_oficinas AS
SELECT
    codigo,
    ciudad,
    telefono
FROM
    oficinas;

-- ACT2: Vistas de productos con gama (simplificación de JOIN)
CREATE VIEW
    vista_productos_info AS
SELECT
    p.nombre,
    p.stock,
    p.precio,
    g.nombre AS gama
FROM
    productos AS p
    INNER JOIN gamas AS g ON p.idGama = g.id;

-- ACT3: Vista de seguridad de empleados
CREATE VIEW
    vista_empleados_publico AS
SELECT
    nombre,
    apellido1,
    email
FROM
    empleados;

-- ACT4: Vista de clientes españoles
CREATE VIEW
    vista_clientes_es AS
SELECT
    *
FROM
    clientes
WHERE
    pais = 'España';