--Projeto baseado no v�deo COMO CRIAR SEU PRIMEIRO PROJETO USANDO SQL | Data Marketing

--ESTRUTURA DAS TABELAS
SELECT TOP 10 * FROM [dbo].[olist_customers_dataset]
SELECT TOP 10 * FROM [dbo].[olist_geolocation_dataset]
SELECT TOP 10 * FROM [dbo].[olist_order_items_dataset]
SELECT TOP 10 * FROM [dbo].[olist_order_payments_dataset]
SELECT TOP 10 * FROM [dbo].[olist_orders_dataset]
SELECT TOP 10 * FROM [dbo].[olist_products_dataset]
SELECT TOP 10 * FROM [dbo].[olist_sellers_dataset]
SELECT TOP 10 * FROM [dbo].[product_category_name_translation]

--CRIA��O DE TABELAS DE PRODU��O

--CUSTOMERS | CLIENTES

CREATE TABLE TB_ACT_OLIST_CUSTOMERS
(
CUSTOMER_ID NVARCHAR(150),
CUSTOMER_UNIQUE_ID NVARCHAR(150),
CUSTOMER_ZIP_CODE_PREFIX NVARCHAR(15),
CUSTOMER_CITY NVARCHAR(70),
CUSTOMER_STATE CHAR(2)
)

INSERT INTO TB_ACT_OLIST_CUSTOMERS
SELECT * FROM [dbo].[olist_customers_dataset]

SELECT * FROM TB_ACT_OLIST_CUSTOMERS

--GEOLOCATION | LOCALIDADE

CREATE TABLE TB_ACT_OLIST_GEOLOCATION
(
GEOLOCATION_ZIP_CODE_PREFIX NVARCHAR(50),
GEOLOCATION_LAT FLOAT,
GEOLOCATION_LONG FLOAT,
GEOLOCATION_CITY NVARCHAR(150),
GEOLOCATION_STATE CHAR(2)
)

INSERT INTO TB_ACT_OLIST_GEOLOCATION
SELECT * FROM [dbo].[olist_geolocation_dataset]

SELECT * FROM TB_ACT_OLIST_GEOLOCATION

--ORDER ITEMS | ITENS PEDIDOS

CREATE TABLE TB_ACT_OLIST_ORDER_ITEMS
(
ORDER_ID NVARCHAR(150),
ORDER_ITEM_ID NVARCHAR(10),
PRODUCT_ID NVARCHAR(150),
SELLER_ID NVARCHAR(150),
SHIPPING_LIMIT_DATE DATE,
PRICE FLOAT,
FREIGHT_VALUE FLOAT
)

INSERT INTO TB_ACT_OLIST_ORDER_ITEMS
SELECT * FROM [dbo].[olist_order_items_dataset]

SELECT * FROM TB_ACT_OLIST_ORDER_ITEMS

--ORDER PAYMENTS | PAGAMENTOS DOS PEDIDOS

CREATE TABLE TB_ACT_OLIST_ORDER_PAYMENTS
(
ORDER_ID NVARCHAR(150),
PAYMENT_SEQUENTIAL NVARCHAR(5),
PAYMENT_TYPE NVARCHAR(50),
PAYMENT_INSTALLMENTS INT,
PAYMENT_VALUE FLOAT
)

INSERT INTO TB_ACT_OLIST_ORDER_PAYMENTS
SELECT * FROM [dbo].[olist_order_payments_dataset]

SELECT * FROM TB_ACT_OLIST_ORDER_PAYMENTS

--ORDERS | PEDIDOS

CREATE TABLE TB_ACT_OLIST_ORDERS
(
ORDER_ID NVARCHAR(150),
CUSTOMER_ID NVARCHAR(150),
ORDER_STATUS NVARCHAR (40),
ORDER_PURCHASE_DATE DATE,
ORDER_APPROVED_AT DATE,
ORDER_DELIVERED_CARRIER_DATE DATE,
ORDER_DELIVERED_CUSTOMER_DATE DATE,
ORDER_ESTIMATED_DELIVERY_DATE DATE
)

INSERT INTO TB_ACT_OLIST_ORDERS
SELECT * FROM [dbo].[olist_orders_dataset]

SELECT * FROM TB_ACT_OLIST_ORDERS

--PRODUCTS | PEDIDOS

CREATE TABLE TB_ACT_OLIST_PRODUCTS
(
PRODUCT_ID NVARCHAR(150),
PRODUCT_CATEGORY_NAME NVARCHAR(50),
PRODUCT_NAME_LENGHT INT,
PRODUCT_DESCRIPTION_LENGHT INT,
PRODUCT_PHOTOS_QTY INT,
PRODUCT_WEIGHT_G FLOAT,
PRODUCT_LENGTH_CM FLOAT,
PRODUCT_HEIGHT_CM FLOAT,
PRODUCT_WIDTH_CM FLOAT
)

INSERT INTO TB_ACT_OLIST_PRODUCTS
SELECT * FROM [dbo].[olist_products_dataset]

SELECT * FROM TB_ACT_OLIST_PRODUCTS

--SELLERS | VENDEDORES

CREATE TABLE TB_ACT_OLIST_SELLERS
(
SELLER_ID NVARCHAR(150),
SELLER_ZIP_CODE_PREFIX NVARCHAR(40),
SELLER_CITY NVARCHAR(40),
SELLER_STATE CHAR(2)
)

INSERT INTO TB_ACT_OLIST_SELLERS
SELECT * FROM [dbo].[olist_sellers_dataset]

SELECT * FROM TB_ACT_OLIST_SELLERS

--TRADU��O DOS NOMES DAS CATEGORIAS DOS PRODUTOS | PRODUCT CATEGORY NAME TRANSLATION

CREATE TABLE TB_ACT_OLIST_PRODUCTS_CATEGORY_NAME_TRANSLATION
(
PRODUCT_CATEGORY_NAME NVARCHAR(50),
PRODUCT_CATEGORY_NAME_ENGLISH NVARCHAR(100)
)

INSERT INTO TB_ACT_OLIST_PRODUCTS_CATEGORY_NAME_TRANSLATION
SELECT * FROM [dbo].[product_category_name_translation]

SELECT * FROM TB_ACT_OLIST_PRODUCTS_CATEGORY_NAME_TRANSLATION

--CRIA��O DE VISUALIZA��O DE PEDIDOS ENTREGUES

CREATE VIEW VW_PEDIDOS_POR_CLIENTE
AS

SELECT ORDERS. *, CUSTOMERS.CUSTOMER_CITY, CUSTOMERS.CUSTOMER_STATE
FROM [dbo].[TB_ACT_OLIST_ORDERS] AS ORDERS
INNER JOIN [dbo].[TB_ACT_OLIST_CUSTOMERS] AS CUSTOMERS
ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
WHERE ORDER_STATUS = 'delivered'

SELECT * FROM VW_PEDIDOS_POR_CLIENTE