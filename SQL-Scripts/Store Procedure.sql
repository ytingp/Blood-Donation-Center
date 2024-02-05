-- Insert a new employee into an existing position 
CREATE PROCEDURE ting_INSERT_NEW_Employee_Position
@F varchar(20),
@L varchar(30),
@Phone varchar(20),
@Addy varchar(100),
@City varchar(20),
@Zip varchar(20),
@BOD Date,
@Email varchar(50),
@BranchPhone varchar(20),
@PositionName varchar(20),
@BeginDate DATE

AS 

DECLARE @B_ID INT, @E_ID INT, @P_ID INT

BEGIN TRANSACTION
INSERT INTO tblEmployees(EmployeeFname, EmployeeLname, PhoneNumber, Address, City, State, ZipCode, Birthdate,  Email)
VALUES(@F, @L, @Phone, @Addy, @City, @State, @Zip, @BOD, @Email)

SET @E_ID = (SELECT scope_identity())
SET @B_ID = (SELECT BranchID
                FROM tblBranch
                WHERE PhoneNumber = @BranchPhone)

SET @P_ID = (SELECT PositionID
                FROM tblPosition
                WHERE PostionName = @PositionName)

INSERT INTO tblEmployeePosition (BranchID, EmployeeID, PositionID, BeginDate)
VALUES(@B_ID, @E_ID, @P_ID, @BeginDate)

COMMIT TRANSACTION
GO


-- Insert a new feature for an existing car
CREATE PROCEDURE ting_INSERT_New_CarFeature
@VIN varchar(100),
@Feature varchar(60)

AS 

DECLARE @F_ID INT, @C_ID INT
SET @F_ID = (SELECT FeatureID
                FROM tblFeatures
                WHERE FeatureName = @Feature)

SET @C_ID = (SELECT CarID 
                FROM tblCar
                WHERE VIN = @VIN)

BEGIN TRANSACTION
UPDATE tblCarFeature
SET Feature_ID = @F_ID
WHERE CarID = @C_ID