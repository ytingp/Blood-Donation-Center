--Find the top model sold in the year of 2021 from the Branches in WA
SELECT CarModelName, COUNT(OD.OrderID) AS Total_order
FROM tblBranch B
    JOIN tblEmployeePosition EP ON B.BranchID = EP.BranchID
    JOIN tblEmployees E on EP.EmployeeID = E.EmployeeID
    JOIN tblOrders OD ON E.EmployeeID = OD.EmployeeID
    JOIN tblCar C ON OD.OrderID = C.OrderID
    JOIN tblModel M ON C.CarModelID = M.CarModelID
WHERE B.State = 'WA'
AND YEAR(TransactionDate) = '2021'
GROUP BY CarModelName


--Find which branch location had to most transaction amount in the last 5 years
SELECT Top 1 B.BranchID, SUM(TransactionAmount) AS Total_Transaction
FROM tblBranch B
    JOIN tblEmployeePosition EP ON B.BranchID = EP.BranchID
    JOIN tblEmployees E on EP.EmployeeID = E.EmployeeID
    JOIN tblOrders OD ON E.EmployeeID = OD.EmployeeID
WHERE OD.TransactionDate > DATEADD(year, -5, GETDATE()) 
GROUP BY B.BranchID

GO
SELECT EmployeeID, SUM(TransactionAmount)
FROM tblOrders
WHERE DATEDIFF(year, TransactionDate, GETDATE()) <= 5
GROUP BY EmployeeID

GO

