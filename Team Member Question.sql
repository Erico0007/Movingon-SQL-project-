USE MovinOn_Team10;

/* : Team Member question*/

-- The   total number of units rented by each customer ?

Create view TotalNumber  as
SELECT 
    CONCAT(c.ContactLast, ', ', c.ContactFirst) AS RenterFullName,
    COUNT(r.UnitID) AS TotalUnits
FROM 
 unitrentals r
JOIN 
    customers c ON c.CustID = r.CustID
   
GROUP BY 
    c.ContactLast, c.ContactFirst;
    
    
    select * from TotalNumber;




