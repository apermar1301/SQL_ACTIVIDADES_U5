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
    c.id,
    c.nombre
FROM
    clientes c
WHERE
    EXISTS (
        SELECT
            1
        FROM
            pagos p
        WHERE
            p.idCliente = c.id
            AND p.cantidad > (
                SELECT
                    AVG(p2.cantidad)
                FROM
                    pagos p2
                WHERE
                    p2.idCliente IN (
                        SELECT
                            c2.id
                        FROM
                            clientes c2
                        WHERE
                            c2.ciudad = c.ciudad
                    )
            )
    );

-- ACT10: Precios por gama
SELECT
    *
FROM
    productos AS a
WHERE
    precio > (
        SELECT
            AVG(precio)
        FROM
            productos AS b
        WHERE
            a.idGama = b.idGama
    );

-- ACT11: Pedidos por cliente
SELECT
    c.nombre
FROM
    clientes AS c
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            pedidos AS p
        WHERE
            c.id = p.idCliente
    ) > (
        SELECT
            AVG(numPedidos)
        FROM
            (
                SELECT
                    COUNT(*) AS numPedidos
                FROM
                    pedidos
                GROUP BY
                    idCliente
            ) AS sub
    );

-- ACT12: Control de cartera (EXISTS)
SELECT
    *
FROM
    empleados AS e
WHERE
    EXISTS (
        SELECT
            *
        FROM
            clientes AS c
        WHERE
            e.id = c.idEmpleado
            AND NOT EXISTS (
                SELECT
                    *
                FROM
                    pagos AS p
                WHERE
                    p.idCliente = c.id
            )
    );

-- ACT13: Desviación de precio
SELECT
    nombre,
    precio,
    precio - (
        SELECT
            AVG(precio)
        FROM
            productos
    ) AS precioMedio
FROM
    productos;

-- ACT14: Contador de pedidos
SELECT
    c.nombre,
    (
        SELECT
            COUNT(*)
        FROM
            pedidos AS p
        WHERE
            c.id = p.id
    )
FROM
    clientes AS c;

-- ACT15: Última actividad
SELECT
    c.nombre,
    (
        SELECT
            MAX(fecha)
        FROM
            pedidos AS p
        WHERE
            p.idCliente = c.id
    ) AS ultimaActividad
FROM
    clientes AS c;

-- ACT16: Referencia de oficina
SELECT
    *,
    (
        SELECT
            COUNT(b.*)
        FROM
            empleados AS b
        WHERE
            a.idOficina = b.idOficina
    ) AS numeroColegas
FROM
    empleado AS a;

-- ACT17: Valor de cartera 
SELECT
    nombre,
    (
        SELECT
            MAX(cantidad)
        FROM
            pagos AS p
        WHERE
            p.idCliente = c.id
    ) AS importeMasAlto
FROM
    clientes AS c;

-- ACT18: Media de ventas totales
SELECT
    idCliente,
    mediaAritmetica
FROM
    (
        SELECT
            idCliente,
            AVG(cantidad) AS mediaAritmetica
        FROM
            pagos
        GROUP BY
            idCliente
    ) AS mediaAritmeticaTabla;

-- ACT19: Oficinas masificadas
SELECT
    o.ciudad
FROM
    oficinas AS o
WHERE
    EXISTS (
        SELECT
            AVG(salario)
        FROM
            empleados AS e
        WHERE
            e.idOficina = o.id
            AND salario > (
                SELECT
                    AVG(salario)
                FROM
                    empleados AS e2
                WHERE
                    e2.idOficina = o.id
            )
    );

-- ACT20: Gamas con gran inventario
SELECT
    g.*
FROM
    gamas AS g
WHERE
    (
        SELECT
            SUM(p.stock)
        FROM
            productos AS p
        WHERE
            p.idGama = g.id
    ) > 1000;

-- ACT22: Máximo de los promedios: Hallar cuál es el promedio de pago más alto de entre todos los promedios de los clientes.
-- ACTACT23: Ciudades sin oficina: Listar los clientes que viven en ciudades donde no existe ninguna oficina física.
-- ACTACT24: Doble negación: Mostrar las oficinas donde todos sus empleados han gestionado al menos un cliente (usando NOT EXISTS).
-- ACT25: Productos huérfanos: Obtener los productos que nunca han sido incluidos en un pedido (usando NOT IN sobre detallesPedidos).
-- ACT26: Pagos Premium: Listar los clientes cuyo pago máximo sea superior al pago máximo del cliente con ID 2.
-- ACT27: Gamas exclusivas: Mostrar los empleados que son expertos en gamas en las que no hay ningún otro experto (usando empleadosGamas).
-- ACT28: Clientes internacionales: Listar los clientes que pertenecen a un país donde no hay ninguna oficina registrada.
-- ACT29: Pedidos tardíos: Hallar los pedidos cuya fecha sea posterior a la fecha media de todos los pedidos.
-- ACT30: Ranking de facturación: Mostrar el nombre del cliente y cuántos clientes han pagado más que él en total acumulado.