-- ACT1: Nombres de clientes en mayúscula
SELECT
    nombre,
    UPPER(nombre) AS nombreMayuscula
FROM
    clientes;

-- ACT2: Normalización de ciudades
SELECT
    nombre,
    LOWER(ciudad) AS ciudadMinuscula
FROM
    clientes;

-- ACT3: Nombre completo de empleados
SELECT
    concat (nombre, ' ', apellido1, ' ', apellido2) AS nombreCompleto
FROM
    empleados;

-- ACT4: Dirección completa de oficinas
SELECT
    concat (direccion, ', ', ciudad, ', ', cp, ', ', pais) AS direccion
FROM
    oficinas;