--Customers from the state of WA cannot be  younger than 18 years old
CREATE FUNCTION fn_cust_WA_18()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF
EXISTS (SELECT *
        FROM tblCustomers C
            JOIN tblOrders OD ON C.CustomerID = OD.CustomerID
        WHERE C.CustomerState = 'WA'
        AND DATEDIFF(year, C.CustomerBirth, GETDATE()) < 18
SET @RET = 1
RETURN @RET
END

GO

ALTER TABLE tblCustomers
ADD CONSTRAINT fn_cust_age
CHECK(dbo.fn_cust_WA_18() = 0)

GO

--Only Employees older than 18 can use Credit Card as a Payment Type for their order
CREATE FUNCTION fn_emp_18_credit()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF 
EXISTS (SELECT *
        FROM tblEmployees E
            JOIN tblOrders OD ON E.EmployeeID = OD.EmployeeID
            JOIN tblPaymentType PT ON OD.PaymentTypeID = PT.PaymentTypeID
        WHERE DATEDIFF(year, E.Birthdate, GETDATE()) < 18
        AND PT.PaymentTypeName != 'Credit Card')
SET @RET = 1
RETURN @RET
END
GO
ALTER TABLE tblOrders
ADD CONSTRAINT No_18_credit_card
CHECK(dbo.fn_emp_18_credit() = 0)

SELECT(YEAR(GETDATE() - '2018/03/12') / 365.25)