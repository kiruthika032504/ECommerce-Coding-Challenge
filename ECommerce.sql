-- Create a Database
CREATE DATABASE ECommerce
-- Use the Database 
USE ECommerce

-- Create the Database Schemas

CREATE TABLE Customers(
customerId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
firstName VARCHAR(30) NOT NULL,
lastName VARCHAR(30) NOT NULL,
Email VARCHAR(50) NOT NULL,
[address] TEXT)

CREATE TABLE Products(
productId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[name] VARCHAR(30) NOT NULL,
price DECIMAL(6,2),
[Description] TEXT,
stockQuantity INT)

CREATE TABLE Cart(
cartId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
customerId INT,
FOREIGN KEY(customerId) REFERENCES Customers(customerId),
productId INT,
FOREIGN KEY(productId) REFERENCES Products(productId),
quantity INT)

CREATE TABLE Orders(
orderId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
customerId INT,
FOREIGN KEY(customerId) REFERENCES Customers(customerId),
orderDate DATE,
totalAmount DECIMAL(6,2))

CREATE TABLE OrderItems(
orderItemId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
orderId INT,
FOREIGN KEY(orderId) REFERENCES Orders(orderId),
productId INT,
FOREIGN KEY(productId) REFERENCES Products(productId),
quantity INT,
itemAmount DECIMAL(6,2))

-- Insert values into the Database Schemas
INSERT INTO Customers(firstName,lastName,Email,[address])
VALUES
('John','Doe','johndoe@example.com','123 Main St, City'),
('Jane','Smith','janesmith@example.com','456 Elm St, Town'),
('Robert','Johnson','robert@example.com','789 Oak St, Village'),
('Sarah','Brown','sarah@example.com','101 Pine St, Suburb'),
('David','Lee','david@example.com','234 Cedar St, District'),
('Laura','Hall','laura@example.com','567 Birch St, Country'),
('Michael','Davis','michael@example.com','890 Maple St, State'),
('Emma','Wilson','emma@example.com','321 Redwoood St, Country'),
('William','Taylor','william@example.com','432 Spruce St, Province'),
('Olivia','Adams','olivia@example.com','765 Fir St, Territory')

INSERT INTO Products([name],[Description],price,stockQuantity)
VALUES
('Laptop', 'High-performance laptop', 800.00, 10),
('Smartphone', 'Latest smartphone', 600.00, 15),
('Tablet', 'Portable tablet', 300.00, 20),
('Headphones', 'Noise-canceling', 150.00, 30),
('TV', '4K Smart TV', 900.00, 5),
('Coffee Maker', 'Automatic coffee maker', 50.00, 25),
('Refrigerator', 'Energy-efficient', 700.00, 10),
('Microwave Oven', 'Countertop microwave', 80.00, 15),
('Blender', 'High-speed blender', 70.00, 20),
('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10)

INSERT INTO Cart (customerID, productid, quantity) 
VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 4),
(3, 5, 2),
(4, 6, 1),
(5, 1, 1),
(6, 10, 2),
(6, 9, 3),
(7, 7, 2)

INSERT INTO Orders(customerID, orderDate, totalAmount) 
VALUES
(1, '2023-01-05', 1200.00),
(2, '2023-02-10', 900.00),
(3, '2023-03-15', 300.00),
(4, '2023-04-20', 150.00),
(5, '2023-05-25', 1800.00),
(6, '2023-06-30', 400.00),
(7, '2023-07-05', 700.00),
(8, '2023-08-10', 160.00),
(9, '2023-09-15', 140.00),
(10, '2023-10-20', 1400.00)

INSERT INTO OrderItems (orderID, productID, quantity, itemAmount) 
VALUES
(1, 1, 2, 1600.00),
(1, 3, 1, 300.00),
(2, 2, 3, 1800.00),
(3, 5, 2, 1800.00),
(4, 4, 4, 600.00),
(4, 6, 1, 50.00),
(5, 1, 1, 800.00),
(5, 2, 2, 1200.00),
(6, 10, 2, 240.00),
(6, 9, 3, 210.00)

-- 1. Update refrigerator product price to 800.

UPDATE Products
SET price = 800.00
WHERE [name] = 'Refrigerator'

-- 2. Remove all cart items for a specific customer.

INSERT INTO Customers(firstName,lastName,Email,[address])
VALUES
('Emily','Wilson','emily@example.com','123 Maple St, County')

INSERT INTO Products([name],[Description],price,stockQuantity)
VALUES
('Chair', 'Comfortable chair', 50.00, 10)

INSERT INTO Cart (customerID, productid, quantity) 
VALUES
(11, 1, 1)

INSERT INTO Orders(customerID, orderDate, totalAmount) 
VALUES
(11, '2023-11-25', 200.00)

INSERT INTO OrderItems (orderID, productID, quantity, itemAmount) 
VALUES
(11, 1, 1, 50.00)


DELETE FROM Cart
WHERE customerId = 11

-- 3. Retrieve Products Priced Below $100.

SELECT * FROM Products
WHERE price < 100.00


-- 4. Find Products with Stock Quantity Greater Than 5.

SELECT * FROM Products
WHERE stockQuantity > 5

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.

SELECT * FROM Orders
WHERE totalAmount BETWEEN 500.00 AND 1000.00

-- 6. Find Products which name end with letter ‘r’.

SELECT * FROM Products
WHERE [name] LIKE '%r'

-- 7. Retrieve Cart Items for Customer 5.

SELECT * FROM Cart
WHERE customerId = 5

-- 8. Find Customers Who Placed Orders in 2023.

SELECT * FROM Customers
WHERE customerId IN (
    SELECT DISTINCT customerId
    FROM Orders
    WHERE YEAR(orderDate) = 2023
)

-- 9. Determine the Minimum Stock Quantity for Each Product Category.

SELECT productId, [name], MIN(stockQuantity) AS minStock
FROM Products
GROUP BY productId, [name]

-- 10. Calculate the Total Amount Spent by Each Customer.

SELECT O.customerId, CONCAT(C.firstName,' ',C.lastName) as [Name], SUM(totalAmount) AS totalSpent
FROM Orders O
JOIN Customers C
ON C.customerId = O.customerId
GROUP BY O.customerId, C.firstName, C.lastName

-- 11. Find the Average Order Amount for Each Customer.

SELECT O.customerId, CONCAT(C.firstName,' ',C.lastName) as [Name], AVG(totalAmount) AS avgOrderAmount
FROM Orders O
JOIN Customers C
ON C.customerId = O.customerId
GROUP BY O.customerId, C.firstName, C.lastName

-- 12. Count the Number of Orders Placed by Each Customer.

SELECT O.customerId, CONCAT(C.firstName,' ',C.lastName) as [Name], COUNT(orderId) AS orderCount
FROM Orders O
JOIN Customers C
ON C.customerId = O.customerId
GROUP BY O.customerId, C.firstName, C.lastName

-- 13. Find the Maximum Order Amount for Each Customer.

SELECT O.customerId, CONCAT(C.firstName,' ',C.lastName) as [Name], MAX(totalAmount) AS maxOrderAmount
FROM Orders O
JOIN Customers C
ON C.customerId = O.customerId
GROUP BY O.customerId, C.firstName, C.lastName

-- 14. Get Customers Who Placed Orders Totaling Over $1000.

SELECT C.customerId, CONCAT(C.firstName,' ',C.lastName) as [Name], C.Email, totalAmount
FROM Orders O
JOIN Customers C
ON C.customerId = O.customerId
GROUP BY C.customerId, C.firstName, C.lastName, C.Email, totalAmount
HAVING SUM(totalAmount) > 1000.00

-- 15. Subquery to Find Products Not in the Cart.

SELECT productId, [name]
FROM Products
WHERE productId NOT IN (
    SELECT productid
    FROM Cart
)

-- 16. Subquery to Find Customers Who Haven't Placed Orders.

SELECT customerId, CONCAT(firstName,' ',lastName) as [Name]
FROM Customers
WHERE customerId NOT IN (
    SELECT customerId
    FROM Orders
)

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product.

SELECT O.productId, [name], (SUM(itemAmount * quantity) / (SELECT SUM(itemAmount) FROM OrderItems)) * 100 AS revenuePercentage
FROM OrderItems O
LEFT JOIN Products P
ON O.productId = P.productId
GROUP BY O.productId, [name]

-- 18. Subquery to Find Products with Low Stock.

SELECT productId, [name], stockQuantity
FROM Products
WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM Products)

-- 19. Subquery to Find Customers Who Placed High-Value Orders.

SELECT C.customerId, CONCAT(firstName,' ',lastName) as [Name], totalAmount
FROM Customers C
JOIN Orders O
ON C.customerId = O.customerId
GROUP BY C.customerId, firstName, lastName, totalAmount
HAVING SUM(totalAmount) > (SELECT AVG(totalAmount) FROM Orders)

