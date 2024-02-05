--The total amount of Orders that are above $10,000 for each payment type 
CREATE FUNCTION fn_Total_Orders(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(OD.OrderID)
                    FROM tblOrders OD
                        JOIN tblPaymentType PT ON OD.PaymentTypeID = PT.PaymentTypeID
                    WHERE OD.TransactionAmount >= '10,000'
                    AND PT.PaymentTypeID = @PK)

RETURN @RET
END

GO

ALTER TABLE tblPaymentType
ADD Calc_Total_Orders_above_10000 AS (dbo.fn_Total_Orders(PaymentTypeID))

GO
--The total amount of orders for each discount type from the Branch in WA State
CREATE FUNCTION fn_Total_Discount(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (SELECT COUNT(OD.OrderID)
                    FROM tblDiscount D
                        JOIN tblOrders OD ON D.DiscountID = OD.DiscountID
                        JOIN tblEmployees EM ON OD.EmployeeID = EM.EmployeeID
                        JOIN tblEmployeePosition EMP ON EM.EmployeeID = EMP.EmployeeID
                        JOIN tblBranch B ON EMP.BranchID = B.BranchID
                        JOIN tblDiscountType DT ON D.DiscountTypeID = DT.DiscountTypeID
                    WHERE B.[State] = 'WA'
                    AND D.DiscountTypeID = @PK)

RETURN @RET
END

GO

ALTER TABLE tblDiscountType
ADD calc_Total_Discount_WA AS (dbo.fn_Total_Discount(DiscountTypeID))