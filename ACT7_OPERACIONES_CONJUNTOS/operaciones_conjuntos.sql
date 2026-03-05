-- ACT1: Ciudades con presencia comercial
SELECT
    ciudad
FROM
    oficinas
UNION
SELECT
    ciudad
FROM
    clientes;

-- ACT2: Todas las ciudades (con duplicados)
SELECT
    ciudad
FROM
    oficinas
UNION ALL
SELECT
    ciudad
FROM
    clientes;

-- ACT3: Personas realcionadas con la empresa
SELECT
    concat (nombre, " ", apellido1, " ", apellido2) AS nombre
FROM
    empleados
UNION
SELECT
    nombre
FROM
    clientes;

-- ACT4: Ciudades con oficina y clientes
SELECT
    ciudad
FROM
    oficinas
INTERSECT
SELECT
    ciudad
FROM
    clientes;

-- ACT5: Ciudades con clientes pero sin oficina
SELECT
    ciudad
FROM
    clientes
EXCEPT
SELECT
    ciudad
FROM
    oficinas;

-- ACT6: Clientes con pedidos en 2025
SELECT
    id
FROM
    clientes
INTERSECT
SELECT
    idCliente
FROM
    pedidos
WHERE
    YEAR (fecha) = 2025;

-- ACT7: Clientes con pagos en 2025
SELECT
    id
FROM
    clientes
INTERSECT
SELECT
    idCliente
FROM
    pagos
WHERE
    YEAR (fecha) = 2025;

-- ACT8: Clientes con pedidos Y pagos en 2025
SELECT DISTINCT
    idCliente
FROM
    pedidos
WHERE
    year (fecha) = 2025
Intersect
SELECT DISTINCT
    idCliente
FROM
    pagos
WHERE
    year (fecha) = 2025;

-- ACT9: Análisis de actividad de clientes (Unión)
SELECT
    idCliente
FROM
    pedidos
UNION
SELECT
    idCliente
FROM
    pagos