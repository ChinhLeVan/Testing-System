USE `adventureworks`;

-- ========================QUESTION 1==============================
WITH
name_saddles AS(SELECT ProductSubcategoryID
				FROM productsubcategory
                WHERE `Name` = "Saddles")
SELECT `Name` 
FROM product
WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID
								FROM name_saddles);

-- ========================QUESTION 2==============================
WITH
name_saddles AS(SELECT ProductSubcategoryID
				FROM productsubcategory
                WHERE `Name` LIKE "Bo%")
SELECT `Name` 
FROM product
WHERE ProductSubcategoryID IN (SELECT ProductSubcategoryID
								FROM name_saddles);

-- ========================QUESTION 3==============================
WITH
list_price AS (SELECT MIN(ListPrice) min_list_price
				FROM product
                WHERE ProductSubcategoryID = 3)
SELECT `Name`
FROM product
WHERE ListPrice = (SELECT min_list_price
					FROM list_price);

-- ========================= Exercise 2 JOIN nhiều bảng ===============================
-- ================================ Question 1 =====================================
SELECT c.`Name` AS Country, s.`Name` AS Province -- COUNT(s.`Name`)
FROM countryregion c
JOIN stateprovince s ON c.CountryRegionCode = s.CountryRegionCode;

-- ================================ Question 2 =====================================
SELECT c.`Name` AS Country, s.`Name` AS Province -- , COUNT(s.`Name`)
FROM countryregion c
JOIN stateprovince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.`Name` = "Canada" OR c.`Name` = "Germany"
ORDER BY Country ASC;

-- ================================ Question 3 =====================================
SELECT soh.SalesOrderID, soh.OrderDate, soh.SalesPersonID, sp.Bonus, sp.SalesYTD -- , COUNT(soh.OnlineOrderFlag)
FROM salesorderheader soh
JOIN salesperson sp ON soh.SalesPersonID = sp.SalesPersonID
WHERE soh.OnlineOrderFlag = 0 AND soh.SalesPersonID IS NOT NULL;


-- ================================ Question 4 =====================================
CREATE OR REPLACE VIEW table_info_orders AS(
SELECT soh.SalesOrderID, soh.OrderDate, soh.SalesPersonID, sp.Bonus, sp.SalesYTD -- , COUNT(soh.OnlineOrderFlag)
FROM salesorderheader soh
JOIN salesperson sp ON soh.SalesPersonID = sp.SalesPersonID
WHERE soh.OnlineOrderFlag = 0 AND soh.SalesPersonID IS NOT NULL);

SELECT tio.SalesOrderID, tio.OrderDate, e.Title AS Jobtitle, tio.Bonus, tio.SalesYTD -- , COUNT(tio.SalesYTD)
FROM table_info_orders tio
JOIN employee e ON tio.SalesPersonID = e.EmployeeID;

