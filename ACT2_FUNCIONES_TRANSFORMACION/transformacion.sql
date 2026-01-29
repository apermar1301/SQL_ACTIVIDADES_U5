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

-- ACT5: Abreviatura de ciudad
SELECT
    nombre,
    ciudad,
    UPPER(LEFT (ciudad, 3)) AS ciudadAbr
FROM
    clientes;

-- ACT6: Logitud del nombre de los productos
SELECT
    nombre,
    LENGTH (nombre) AS nombreLongitud
FROM
    clientes;

-- ACT7: Precio con IVA
SELECT
    nombre,
    round(precio * 1.21, 2) AS 'precio+IVA'
FROM
    productos;

-- ACT8: Precio sin decimales
SELECT
    nombre,
    TRUNCATE (precio, 0) AS precioTruncado
FROM
    productos;

-- ACT9: Resto del stock
SELECT
    nombre,
    MOD(stock, 10) AS 'RESTO: stock/10'
FROM
    productos;

-- ACT10: Mes de los pedidos
SET
    lc_time_names = 'es_ES';

SELECT
    ID,
    monthname (fecha) AS mes
FROM
    pedidos;

-- ACT11: Fecha actual en los pedidos
SELECT
    nombre,
    fecha AS fechaPedido,
    curdate () fechaActual
FROM
    pedidos;

-- ACT12: Año del pedido
SELECT
    ID,
    YEAR (fecha) AS 'añoPedido'
FROM
    pedidos;

-- ACT13: Pedidos realizados en marzo
SET
    lc_time_names = 'es_ES';

SELECT
    ID,
    monthname (fecha) AS mes
FROM
    pedidos
WHERE
    MONTH (fecha) = 3;

-- ACT14: Formato de fecha español
SET
    lc_time_names = 'es_ES';

SELECT
    ID,
    DATE_FORMAT (fecha, '%d/%M/%Y') AS fechaEspan
FROM
    pedidos;


-- ACT15: Dias transcurridos desde el pedido
SELECT
    ID,
    DATEDIFF (curdate (), fecha) AS diasTranscurridos
FROM
    pedidos;

-- ACT16: Fecha de entrega estimada
SELECT
    ID,
    fecha AS fechaPedido,
    DATE_ADD (fecha, INTERVAL 7 DAY) AS fechaEntregaEstimada
FROM
    pedidos;

-- ACT17: Representante de ventas
SELECT
    nombre,
    IFNULL(idEmpleado, 'Sin asignar') as idEmpleadoAsignado
FROM
    clientes;

-- ACT18: Dirección segura
Select 
    nombre,
    CONCAT(IFNULL(ciudad, 'No asignado'), ', ', IFNULL(pais, 'No asignado')) as Direccion
from 
    clientes;
