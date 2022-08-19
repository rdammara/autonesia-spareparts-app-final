CREATE DATABASE db_AutonesiaDefault

USE db_AutonesiaDefault

--CHAR can be used for Primary Keys and IDs since those are string characters, and therefore can be used (except for Item Code)--

CREATE TABLE Invoice
(
	InvoiceNo			CHAR(5)		NOT NULL PRIMARY KEY,
	InvoiceDate			DATE		NOT NULL,
	CustCode			CHAR(5)		NOT NULL,
	ItemCode			VARCHAR(50)	NOT NULL,
	Qty					INT			NOT NULL
)

CREATE TABLE SalesOrder 
(
	SalesOrderNo		CHAR(5)		NOT NULL PRIMARY KEY,
	SalesOrderDate		DATE		NOT NULL,
	SalesmanCode		CHAR(5)		NOT NULL,
	InvoiceNo			CHAR(5)		NOT NULL,
	PickingListNumber	CHAR(5)		NOT NULL
)
--Based on the Excel table, the Item Code uses variations of characters of more than 5, therefore VARCHAR(50) is appropriate for this case--
CREATE TABLE Item
(
	ItemCode		VARCHAR(50)		NOT NULL PRIMARY KEY,
	ItemName		VARCHAR(50)		NOT NULL,
	ItemClass		VARCHAR(50)		NOT NULL,
	UnitPrice		DECIMAL			NOT NULL,
	UOM				VARCHAR(50)		NOT NULL
)

CREATE TABLE Stock
(
	MainLocation	CHAR(5)			NOT NULL PRIMARY KEY,
	WarehouseGroup	VARCHAR(50)		NOT NULL,
	ItemCode		VARCHAR(50)		NOT NULL,
	Available		VARCHAR(50)		NOT NULL,
)

CREATE TABLE Supplier
(
	SupplierCode	CHAR(5)			NOT NULL PRIMARY KEY,
	SupplierName	VARCHAR(25)		NOT NULL,
	SupplierAddress VARCHAR(50)		NOT NULL,
	SupplierPhone	INT				NOT NULL,
	Email			VARCHAR(50)		NOT NULL
)

CREATE TABLE Customer
(
	CustCode		CHAR(5)			NOT NULL PRIMARY KEY,
	CustName		VARCHAR(50)		NOT NULL,
	CustPhone		BIGINT			NOT NULL,
	CustAddress		TEXT			NOT NULL
)

CREATE TABLE Salesman
(
	SalesmanCode	CHAR(5)			NOT NULL PRIMARY KEY,
	SalesmanName	VARCHAR(50)		NOT NULL,
	SalesmanPhone	BIGINT			NOT NULL,
	SalesmanAddress	VARCHAR(50)		NOT NULL,
	SalesmanUsername VARCHAR(20)	NOT NULL,
	SalesmanPassword VARCHAR(20)	NOT NULL
)

CREATE TABLE PurchaseOrder
(
	PO_No				CHAR(5)		NOT NULL PRIMARY KEY,
	OrderType			VARCHAR(25)	NOT NULL,
	ItemCode			VARCHAR(50)	NOT NULL,
	FOREIGN KEY			(ItemCode)  REFERENCES Item ON DELETE CASCADE,
	Ordered				INT			NOT NULL,
	Received			INT			NOT NULL
)

CREATE TABLE GoodsReceived
(
	GoodsReceivedNo		CHAR(5) NOT NULL PRIMARY KEY,
	GRDate				DATE	NOT NULL,
	SupplierCode		CHAR(5) NOT NULL,
	FOREIGN KEY			(SupplierCode) REFERENCES Supplier ON DELETE CASCADE,
	DeliveryOrderNo		CHAR(5) NOT NULL,
	PO_No				CHAR(5) NOT NULL,
	FOREIGN KEY			(PO_No) REFERENCES PurchaseOrder ON DELETE CASCADE
)


--DATA INVOICE
INSERT INTO Invoice VALUES ('IN001','01/07/2021','CS001','21710-ED000',1)
INSERT INTO Invoice VALUES ('IN002','01/07/2021','CS001','54560-EE500',2)
INSERT INTO Invoice VALUES ('IN003','01/15/2021','CS002','27276-CL333',2)
INSERT INTO Invoice VALUES ('IN004','01/17/2021','CS003','45790-EH910',5)
INSERT INTO Invoice VALUES ('IN005','01/20/2021','CS004','11360-ED000',1)

--DATA SALES ORDER
INSERT INTO SalesOrder VALUES ('SO001','01/07/2021','SS001','IN001','PL001')
INSERT INTO SalesOrder VALUES ('SO002','01/07/2021','SS001','IN002','PL002')
INSERT INTO SalesOrder VALUES ('SO003','01/12/2021','SS002','IN003','PL003')
INSERT INTO SalesOrder VALUES ('SO004','01/13/2021','SS003','IN004','PL004')
INSERT INTO SalesOrder VALUES ('SO005','01/20/2021','SS004','IN005','PL005')

--DATA ITEM
INSERT INTO Item VALUES ('21710-ED000','"1D" TANK ASSY RESERVE','SP',125500,'Piece')
INSERT INTO Item VALUES ('97133-GK000','FILTER ASSY-AIR','SP',265987,'Piece')
INSERT INTO Item VALUES ('98390-CT000','AP-W/WPR ARM','SP',16962,'Piece')
INSERT INTO Item VALUES ('59241-JA004','REPAIR KIT DUST BOOT','SP',530500,'Piece')
INSERT INTO Item VALUES ('54560-EE500','"1D" BUSH TRANSV LINK','SP',206500,'Piece')
INSERT INTO Item VALUES ('27276-CL333','COVER FILTER AC','SP',47500,'Piece')
INSERT INTO Item VALUES ('45790-EH910','REMOTE ALARM','SP',89500,'Piece')
INSERT INTO Item VALUES ('11360-ED000','"1D" BUFFER ASSY-RR','SP',662500,'Piece')
INSERT INTO Item VALUES ('76546-BC567','FILTER AIR ELEMENT','SP',55000,'Piece')
INSERT INTO Item VALUES ('34110-TB003','ENGINE CONDITIONER','SP',95000,'Piece')

--DATA STOCK
INSERT INTO Stock VALUES ('LC001','KP-WH-SPAREPART','97133-GK000',1)
INSERT INTO Stock VALUES ('LC002','KP-WH-SPAREPART','98390-CT000',2)
INSERT INTO Stock VALUES ('LC003','KP-WH-SPAREPART','59241-JA004',3)
INSERT INTO Stock VALUES ('LC004','KP-WH-SPAREPART','76546-BC567',9)
INSERT INTO Stock VALUES ('LC005','KP-WH-SPAREPART','34110-TB003',9)

--DATA SUPPLIER
INSERT INTO Supplier VALUES ('SP001','Toyota','Jl. Raya Puputan Niti Mandala No. 18, Denpasar',1500315,'customer-care@toyota.astra.co.id')
INSERT INTO Supplier VALUES ('SP002','Nissan','Jl. W.J. Lalamentik No. 102, Kupang',1500023,'nissancare@nmdi.indomobil.co.id')
INSERT INTO Supplier VALUES ('SP003','BMW','Jl. S. Parman Padang Jati No. 57,Bengkulu',1500269,'bmw@dealer.car.co.id')
INSERT INTO Supplier VALUES ('SP004','Mercedes','Jl. Jend Sudirman Kav. 10-11, Jakarta',1500050,'mercedes@luxury.co.id')
INSERT INTO Supplier VALUES ('SP005','Daihatsu','Jl. Imam Bonjol No. 80, Jakarta',15008988,'daihatsu@astra.car.co.id')
INSERT INTO Supplier VALUES ('SP006','Mazda','Jl. Suryopranoto No. 8, Jakarta Pusat',1500985,'customer.info@mazda.co.id.')

--DATA CUSTOMER
INSERT INTO Customer VALUES ('CS001','MULIA TARMIZI',89598776134,'Jl. Pemuda No. 21, Padang')
INSERT INTO Customer VALUES ('CS002','ARWANA',89544671129,'Jl. Gubernur H. Ahmad Bastari No. 7, Palembang')
INSERT INTO Customer VALUES ('CS003','ANGGRIAWAN',82136651611,'Jl. Lambung Mangkurat No. 7, Banjarmasin')
INSERT INTO Customer VALUES ('CS004','FERDIAWAN',83188806551,'Jl. RTA Milono No. 12, Palangka Raya')

--DATA SALESMAN
INSERT INTO Salesman VALUES ('SS001','FELISYA',82149184321,'Jl. Jend. Sudirman Kav. 44-46, Jakarta','felisya21',45659333)
INSERT INTO Salesman VALUES ('SS002','ANDREAS',89567013345,'Jl. Gatot Subroto Kav. 36-38, Jakarta','andreas03',80304002)
INSERT INTO Salesman VALUES ('SS003','STEVEN',89535357401,'Jl. Jend. Sudirman Kav. 1, Jakarta','steven88',50348871)
INSERT INTO Salesman VALUES ('SS004','ALBERT',82276693332,'Jl. Jend. Sudirman Kav. 29-3, Jakarta','albert69',44657291)
INSERT INTO Salesman VALUES ('SS005','ALEJANDRO',89567708855,'Jl. KH. Wahid Hasyim No. 234, Jakarta','alejandro13',92914621)
INSERT INTO Salesman VALUES ('SS006','FIKRI',83122330067,'Jl. MH. Thamrin Kav. 51, Jakarta','fikri40',70018201)

--DATA PURCHASE ORDER
INSERT INTO PurchaseOrder VALUES ('PO001','Special','21710-ED000',1,1)
INSERT INTO PurchaseOrder VALUES ('PO002','Regular','97133-GK000',2,2)
INSERT INTO PurchaseOrder VALUES ('PO003','Regular','98390-CT000',1,1)
INSERT INTO PurchaseOrder VALUES ('PO004','Regular','59241-JA004',1,1)
INSERT INTO PurchaseOrder VALUES ('PO005','Regular','54560-EE500',2,2)
INSERT INTO PurchaseOrder VALUES ('PO006','Regular','27276-CL333',1,1)
INSERT INTO PurchaseOrder VALUES ('PO007','Special','45790-EH910',10,10)
INSERT INTO PurchaseOrder VALUES ('PO008','Regular','11360-ED000',1,1)
INSERT INTO PurchaseOrder VALUES ('PO009','Regular','76546-BC567',1,1)
INSERT INTO PurchaseOrder VALUES ('PO010','Regular','34110-TB003',1,1)

--DATA GOODS RECEIVE
INSERT INTO GoodsReceived VALUES ('GR001','01/05/2021','SP001','DN001','PO001')
INSERT INTO GoodsReceived VALUES ('GR002','01/07/2021','SP002','DN002','PO002')
INSERT INTO GoodsReceived VALUES ('GR003','01/07/2021','SP002','DN003','PO003')
INSERT INTO GoodsReceived VALUES ('GR004','01/10/2021','SP003','DN004','PO004')
INSERT INTO GoodsReceived VALUES ('GR005','01/11/2021','SP004','DN005','PO005')
INSERT INTO GoodsReceived VALUES ('GR006','01/13/2021','SP005','DN006','PO006')
INSERT INTO GoodsReceived VALUES ('GR007','01/13/2021','SP005','DN007','PO007')
INSERT INTO GoodsReceived VALUES ('GR008','01/15/2021','SP006','DN008','PO008')
INSERT INTO GoodsReceived VALUES ('GR009','01/15/2021','SP006','DN009','PO009')
INSERT INTO GoodsReceived VALUES ('GR010','01/15/2021','SP006','DN010','PO010')

SELECT*FROM GoodsReceived
SELECT*FROM PurchaseOrder
SELECT*FROM Invoice
SELECT*FROM SalesOrder
SELECT*FROM Item
SELECT*FROM Stock
SELECT*FROM Supplier
SELECT*FROM Customer
SELECT*FROM Salesman

DROP TABLE GoodsReceived
DROP TABLE PurchaseOrder
DROP TABLE Invoice
DROP TABLE SalesOrder
DROP TABLE Item
DROP TABLE Stock
DROP TABLE Supplier
DROP TABLE Customer
DROP TABLE Salesman