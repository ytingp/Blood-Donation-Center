CREATE TABLE tblDiscount (
   DiscountID INTEGER IDENTITY(1, 1) primary key,
   DiscountName varchar(60) NOT NULL,
   DiscountTypeID int NOT NULL,
   DiscountAmount decimal(3,2) NOT NULL,
   DiscountStartDate date NOT NULL,
   DiscountEndDate date NOT NULL,
)

ALTER TABLE tblDiscount
ADD CONSTRAINT FK_Discount_DiscountTypeID
FOREIGN KEY (DiscountTypeID)
REFERENCES tblDiscountType

CREATE TABLE tblOrders (
   OrderID INTEGER IDENTITY(1, 1) primary key,
   CustomerID int NOT NULL,
   EmployeeID int NOT NULL,
   TransactionDate date NOT NULL,
   TransactionAmount decimal(6,2) NOT NULL,
   DiscountID int NOT NULL,
   PaymentTypeID int NOT NULL,   
)

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Orders_DiscountID
FOREIGN KEY (DiscountID)
REFERENCES tblDiscount

ALTER TABLE tblOrders
ADD CONSTRAINT FK_Orders_PaymentTypeID
FOREIGN KEY (PaymentTypeID)
REFERENCES tblPaymentType

CREATE TABLE tblCar (
   CarID INTEGER IDENTITY(1, 1) primary key,
   CarModelID int NOT NULL,
   OrderID int NOT NULL,
   CarYear varchar(4) NOT NULL,
   CarColor VARCHAR(60) NOT NULL,
    VIN VARCHAR(60) NOT NULL
)

ALTER TABLE tblCar
ADD CONSTRAINT FK_Car_OrderID
FOREIGN KEY (OrderID)
REFERENCES tblOrders
 
CREATE TABLE tblModel (
   CarModelID INTEGER IDENTITY(1, 1) primary key,
   CarMakeID int NOT NULL,
   CarMfgID int NOT NULL,
   CarModelName varchar(60) NOT NULL,
   ModelDescr varchar(200) NOT NULL,
)


ALTER TABLE tblModel
ADD CONSTRAINT FK_Car_CarMfgID
FOREIGN KEY (CarMfgID)
REFERENCES tblCarManufacturer

CREATE TABLE tblFeatures (
   FeatureID INTEGER IDENTITY(1, 1) primary key,
   FeatureTypeID int NOT NULL,
   FeatureName varchar(60) NOT NULL,
   FeatureDescr varchar(200) NULL,
)


ALTER TABLE tblFeatures
ADD CONSTRAINT FK_Features_FeatureTypeID
FOREIGN KEY (FeatureTypeID)
REFERENCES tblFeatureType
 
CREATE TABLE tblCarFeatures (
   CarFeaturesID INTEGER IDENTITY(1, 1) primary key,
   CarID int NOT NULL,
   FeatureID int NOT NULL,
)
 
ALTER TABLE tblCarFeatures
ADD CONSTRAINT FK_CarFeature_FeatureID
FOREIGN KEY (FeatureID)
REFERENCES tblFeatures

CREATE TABLE tblCarDetail (
   CarDetailID INTEGER IDENTITY(1, 1) primary key,
   CarID int NOT NULL,
   DetailID int NOT NULL,
   CarDetailValue decimal(6,2) NOT NULL,
   CarDetailDate date NOT NULL
)

ALTER TABLE tblCarDetail
ADD CONSTRAINT FK_CarDetail_DetailID
FOREIGN KEY (DetailID)
REFERENCES tblCarDetail

INSERT INTO tblDiscountType (DiscountName, DiscountDescr)
VALUES ('Overstock', 'Offered when there is a surplus stock of a product'), 
('Seasonal', 'Offered during slow sale periods for a product'), 
('Subscription', 'Offered to customers with email or mailing subscriptions'),
('Rebates', 'refund of money after a transaction')

INSERT INTO tblPaymentType (PaymentTypeName, PaymentTypeDescr)
VALUES ('Debit Card', 'Using a debit card as the payment method'),
('Credit Card', 'Using a credit card as the payment method'),
('Cash', 'Using cash as the payment method'),
('Check', 'Using a check as the payment method')

INSERT INTO tblFeatureType (FeatureTypeName, FeatureTypeDescr)
VALUES ('Sound', 'Any adjustments to a standard car audio system'),
('Smart', 'Features that handle procedures for the driver'),
('Charging', 'Varying options for charging devices in the car'),
('Safety', 'Any additional features to increase safety protocols'),
('Entertainment', 'Features to entertain passengers'),
('Temperature', 'Features that change temperature across the vehicle')

INSERT INTO tblCustomers (CustomerFName, CustomerLName, PhoneNumber, CustomerAddress, CustomerCity, CustomerState, CustomerZipCode, CustomerBirth, CustomerEmail)
VALUES 
('Kaile', 'Isakson', '40788015', '8394 Columbus Park', 'Orlando', 'Florida', '32789', '2000-03-02', 'kisakson1@intel.com'),
('Thorin', 'Colcomb', '71365097', '9 Longview Alley', 'Houston', 'Texas', '77001', '1990-05-14', 'tcolcomb2@wiley.com'),
('Rafa', 'Pavitt', '31492794', '0764 Mandrake Lane', 'Saint Louis', 'Missouri', '63101', '1977-11-20', 'rpavitt3@nhs.uk'),
('Lombard', 'Hanshaw', '60847928', '1158 Carioca Lane', 'Madison', 'Wisconsin', '53558', '1999-01-01', 'lhanshaw4@yahoo.com'),
('Blaire', 'Ledgeway', '8193850', '9 Northland Park', 'Tampa', 'Florida', '33601', '1999-07-27', 'bledgeway5@irs.gov'),
('Stephenie', 'Hughs', '20916327', '074 Linden Trail', 'Birmingham', 'Alabama', '35005', '2003-08-19', 'shughs6@ucla.edu'),
('Reid', 'Hedgeley', '41416280', '9 Northport Circle', 'Milwaukee', 'Wisconsin', '53201', '2000-11-01', 'rhedgeley7@nba.com'),
('Winny', 'Croser', '51828760', '44 Loeprich Point', 'Albany', 'New York', '12084', '1998-03-02', 'wcroser8@moonfruit.com'),
('Lothario', 'Haith', '20502221', '81606 Alpine Junction', 'Birmingham', 'Alabama', '35005', '2001-09-08', 'lhaith9@sciencedirect.com')

GO

SELECT *
FROM tblBranch

SELECT * 
FROM tblEmployeePosition

ALTER TABLE tblModel ALTER COLUMN ModelDescr int NULL


