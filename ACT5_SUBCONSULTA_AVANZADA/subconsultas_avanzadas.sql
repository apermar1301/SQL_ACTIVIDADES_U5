-- ACT1: Productos por encima de la media
SELECT
    ID,
    AVG(precio) nombre,
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

-- ACT2: El pago más elevado
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

-- ACT3: Stock máximo
SELECT
    *
FROM
    productos
WHERE
    stock = (
        SELECT
            MAX(stock)
        FROM
            productos
    )
    -- ACT4: Clientes que han realizado pagos
SELECT
    *
FROM
    clientes
WHERE
    id in (
        SELECT
            idCliente
        FROM
            pagos
    );

-- ACT5: Clientes sin pagos (Morosidad potencial)
SELECT
    *
FROM
    clientes
WHERE
    id not in (
        SELECT
            idCliente
        FROM
            pagos
    );

-- ACT6: Productos más caros de su gama
SELECT
    p1.nombre,
    p1.precio
FROM
    productos p1
WHERE
    p1.precio > (
        SELECT
            AVG(p2.precio)
        FROM
            productos p2
        WHERE
            p2.idGama = p1.idGama
    );

-- ACT7: Pagos superiores a la media del cliente
SELECT
    p1.*
FROM
    pagos p1
WHERE
    p1.cantidad > (
        SELECT
            AVG(p2.cantidad)
        FROM
            pagos p2
        WHERE
            p1.idCliente = p2.idCliente
    );

-- ACT8: Clientes con pedidos
SELECT
    *
FROM
    clientes c
WHERE
    EXISTS (
        SELECT
            *
        FROM
            pagos p
        WHERE
            p.idCliente = c.id
    );

-- ACT9: Clientes sin pedidos
SELECT
    *
FROM
    clientes c
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            pagos p
        WHERE
            p.idCliente = c.id
    );

-- ACT10: Análisis global de clientes activos
SELECT
    *
FROM
    clientes c
WHERE
    EXISTS (
        SELECT
            *
        FROM
            pedidos pe
        WHERE
            pe.idCliente = c.id
    )
    AND EXISTS (
        SELECT
            *
        FROM
            pagos pa
        WHERE
            pa.idCliente = c.id
            AND pa.cantidad > (
                SELECT
                    AVG(cantidad)
                FROM
                    pagos
            )
    );