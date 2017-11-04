# purpose: get comfortable with creating view and joining tables to manupulate data 
# Trang Vu
# November 4th, 2017
# Indicate that we are using the deals database
USE deals;
# Execute a test query
SELECT * 
FROM Companies
WHERE CompanyName like "%Inc.";
#select companies sorted by CompanyName
select *
from Companies
Order by CompanyID;
#Select Deal Parts with dollar values
select DealName, PartNumber, DollarValue
FROM Deals, DealParts
WHERE Deals.DealID = DealParts.DealID;
#Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID=DealParts.DealID);
#show each company involved in each deal
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players On (Companies.CompanyID = Players.CompanyID)
    JOIN Deals On (Players.DealID = Deals.DealID)
ORDER BY DealName;
#create a view that matches companies to deals
DROP VIEW IF EXISTS CompanyDeals;
CREATE View CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
    JOIN Deals ON (Players.DealID = Deals.DealID)
Order by DealName;
# A test of the CompanyDeals view
Select * FROM CompanyDeals;
#Create a view named DealValues that lists the DealID, total dollar value and number of parts for each deal.
DROP VIEW IF EXISTS DealValues;
CREATE VIEW DealValues AS
Select Deals.DealID, Sum(DollarValue) AS TotDollarValue, Count(PartNUmber) AS NumParts
FROM Deals JOIN DealParts On (Deals.DealID = DealParts.DealID)
Group By Deals.DealID
Order By Deals.DealID;

SELECT * from DealValues;

#Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and number of parts for each deal.
CREATE VIEW  DealSummary AS
SELECT Deals.DealID,DealName, count(PlayerID) AS NumPlayers, TotDollarValue, NumParts
FROM DEALS JOIN DealValues ON (DEALS.DealID = DealValues.DealID)
							JOIN Players ON (DEALS.DealID = Players.DealID)
GROUP BY Deals.DealID;

#  11. Create a view called DealsByType that lists TypeCode, number of deals, and total value of deals for each deal type.
DROP VIEW IF EXISTS DealsByType;
CREATE VIEW DealsByType AS
SELECT DISTINCT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes JOIN  Deals ON (DealTypes.DealID = Deals.DealID) 
							 JOIN DealParts On (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode;
# 12. Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.alter
DROP VIEW IF EXISTS DealPlayers;
CREATE VIEW DealPlayers AS 
SELECT DealID, CompanyID, CompanyName, RoleCode 
FROM Players JOIN Deals USING (DealID) JOIN COMPANIES USING (CompanyID)
						JOIN RoleCodes USING (RoleCode)
ORDER BY RoleSortOrder;

# 13. Create a view called DealsByFirm that lists the FirmID, Name, number of deals, and total value of deals for each firm.
DROP VIEW IF EXISTS DealsByFirm;
CREATE VIEW DealsByFirm AS 
SELECT FirmID, Firms.Name, COUNT(Players.DealID) AS NumDeals, SUM(TotDollarValue) AS TotValue
FROM Firms LEFT JOIN PlayerSupports USING (FirmID)
					 LEFT JOIN Players USING (PlayerID) 
                     LEFT  JOIN DealValues USING (DealID)
GROUP BY FirmID, Firms.Name;
