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

