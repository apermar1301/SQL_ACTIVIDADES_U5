-- ACT1: Nueva oficina
INSERT INTO
    oficinas (codigo, ciudad, pais, cp, telefono, direccion)
VALUES
    (
        'ALM-ES',
        'Almería',
        'España',
        '04001',
        '+34 950 11 22 33',
        'C/ Paseo de Almería, 10'
    );

-- ACT2: Nuevo empleado
SELECT
    codigo
FROM
    oficinas
WHERE
    codigo = 'ALM-ES';

--31
INSERT INTO
    empleados (
        nombre,
        apellido1,
        apellido2,
        email,
        puesto,
        idOficina
    )
VALUES
    (
        'Laura',
        'Martínez',
        'González',
        'laura.martinez@v.es',
        'Ven',
        31
    );

-- ACT3: Nueva gama de productos
INSERT INTO
    gamas (nombre, descripcion)
VALUES
    (
        'Automatización',
        'Sensores y sistemas de riesgo automático.'
    );

-- ACT4: Listado de oficinas
SELECT
    codigo,
    ciudad,
    telefono,
    pais
FROM
    oficinas;

-- ACT5: Listado de empleados
SELECT
    nombre,
    apellido1 AS apellido,
    email
FROM
    empleados;

-- ACT6: Puestos de la empresa
SELECT DISTINCT
    puesto
FROM
    empleados;

-- ACT7: Productos más caros
SELECT
    nombre,
    precio
FROM
    productos
ORDER BY
    precio DESC;

-- ACT8: TOP 3 de productos con más stock
SELECT
    nombre,
    stock
FROM
    productos
ORDER BY
    stock DESC
LIMIT
    3;

-- ACT9: Precio con IVA
SELECT
    nombre,
    precio,
    precio * 1.21 AS 'precio + iva'
FROM
    productos;

-- ACT10: Clientes de España
SELECT
    nombre,
    ciudad
FROM
    clientes
WHERE
    pais = 'España';

-- ACT11: Pedidos pendientes
SELECT
    ID,
    fecha
FROM
    pedidos
WHERE
    estado = 'Pendiente';

-- ACT12: Pagos elevados
SELECT
    idCliente,
    forma,
    cantidad
FROM
    pagos
WHERE
    cantidad > 100;

-- ACT13: Productos de una gama concreta
SELECT
    *
FROM
    productos
WHERE
    idGama = 2;

-- ACT14: Clientes de Madrid o Barcelona
SELECT
    nombre,
    ciudad,
    pais
FROM
    clientes
WHERE
    ciudad IN ('Madrid', 'Barcelona');

-- ACT15: Productos caros de herramientas
SELECT
    *
FROM
    productos
WHERE
    idGama = 1
    AND precio > 30;

-- ACT16: Pedidos del año 2025
SELECT
    ID,
    fecha,
    estado
FROM
    pedidos
WHERE
    YEAR (fecha) = 2025;

-- ACT17: Búsqueda por patrón (empieza por J)
SELECT
    nombre,
    telefono
FROM
    clientes
WHERE
    nombre LIKE 'J%';

-- ACT18: Búsqueda por patrón (contiene 'Tijera')
SELECT
    nombre
FROM
    productos
WHERE
    nombre LIKE '%Tijera%';

-- ACT19: Control de nulos
SELECT
    nombre
FROM
    clientes
WHERE
    idEmpleado IS NULL;

-- ACT20: Filtro lógico complejo
SELECT
    nombre,
    idGama AS gama,
    precio
FROM
    productos
WHERE
    (
        idGama = 3
        AND precio > 3
    )
    OR (
        idGama = 4
        AND precio > 40
    );