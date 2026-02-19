-- ACT1: Productos Premium
SELECT
    nombre,
    precio
FROM
    productos
WHERE
    precio > (
        SELECT
            AVG(precio)
        FROM
            productos
    );

-- ACT2: El mayor ingreso
SELECT
    *
FROM
    pagos
WHERE
    cantidad = (
        SELECT
            MAX(cantidad)
        FROM
            pagos
    );

-- ACT3: Stock crítico
SELECT
    *
FROM
    productos
WHERE
    stock < (
        SELECT
            stock
        FROM
            productos
        WHERE
            ID = 5
    );

-- ACT4: Pagos de referencia
SELECT
    nombre
FROM
    clientes
WHERE
    EXISTS (
        SELECT
            *
        FROM
            pagos
        WHERE
            cantidad = (
                SELECT
                    MIN(cantidad)
                FROM
                    pagos
            )
    );

-- ACT5: Gamas sin rotación:
SELECT
    *
FROM
    gamas g
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            productos p
        WHERE
            p.idGama = g.id
            AND p.stock > 200
    );

-- ACT6: Comparativa ANY
SELECT
    *
FROM
    productos
WHERE
    precio > ANY (
        SELECT
            precio
        FROM
            productos
        WHERE
            idGama = (
                SELECT
                    ID
                FROM
                    gamas
                WHERE
                    nombre = 'Frutales'
            )
    );

-- ACT7: Comparativa ALL
SELECT
    a.*
FROM
    pagos AS a
WHERE
    a.cantidad > ALL (
        SELECT
            b.cantidad
        FROM
            pagos AS b
        WHERE
            b.id = 1
    );

-- ACT8: Oficinas activas
SELECT
    ciudad
FROM
    oficinas
WHERE
    ID IN (
        SELECT
            idOficina
        FROM
            empleados
        WHERE
            puesto = 'Dir'
    );

-- ACT9: Lógica por ciudad
SELECT
FROM
    clientes
WHERE
    EXISTS (
        SELECT
            *
        FROM
            pagos
        WHERE
            cantidad > (
                SELECT
                FROM
                    
            )
    )