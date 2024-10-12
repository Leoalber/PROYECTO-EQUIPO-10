CREATE TABLE productos (
 	sku INT,
 	marca VARCHAR(30),
	tipo_producto  VARCHAR(50),
	producto  VARCHAR (100),
	iva  NUMERIC,
	precio  NUMERIC,
	precio_iva NUMERIC
);

/* 5 productos con mayor suma en ventas (sólo finalizadas, orden según total de venta) */

SELECT producto, tipo_producto, marca, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
WHERE status_venta = 'Finalizada'
GROUP BY producto, tipo_producto, marca
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* 5 productos con mayor suma en ventas (sólo por cobrar, orden según total de venta) */

SELECT tipo_producto, producto, marca, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
WHERE status_venta = 'Por Cobrar'
GROUP BY t3.sku, tipo_producto, producto, marca
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* 5 productos con mayor suma en ventas global */

SELECT tipo_producto, producto, marca, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
GROUP BY t3.sku, tipo_producto, producto, marca
ORDER BY SUM(total_venta)
LIMIT 5;

/* Mayores ventas por vendedor según la suma total de venta*/

SELECT nombre, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN vendedores t4 on t1.id_vendedor = t4.id
GROUP BY nombre
ORDER BY SUM(total_venta) DESC;

/* Mayores ventas por vendedor según la suma total de ventas finalizadas*/

SELECT nombre, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN vendedores t4 on t1.id_vendedor = t4.id
WHERE status_venta = 'Finalizada'
GROUP BY nombre
ORDER BY SUM(total_venta) DESC;

/* Mayores ventas por vendedor según la suma total de ventas por cobrar*/

SELECT nombre, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN vendedores t4 on t1.id_vendedor = t4.id
WHERE status_venta = 'Por Cobrar'
GROUP BY nombre
ORDER BY SUM(total_venta) DESC;

/* Mayores ventas por vendedor según la suma total de ventas con aclaración*/

SELECT nombre, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN vendedores t4 on t1.id_vendedor = t4.id
WHERE status_venta = 'Aclaracion'
GROUP BY nombre
ORDER BY SUM(total_venta) DESC;

/* Marcas de las que más productos se venden por total de venta */

SELECT marca, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
GROUP BY marca
ORDER BY SUM(total_venta) DESC;

/* Ventas según el tipo de pago por total de venta*/

SELECT t1.tipo_pago, forma_pago, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN tipos_pago t4 on t1.tipo_pago = t4.tipo_pago
GROUP BY t1.tipo_pago, forma_pago
ORDER BY SUM(total_venta) DESC;

/* Países que más venden (país de origen del producto) con marca por total de venta*/

SELECT pais, t3.marca, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN marcas t4 on t3.marca = t4.marca
GROUP BY pais, t3.marca
ORDER BY SUM(total_venta) DESC;

/* Países que más venden (país de origen del producto) por total de venta*/

SELECT pais, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN marcas t4 on t3.marca = t4.marca
GROUP BY pais
ORDER BY SUM(total_venta) DESC;

/* Productos en los que más gastan los clientes */

SELECT tipo_producto, nom_cliente, estado, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
GROUP BY tipo_producto, nom_cliente, estado
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* Productos más comprados por los clientes */

SELECT tipo_producto, COUNT(DISTINCT nom_cliente) "Numero de clientes", SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
GROUP BY tipo_producto
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* Estados donde más compran */

SELECT estado, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
GROUP BY estado
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* Ventas por tipo */

SELECT tipo_venta, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
GROUP BY tipo_venta
ORDER BY SUM(total_venta) DESC;

/* Estados con mayores ventas según el tipo de pago */

SELECT t1.tipo_pago, forma_pago, tipo_venta, nom_cliente, estado, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
LEFT JOIN tipos_pago t5 on t1.tipo_pago = t5.tipo_pago
WHERE status_venta = 'Finalizada'
GROUP BY t1.tipo_pago, forma_pago, tipo_venta, nom_cliente, estado
ORDER BY SUM(total_venta) DESC
LIMIT 10;

/* Clientes que más compran según el tipo de pago */

SELECT t1.tipo_pago, forma_pago, nom_cliente, estado, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
LEFT JOIN tipos_pago t5 on t1.tipo_pago = t5.tipo_pago
GROUP BY t1.tipo_pago, forma_pago, nom_cliente, estado
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* Clientes que más compran según el tipo de pago */

SELECT tipo_venta, nom_cliente, estado, forma_pago, SUM(cant_productos) "Cantidad de productos", SUM(total_venta) "Suma total ventas"
FROM ventas t1
LEFT JOIN det_ventas t2 on t1.factura = t2.factura
LEFT JOIN productos t3 on t2.sku = t3.sku
LEFT JOIN clientes t4 on t1.no_cliente = t4.no_cliente
LEFT JOIN tipos_pago t5 on t1.tipo_pago = t5.tipo_pago
GROUP BY tipo_venta, nom_cliente, estado, forma_pago
ORDER BY SUM(total_venta) DESC
LIMIT 5;

/* Promedio por factura */

SELECT ROUND(AVG(total_venta),2)
FROM ventas;

/* Salario mensual de los vendedores */

SELECT nombre, t2.categoria, EXTRACT(YEAR FROM fecha_venta) Año, EXTRACT(MONTH FROM fecha_venta) Mes, 
	(SELECT salario FROM cat_vendedores WHERE categoria = t2.categoria) + SUM(total_venta * comision) Salario
FROM ventas t1
LEFT JOIN vendedores t2 on t1.id_vendedor = t2.id
LEFT JOIN cat_vendedores t3 on t2.categoria = t3.categoria
GROUP BY nombre, t2.categoria, EXTRACT(YEAR FROM fecha_venta), EXTRACT(MONTH FROM fecha_venta)
ORDER BY nombre, EXTRACT(YEAR FROM fecha_venta), EXTRACT(MONTH FROM fecha_venta)