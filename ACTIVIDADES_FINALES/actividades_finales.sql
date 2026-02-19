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