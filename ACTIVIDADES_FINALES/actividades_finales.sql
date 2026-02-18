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
