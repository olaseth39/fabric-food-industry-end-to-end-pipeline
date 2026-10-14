-- 1. Customer_RAW (PK: CustomerID)
DROP TABLE IF EXISTS edw.CustomerRaw;
CREATE TABLE edw.CustomerRaw AS SELECT * FROM LH_Silver.customer_db.customer_raw;

-- 2. dBusinessUnit (PK: BusinessKey)
DROP TABLE IF EXISTS edw.DimBusinessUnit;
CREATE TABLE edw.DimBusinessUnit AS SELECT * FROM LH_Silver.customer_db.dbusinessunit;

-- 3. dSupplier (PK: SupplierCode)
DROP TABLE IF EXISTS edw.DimSupplier;
CREATE TABLE edw.DimSupplier AS SELECT * FROM LH_Silver.customer_db.dsupplier;

-- 4. fCustomerActivity (PK: CustomerKey)
DROP TABLE IF EXISTS edw.FactCustomerActivity;
CREATE TABLE edw.FactCustomerActivity AS SELECT * FROM LH_Silver.customer_db.fcustomeractivity;

-- 5. fEcommerceOrder (PK: OrderID)
DROP TABLE IF EXISTS edw.FactEcommerceOrder;
CREATE TABLE edw.FactEcommerceOrder AS SELECT * FROM LH_Silver.customer_db.fecommerceorder;

-- 6. fQSROrder (PK: OrderId)
DROP TABLE IF EXISTS edw.FactQSROrder;
CREATE TABLE edw.FactQSROrder AS SELECT * FROM LH_Silver.customer_db.fqsrorder;


-- Incremental Load for Customer_db tables

INSERT INTO edw.CustomerRaw
SELECT s.* FROM LH_Silver.customer_db.customer_raw s
WHERE NOT EXISTS (SELECT 1 FROM edw.CustomerRaw t WHERE t.CustomerID = s.CustomerID);

INSERT INTO edw.DimBusinessUnit
SELECT s.* FROM LH_Silver.customer_db.dbusinessunit s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimBusinessUnit t WHERE t.BusinessUnitKey = s.BusinessUnitKey);

INSERT INTO edw.DimSupplier
SELECT s.* FROM LH_Silver.customer_db.dsupplier s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimSupplier t WHERE t.SupplierCode = s.SupplierCode);

INSERT INTO edw.FactCustomerActivity
SELECT s.* FROM LH_Silver.customer_db.fcustomeractivity s
WHERE NOT EXISTS (SELECT 1 FROM edw.FactCustomerActivity t WHERE t.CustomerKey = s.CustomerKey);

INSERT INTO edw.FactEcommerceOrder
SELECT s.* FROM LH_Silver.customer_db.fecommerceorder s
WHERE NOT EXISTS (SELECT 1 FROM edw.FactEcommerceOrder t WHERE t.OrderID = s.OrderID);

INSERT INTO edw.FactQSROrder
SELECT s.* FROM LH_Silver.customer_db.fqsrorder s
WHERE NOT EXISTS (SELECT 1 FROM edw.FactQSROrder t WHERE t.OrderID = s.OrderID);


--
-- 1. dGeography (PK: GeographyKey)
DROP TABLE IF EXISTS edw.DimGeography;
CREATE TABLE edw.DimGeography AS SELECT * FROM LH_Silver.customer_location.dgeography;

-- 2. dLocation (PK: LocationKey)
DROP TABLE IF EXISTS edw.DimLocation;
CREATE TABLE edw.DimLocation AS SELECT * FROM LH_Silver.customer_location.dlocation;


-- Incremental Load for Customer_Location tables

INSERT INTO edw.DimGeography
SELECT s.* FROM LH_Silver.customer_location.dgeography s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimGeography t WHERE t.GeographyKey = s.GeographyKey);

INSERT INTO edw.DimLocation
SELECT s.* FROM LH_Silver.customer_location.dlocation s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimLocation t WHERE t.LocationKey = s.LocationKey);


-- Production tabble
-- 1. dbrand (PK: BrandKey)
DROP TABLE IF EXISTS edw.DimBrand;
CREATE TABLE edw.DimBrand AS SELECT * FROM LH_Silver.production.dbrand;

-- 2. dchannel (PK: ChannelKey)
DROP TABLE IF EXISTS edw.DimChannel;
CREATE TABLE edw.DimChannel AS SELECT * FROM LH_Silver.production.dchannel;

-- 3. dproduct (PK: ProductKey) - This is your joined table!
DROP TABLE IF EXISTS edw.DimProduct;
CREATE TABLE edw.DimProduct AS SELECT * FROM LH_Silver.production.dproduct;

-- 4. fbakeryproduction (PK: ProductionKey)
DROP TABLE IF EXISTS edw.FactBakeryProduction;
CREATE TABLE edw.FactBakeryProduction AS SELECT * FROM LH_Silver.production.fbakeryproduction;

-- 5. product (PK: ProductCode)
DROP TABLE IF EXISTS edw.Product;
CREATE TABLE edw.Product AS SELECT * FROM LH_Silver.production.product;



-- Incremental Load for Production tables

INSERT INTO edw.DimBrand
SELECT s.* FROM LH_Silver.production.dbrand s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimBrand t WHERE t.BrandKey = s.BrandKey);

INSERT INTO edw.DimChannel
SELECT s.* FROM LH_Silver.production.dchannel s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimChannel t WHERE t.ChannelKey = s.ChannelKey);

INSERT INTO edw.DimProduct
SELECT s.* FROM LH_Silver.production.dproduct s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimProduct t WHERE t.ProductKey = s.ProductKey);

INSERT INTO edw.FactBakeryProduction
SELECT s.* FROM LH_Silver.production.fbakeryproduction s
WHERE NOT EXISTS (SELECT 1 FROM edw.FactBakeryProduction t WHERE t.ProductionKey = s.ProductionKey);

INSERT INTO edw.Product
SELECT s.* FROM LH_Silver.production.product s
WHERE NOT EXISTS (SELECT 1 FROM edw.Product t WHERE t.ProductCode = s.ProductCode);


-- Account Table
-- 1. ddate
DROP TABLE IF EXISTS edw.DimDate;
CREATE TABLE edw.DimDate AS SELECT * FROM LH_Silver.account.ddate;

-- 2. dglaccount
DROP TABLE IF EXISTS edw.DimGLAccount;
CREATE TABLE edw.DimGLAccount AS SELECT * FROM LH_Silver.account.dglaccount;

-- 3. dpaymentmethod
DROP TABLE IF EXISTS edw.DimPaymentMethod;
CREATE TABLE edw.DimPaymentMethod AS SELECT * FROM LH_Silver.account.dpaymentmethod;

-- incremental loading
-- Incremental Load for Account tables

INSERT INTO edw.DimDate
SELECT s.* FROM LH_Silver.account.ddate s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimDate t WHERE t.DateKey = s.DateKey);

INSERT INTO edw.DimGLAccount
SELECT s.* FROM LH_Silver.account.dglaccount s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimGLAccount t WHERE t.GLAccountKey = s.GLAccountKey);

INSERT INTO edw.DimPaymentMethod
SELECT s.* FROM LH_Silver.account.dpaymentmethod s
WHERE NOT EXISTS (SELECT 1 FROM edw.DimPaymentMethod t WHERE t.PaymentMethodKey = s.PaymentMethodKey);

