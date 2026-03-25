-------------------------------------------------
-- Bloque 1: Aplicación y Explotación de Datos --
-------------------------------------------------
-- ACT1: Obtén un listado de todos los productos (nombre y precio) junto con el nombre de su gama.
SELECT
    p.nombre AS nombre,
    p.precio AS precio,
    g.nombre AS gama
FROM
    productos AS p
    INNER JOIN gamas AS g ON p.idGama = g.id;

-- ACT2: Muestra el nombre de los clientes que no han realizado ningún pago registrado hasta la fecha.
SELECT
    c.nombre
FROM
    clientes c
    LEFT JOIN pagos p ON p.idCliente = c.id
WHERE
    p.idCliente IS NULL;

-- ACT3: Calcula cuántos empleados trabajan en cada oficina, mostrando el código de la oficina y la ciudad.
SELECT
    o.codigo AS codigo,
    o.ciudad AS ciudad,
    COUNT(e.id) AS totalEmpleados
FROM
    oficinas AS o
    LEFT JOIN empleados AS e ON e.idOficina = o.id
GROUP BY
    o.codigo,
    o.ciudad;

-- ACT4: Muestra el nombre de los empleados que tienen nivel 'Experto' en la gama 'Frutales'.
SELECT
    e.nombre,
    g.nombre,
    eg.nivel
FROM
    empleadosGamas AS eg
    INNER JOIN empleados AS e ON e.id = eg.idEmpleado
    INNER JOIN gamas AS g ON g.id = eg.idGama
WHERE
    eg.nivel = 'Experto'
    AND g.nombre = 'Frutales';

-- ACT5: Obtén el ID de los pedidos realizados en el año 2025 que aún están en estado 'Pendiente'
SELECT
    ID,
    fecha,
    estado
FROM
    pedidos
WHERE
    YEAR (fecha) = 2025
    AND estado = 'Pendiente';

-- ACT6: Muestra el nombre del cliente y el nombre de su representante de ventas asignado. Si no tiene ninguno, debe aparecer el texto 'Sin Representante'.
SELECT
    c.nombre,
    IFNULL (e.nombre, 'SIN REPRESENTANTE')
FROM
    clientes AS c
    LEFT JOIN empleados AS e ON c.idEmpleado = e.id;

-- ACT7: Calcula el importe total recaudado de todos los pagos realizados mediante la forma 'PayPal'
SELECT
    forma,
    sum(cantidad)
FROM
    pagos
WHERE
    forma = 'PayPal'
GROUP BY
    forma;

-- ACT8: Muestra los productso que tienen un stock superior a la media de stock de todos los productos de la empresa
SELECT
    nombre
FROM
    productos
WHERE
    stock > (
        SELECT
            AVG(stock)
        FROM
            productos
    );

-- ACT9: Generar un listado con el ID de pedido, nombre del producto, cantidad y precio unitario de todos los detalles de pedidos.
SELECT
    DP.idPedido,
    P.nombre,
    DP.cantidad,
    DP.precioUnidad
FROM
    detallesPedidos AS DP
    INNER JOIN productos AS P ON P.id = DP.idProducto;

-- ACT10: Obtén una lista de ciudades donde la empresa tiene oficinas per no tiene clientes registrados
SELECT
    ciudad
FROM
    clientes AS c
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            oficinas AS o
        WHERE
            o.ciudad = c.ciudad
    );

-- ACT11: Calcula el gasto total (suma de pagos) de cada cliente, mostrando su nombre y el importe acumulado.
SELECT
    C.nombre,
    sum(P.cantidad) AS suma
FROM
    clientes AS C
    INNER JOIN pagos AS P ON C.id = P.idCliente
GROUP BY
    C.nombre;

-- ACT12: Muestra los empleados (nombre y apellidos) que no tienen ninguna especialidad técnica asignada en la tabla empleadosGamas.
SELECT
    E.nombre,
    CONCAT (E.apellido1, " ", E.apellido2)
FROM
    empleados AS E
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            empleadosGamas AS EG
        WHERE
            EG.idEmpleado = E.id
    );

-- ACT13: Lista los productos que aparecen en más de 5 líneas de pedido diferentes en la tabla detallesPedidos.
SELECT
    P.nombre,
    COUNT(DP.numeroLinea) AS NL
FROM
    detallesPedidos AS DP
    INNER JOIN productos AS P ON P.id = DP.idProducto
GROUP BY
    P.nombre
HAVING
    NL > 5;

-- ACT14: Muestra para cada producto su nombre, stock actual y una columna llamada 'Estado' que muestre 'Reponer' si el stock es inferior a 20, y 'OK' en caso contrario
SELECT
    nombre,
    stock,
    CASE
        WHEN stock < 20 THEN 'REPONER'
        ELSE 'OK'
    END AS Estado
FROM
    productos;

-- ACT15: Obtén el nombre del cliente que ha realizado el pago de mayor cuantía registrado.
SELECT
    c.nombre,
    p.cantidad
FROM
    pagos AS p
    INNER JOIN clientes AS c ON p.idCliente = c.id
WHERE
    p.cantidad = (
        SELECT
            MAX(cantidad)
        FROM
            pagos
    );

-- ACT16: Muestra las gamas de productos que tienen más de 10 productos diferentes asociados.
SELECT
    g.nombre
FROM
    gamas AS g
    INNER JOIN productos AS p ON p.idGama = g.id
GROUP BY
    g.nombre
HAVING
    COUNT(p.id) > 10;

-- ACT17: Obtén el nombre de los empleados y la ciudad de su oficina para aquellos que trabajan en ciudades cuyo nombre empieza por la letra 'M'.
SELECT
    e.nombre,
    o.ciudad
FROM
    empleados AS e
    INNER JOIN oficinas AS o ON e.idOficina = o.id
WHERE
    o.ciudad LIKE 'M%';

-- ACT18: Calcula el beneficio potencial de cada gama sumando el (precio * stock) de todos sus productos asociados.
SELECT
    g.nombre,
    p.precio * p.stock AS beneficioPotencial
FROM
    productos AS p
    INNER JOIN gamas AS g ON g.id = p.idGama;

-- ACT19: Muestra los clientes de 'España' que han realizado pagos superiores a la media de pagos de los clientes de 'Francia'.
SELECT
    c1.nombre,
    p1.cantidad
FROM
    clientes as c1
    INNER JOIN pagos as p1 on p1.idCliente = c1.id
WHERE
    c1.pais = 'España'
    AND p1.cantidad > (
        SELECT
            AVG(p2.cantidad)
        FROM
            clientes AS c2
            INNER JOIN pagos AS p2 ON p2.idCliente = c2.id
        WHERE
            c2.pais = 'Francia'
    );

-- ACT20: Genera un informe que muestre el mes y cuántos pedidos se realizaron en dicho mes durante el año 2025.
SELECT
    MONTH (fecha) AS mes,
    COUNT(*) AS numeroPedidos
FROM
    pedidos
WHERE
    YEAR (fecha) = 2025
GROUP BY
    MONTH (fecha);

-- ACT21: Lista los nombres de los productos que nunca han sido incluidos en ningún pedido utilizando la cláusula NOT EXISTS.
SELECT
    nombre
FROM
    productos AS P
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            detallesPedidos AS DP
        WHERE
            DP.idPedido = P.id
    );

-- ACT22: Para cada oficina, muestra la suma total de las cantidades pagadas por los clientes que son atendidos por empleados de esa oficina.
SELECT
    O.id,
    SUM(P.cantidad)
FROM
    oficinas AS O
    INNER JOIN pagos AS P ON C.id = P.idCliente
    INNER JOIN clientes AS C ON C.idEmpleado = E.id
    INNER JOIN empleados AS E ON E.idOficina = O.id
WHERE
    E.idOficina = O.id
GROUP BY
    O.id;

-- ACT23: Muestra el ID de pedido y el número de artículos distintos que tiene cada pedido en la tabla detallesPedidos.
SELECT
    idPedido,
    COUNT(DISTINCT idProducto) AS numArticulosDistintos
FROM
    detallesPedidos
GROUP BY
    idPedido;

-- ACT24: Obtén el nombre de los clientes que han comprado productos de la gama 'Herramientas' y también productos de la gama 'Cactus'.
SELECT
    C.nombre
FROM
    detallesPedidos as DP
    INNER JOIN productos as PR on DP.idProducto = PR.id
    INNER JOIN pedidos as PE on DP.idPedido = PE.id
    INNER JOIN clientes as C on PE.idCliente = C.id
    INNER JOIN gamas as G on PR.idGama = G.id
WHERE
    G.nombre in ('Herramientas', 'Cactus')
GROUP BY
    C.id
HAVING
    COUNT(DISTINCT G.nombre) = 2;

-- ACT25: Muestra los nombres de los empleados junto a la ciudad de su oficina, ordenados alfabéticamente por ciudad y después por apellido.
SELECT
    E.nombre,
    E.apellido1,
    O.ciudad
FROM
    empleados as E
    INNER JOIN oficinas as O on E.idOficina = O.id
ORDER BY
    O.ciudad ASC,
    E.apellido1 ASC;

-- ACT26: Calcula la media de productos distintos incluidos por pedido (variedad media de la cesta).
SELECT
    AVG(productosDistintos) AS mediaVariedad
FROM
    (
        SELECT
            idPedido,
            COUNT(DISTINCT idProducto) AS productosDistintos
        FROM
            detallesPedidos
        GROUP BY
            idPedido
    ) AS pedidos;

-- ACT27: Lista los clientes cuyo representante de ventas trabaja en una ciudad diferente a la ciudad de residencia del cliente.
SELECT
    C.nombre
FROM
    clientes as C
    INNER JOIN empleados as E on C.idEmpleado = E.id
    INNER JOIN oficinas as O on E.idOficina = O.ID
WHERE
    O.ciudad <> C.ciudad;

-- ACT28: Crea una vista llamada vista_resumen_gamas que muestre por cada gama: el número de productos, el stock total y el precio máximo.
CREATE VIEW
    vista_resumen_gamas AS
SELECT DISTINCT
    G.nombre,
    COUNT(P.id),
    SUM(P.stock),
    MAX(P.precio)
FROM
    gamas as G
    INNER JOIN productos as P on P.idGama = G.id
GROUP BY
    G.nombre;

-- ACT29: Muestra el ID del pedido y la suma total de dicho pedido (cantidad * precioUnidad) para aquellos pedidos cuyo total supere los 500€.
SELECT
    DP.idPedido,
    sum(DP.cantidad * DP.precioUnidad) as total
FROM
    detallesPedidos as DP
GROUP BY
    DP.idPedido
HAVING
    total > 500;

-- ACT30: Genera un ranking de empleados que incluya su nombre completo y el número total de especialidades técnicas que posee, ordenado de mayor a menor especialización.
SELECT
    concat (E.nombre, " ", apellido1, " ", apellido2),
    count(EG.idGama),
    EG.nivel
FROM
    empleadosGamas as EG
    INNER JOIN empleados as E on E.id = EG.idEmpleado
GROUP BY
    EG.idEmpleado
ORDER BY
    count(EG.idGama) DESC;

---------------------------------------
-- Bloque 2: Desafíos de Mayor Nivel --
---------------------------------------
-- ACT1: Análisis de Clientes VIP
SELECT
    C.nombre
FROM
    clientes C
    JOIN pagos P ON C.id = P.idCliente
GROUP BY
    C.id
HAVING
    SUM(P.cantidad) > (
        SELECT
            AVG(totalCliente)
        FROM
            (
                SELECT
                    SUM(cantidad) AS totalCliente
                FROM
                    pagos
                GROUP BY
                    idCliente
            ) AS gastosClientes
    );

-- ACT2: Gamas en peligro
SELECT
    G.nombre
FROM
    gamas G
    JOIN productos P ON P.idGama = G.id
GROUP BY
    G.id
HAVING
    MAX(P.stock) < (
        SELECT
            AVG(stock)
        FROM
            productos
    );

-- ACT3: Saturación por oficina
SELECT
    O.ciudad,
    COUNT(DISTINCT C.id) / COUNT(DISTINCT E.id) AS clientesPorEmpleado
FROM
    oficinas O
    JOIN empleados E ON E.idOficina = O.id
    LEFT JOIN clientes C ON C.idEmpleado = E.id
GROUP BY
    O.ciudad;

-- ACT4: Productos Estrella Estacionales
SELECT
    P.nombre
FROM
    productos P
    JOIN detallesPedidos DP ON P.id = DP.idProducto
    JOIN pedidos PE ON DP.idPedido = PE.id
WHERE
    YEAR (PE.fecha) = 2025
GROUP BY
    P.id
HAVING
    COUNT(DISTINCT MONTH (PE.fecha)) = (
        SELECT
            COUNT(DISTINCT MONTH (fecha))
        FROM
            pedidos
        WHERE
            YEAR (fecha) = 2025
    );

-- ACT5: Especialistas Infrautilizados
SELECT
    E.nombre
FROM
    empleadosGamas as EG
    INNER JOIN empleados as E on EG.idEmpleado = E.id
    INNER JOIN gamas as G on EG.idGama = G.id
WHERE
    EG.nivel = 'Experto'
    AND NOT EXISTS (
        SELECT
            *
        FROM
            detallesPedidos AS DP
            INNER JOIN pedidos AS PE ON DP.idPedido = PE.id
            INNER JOIN productos AS PR ON DP.idProducto = PR.id
            INNER JOIN clientes AS C ON PE.idCliente = C.id
        WHERE
            C.idEmpleado = E.id
            AND G.id = PR.idGama
    );

-- ACT6: Cesta de la Compra Proporcional
SELECT
    DP.idPedido,
    DP.idProducto,
    ROUND(
        (DP.precioUnidad *) / (
            SELECT
                sum(DP1.precioUnidad)
            FROM
                detallesPedidos AS DP1
            WHERE
                DP1.idPedido = DP.idPedido
        ) * 100,
        2
    ) AS sum
FROM
    detallesPedidos AS DP;

-- ACT7: Tnaking de ventas por Ciudad
SELECT
    C.ciudad,
    (
        SELECT
            sum(P.cantidad)
        FROM
            pagos AS P
        WHERE
            idCliente = C.id
    ) AS suma
FROM
    clientes AS C
HAVING
    suma > 200
ORDER BY
    suma DESC;

-- ACT8: Detección de Gamas Huérfanas
SELECT
    G.nombre
FROM
    empleadosGamas as EG
    INNER JOIN empleados as E on EG.idEmpleado = E.id
    INNER JOIN gamas as G on EG.idGama = G.id
WHERE
    NOT EXISTS (
        SELECT
            *
        FROM
            empleadosGamas as EG1
        WHERE
            EG1.nivel = 'Experto'
    );

-- ACT9: Comparativa Interanual
SELECT
    *
FROM
    clientes as C
WHERE
    EXISTS (
        SELECT
            *
        FROM
            pedidos as P
        WHERE
            C.id = P.idCliente
            and YEAR (fecha) = "2025"
        HAVING
            count(*) > (
                SELECT
                    count(*)
                FROM
                    pedidos
                GROUP BY
                    id
                WHERE
                    YEAR (fecha) = "2026"
            )
    );

-- ACT10: Pedidos de Máxima Variedad
SELECT
    DP.idPedido
FROM
    detallesPedidos DP
    JOIN productos P ON DP.idProducto = P.id
GROUP BY
    DP.idPedido
HAVING
    COUNT(DISTINCT P.idGama) = (
        SELECT
            MAX(numGamas)
        FROM
            (
                SELECT
                    COUNT(DISTINCT P2.idGama) AS numGamas
                FROM
                    detallesPedidos DP2
                    JOIN productos P2 ON DP2.idProducto = P2.id
                GROUP BY
                    DP2.idPedido
            ) AS t
    );

-- ACT11: 

-- ACT24: Fidelidad Geográfica
SELECT
    C.pais,
    PR.nombre,
    (
        SELECT
            MAX(sum.suma)
        FROM
            (
                SELECT
                    SUM(DP1.cantidad) as suma
                FROM
                    productos as PR1
                    INNER JOIN detallesPedidos as DP1 on PR1.id = DP1.idProducto
                    INNER JOIN pedidos as PE1 on PE1.id = DP1.idPedido
                    INNER JOIN clientes as C1 on C1.id = PE1.idCliente
                GROUP BY
                    C1.pais
            ) as sum
    )
FROM
    productos as PR
    INNER JOIN detallesPedidos as DP on PR.id = DP.idProducto
    INNER JOIN pedidos as PE on PE.id = DP.idPedido
    INNER JOIN clientes as C on C.id = PE.idCliente
GROUP BY
    C.pais;

-- ACT