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
