CREATE DATABASE Bookstore

CREATE TABLE Authors (
    ID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Birthday DATE
)

GO

CREATE TABLE Publishers (
    ID INT PRIMARY KEY,
    [Name] NVARCHAR(50),
    [Address] NVARCHAR(50),
    [City] NVARCHAR(50),
    [Zip] NVARCHAR(50),
    [Country] NVARCHAR(50),
    
)

CREATE TABLE Books (
    ISBN13 NVARCHAR(255) PRIMARY KEY,
    Title NVARCHAR(50),
    [Language] NVARCHAR(50),
    [Price] MONEY,
    [Publishing date] date,
    [AuthorID] INT FOREIGN KEY ([AuthorID]) REFERENCES Authors(ID), 
    [PublisherID] INT FOREIGN KEY (PublisherID) REFERENCES Publishers(ID)
)

GO

CREATE TABLE Customers (
    [ID] INT PRIMARY KEY,
    [FirstName] NVARCHAR(50),
    [Lastname] NVARCHAR(50),
    [Email] NVARCHAR(50),
    [Address] NVARCHAR(50),
    [City] NVARCHAR(50),
    [Zip] NVARCHAR(50),
    [Country] NVARCHAR(50)
)

GO

CREATE TABLE Basket (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
)

GO

CREATE TABLE BookOrder (
    BasketID INT FOREIGN KEY (BasketID) REFERENCES Basket(ID),
    ISBN13 NVARCHAR(255) FOREIGN KEY(ISBN13) REFERENCES Books(ISBN13),
    Amount INT
)

GO

CREATE TABLE Stores (
    ID INT PRIMARY KEY,
    StoreName NVARCHAR(50),
    [Address] NVARCHAR(50),
    [City] NVARCHAR(50),
    [Zip] NVARCHAR(50),
    [Country] NVARCHAR(50),

)

GO

CREATE TABLE InStock (
    StoreID INT FOREIGN KEY (StoreID) REFERENCES Stores(ID),
    ISBN13 NVARCHAR(255) FOREIGN KEY (ISBN13) REFERENCES Books(ISBN13),
    Amount INT

    CONSTRAINT [PK_InStock] PRIMARY KEY (StoreID, ISBN13)
)

SELECT * from Authors

INSERT INTO Authors
VALUES 
('Lars', 'Kepler', '1966-03-02'),
('Jennie', 'Waldén', '1976-03-04'),
('Jo', 'Nesbø', '1960-03-29'),
('Henning', 'Mankell', '1948-02-03'),
('Klas', 'Östergren', '1955-02-20'),
('Irvine', 'Welsh', '1958-09-27')

SELECT * from Publishers

INSERT INTO Publishers
VALUES
(1, 'Bokförlaget Forum', 'Sveavägen 56', 'Stockholm', '10363', 'Sweden'),
(2, 'Albert Bonniers Förlag', 'Sveavägen 56', 'Stockholm', '10363', 'Sweden'),
(3, 'Bonnier Fakta', 'Sveavägen 56', 'Stockholm', '10363', 'Sweden'),
(4, 'Allen & Unwin', '406 Albert St', 'Melbourne', '3002', 'Australia'),
(5, 'Kehitysvammaliitto', 'Linnoitustie 2', 'Espoo', '02600', 'Finland'),
(6, 'Debolsillo', 'Travessera de Gracía 47-49', 'Barcelona', '08021', 'Spain'),
(7, 'Bokförlaget Polaris', 'Ludvigsbergsgatan 20', 'Stockholm', '11823', 'Sweden'),
(8, 'Vintage', '80 Strand', 'London', 'WC2R0RL', 'United Kingdom')

SELECT * FROM Books 

INSERT INTO Books
VALUES ('9789137154831', 'Där kräftorna sjunger', 'Swedish', 79, '2020-04-29', 1, 1)

INSERT INTO Books
VALUES
    ('9789100164218', 'Spegelmannen', 'Swedish', 99, '2020-10-21', 2, 2),
    ('9789178870417', 'Wok, ris, nudlar', 'Swedish', 210, '2020-09-22', 3, 3),
    ('9789100185596', 'Kungariket', 'Swedish', 99, '2020-09-25', 4, 2),
    ('9781865081816', 'Secrets in the Fire', 'English', 82, '2000-05-01', 5, 4),
    ('9789515805195', 'Mies rannalla (selkokielinen)', 'Finnish', 158, '2012-01-01', 5, 5),
    ('9788466329781', 'El Murcielago', 'Spanish', 126, '2016-09-01', 4, 6),
    ('9789177953692', 'Gangsters', 'Swedish', 165, '2020-08-27', 6, 7),
    ('9789177953685', 'Gentlemen', 'Swedish', 165, '2020-08-27', 6, 7),
    ('9780099591115', 'Filth', 'English', 107, '1999-08-01', 7, 8)

SELECT * FROM Stores

INSERT INTO Stores
VALUES ('Store','Karlsborgsvägen.20','Oskarshamn',57260,'Sweden'),
       ('BookStore','SitusGatan.123','Lammarhamn',25260,'Sweden'),
       ('ReadNGo','Svennshög.64','Arlöv',19302,'Sweden'),
       ('MangaNerd','GravstenVägen.03','Lund',34402,'Sweden'),
       ('OwlsNest','Randstadsvägen.22','Upsala',78202,'Sweden')


INSERT INTO  Instock (StoreID, ISBN13, Amount) 
values (1,'9789137154831',10),
       (2,'9789100164218',15),
       (3,'9789178870417',20),
       (4,'9789100185596',24),
       (5,'9781865081816',30)

SELECT * FROM InStock

INSERT INTO InStock
VALUES 
    (1, '9789515805195', 25),
    (3, '9788466329781', 31),
    (4, '9789177953692', 21),
    (1, '9789177953685', 19),
    (2, '9780099591115', 22)

SELECT * from BookOrder

INSERT INTO BookOrder
VALUES
    (1, '9789100185596', 1 ),
    (2, '9789177953692', 1 )

INSERT INTO Customers
            VALUES (1,'James','Butterburg', 'james@gmail.com', 'Blue Gum Street', 'New York', '70116','United States of America'),
                   (2,'Josephine', 'Darakjy', 'josephine@hotmail.com','Ridge Blvd', 'Brighton', '48116','United Kingdom'),
                   (3,'Arthur','Chemel','arthur@gmail.com','Jalan Bisma', 'Ubud','08014','Indonesia')

SELECT * from Customers

SELECT * from Basket

INSERT INTO Basket (CustomerID)
VALUES (1), (2), (3)

GO

-- View
CREATE VIEW [Titles per author] AS 
SELECT 
    CONCAT(FirstName, ' ', LastName) as [Name],
    DATEDIFF(Year, Birthday, GETDATE()) as Age,
    COUNT(Books.Title) as Titles,
    FORMAT(SUM(InStock.Amount * Books.Price), 'C', 'sv-se' ) as [Stock value]
    
from Authors
INNER JOIN Books ON Authors.ID = Books.AuthorID
INNER JOIN InStock ON InStock.ISBN13 = Books.ISBN13
GROUP BY FirstName, LastName, Birthday

GO

Select * from [Titles per author]

CREATE TABLE BookAuthor (
    ISBN13 NVARCHAR(255) FOREIGN KEY (ISBN13) REFERENCES Books(ISBN13),
    AuthorID INT FOREIGN KEY (AuthorID) REFERENCES Authors(ID)
)

SELECT * from BookAuthor

INSERT INTO BookAuthor
VALUES
    ('9780099591115', 7),
    ('9781865081816', 5),
    ('9788466329781', 4),
    ('9789100164218', 2),
    ('9789100185596', 4),
    ('9789137154831', 1),
    ('9789177953685', 6),
    ('9789177953692', 6),
    ('9789178870417', 3),
    ('9789515805195', 5)

SELECT Books.Title, CONCAT(Authors.FirstName, ' ', Authors.LastName) as [Author name]
FROM Books
INNER JOIN BookAuthor ON Books.ISBN13 = BookAuthor.ISBN13
INNER JOIN Authors ON BookAuthor.AuthorID = Authors.ID

-- Removed AuthorID from Books table so a book can have more than one author

ALTER TABLE Books
DROP CONSTRAINT FK__Books__AuthorID__286302EC

ALTER TABLE Books
DROP COLUMN AuthorID 

SELECT * from Books

INSERT INTO Authors
VALUES ('Ebba', 'Kleberg von Sydow', '1976-6-12'), ('Emilia', 'de Poiret', '1965-5-3')

INSERT INTO Books
VALUES
    ('9789178870431', 'Säker stil - Utmana din garderob', 'Swedish', 199, '2021-02-18', 3 )

INSERT INTO BookAuthor
VALUES ('9789178870431', 8), ('9789178870431', 9)

SELECT * from Authors


select * from Basket
SELECT * from BookOrder
SELECT * from Customers

GO

CREATE VIEW [Order records] AS

SELECT 
    CONCAT(FirstName, ' ', Lastname) as [Customer name],
    Books.Title,
    BookOrder.Amount,
    FORMAT(SUM(BookOrder.Amount * Books.Price), 'C', 'sv-se') as Total

    
FROM Customers
INNER JOIN Basket ON Customers.ID = Basket.CustomerID
INNER JOIN BookOrder ON Basket.ID = BookOrder.BasketID
INNER JOIN Books ON Books.ISBN13 = BookOrder.ISBN13
GROUP BY FirstName, Lastname, Title, Amount

-- It is important for the store to know which customers have ordered which books, both for record-keeping and making sure the right books go to the right customer.

GO
-- NEW ADDITIONS START HERE!!

-- make columns in BookAuthor NOT NULL

ALTER TABLE BookAuthor
ALTER COLUMN ISBN13 NVARCHAR(255) NOT NULL

ALTER TABLE BookAuthor
ALTER COLUMN AuthorID INT NOT NULL

-- add primary key to BookAuthor

ALTER TABLE BookAuthor
ADD CONSTRAINT PK_BookAuthor PRIMARY KEY (ISBN13, AuthorID)

-- make BasketID and ISBN13 NOT NULL

ALTER TABLE BookOrder
ALTER COLUMN BasketID INT NOT NULL

ALTER TABLE BookOrder
ALTER COLUMN ISBN13 NVARCHAR(255) NOT NULL

-- add primary key to BookOrder

ALTER TABLE BookOrder
ADD CONSTRAINT PK_BookOrder PRIMARY KEY (BasketID, ISBN13)

-- fix Titles per author view
-- changed COUNT(BookAuthor.AuthorID) to COUNT(DISTINCT BookAuthor.ISBN13) so it doesn't count the books in each store as separate titles

DROP VIEW [Titles per author]

-- This one is wrong!
-- GO

-- CREATE VIEW [Titles per author] AS 
-- SELECT 
--     CONCAT(FirstName, ' ', LastName) as [Name],
--     DATEDIFF(Year, Birthday, GETDATE()) as Age,
--     COUNT(BookAuthor.AuthorID) as Titles,
--     FORMAT(SUM(InStock.Amount * Books.Price), 'C', 'sv-se' ) as [Stock value]
    
-- from Authors

-- INNER JOIN BookAuthor ON BookAuthor.AuthorID = Authors.ID
-- INNER JOIN Books on Books.ISBN13 = BookAuthor.ISBN13
-- INNER JOIN InStock ON InStock.ISBN13 = Books.ISBN13
-- GROUP BY FirstName, LastName, Birthday

GO

-- This one is right!
CREATE VIEW [Titles per Author] AS
SELECT 
    CONCAT(FirstName, ' ', LastName) as [Name],
    DATEDIFF(Year, Birthday, GETDATE()) as Age,
    COUNT(DISTINCT BookAuthor.ISBN13) as Titles,
    FORMAT(SUM(InStock.Amount * Books.Price), 'C', 'sv-se' ) as [Stock value]
    
FROM  Authors

INNER JOIN BookAuthor ON BookAuthor.AuthorID = Authors.ID
INNER JOIN Books on Books.ISBN13 = BookAuthor.ISBN13
INNER JOIN InStock on Books.ISBN13 = InStock.ISBN13
GROUP BY FirstName, LastName, Birthday

GO

-- Add all books to all stores in InStock

INSERT INTO InStock
VALUES
    (1, '9780099591115', 22), (1, '9781865081816', 18), (1, '9788466329781', 30),
    (1, '9789100164218', 13), (1, '9789100185596', 21), (1, '9789177953692', 9 ),
    (1, '9789178870417', 15), (1, '9789178870431', 8), (2, '9781865081816', 20), 
    (2, '9788466329781', 15), (2, '9789100185596', 10),(2, '9789137154831', 13), 
    (2, '9789177953685', 22 ), (2, '9789177953692', 21 ), (2, '9789178870417', 18), 
    (2, '9789178870431', 17 ), (2, '9789515805195', 7), (3, '9780099591115', 30), 
    (3, '9781865081816', 13), (3, '9789100164218', 27), (3, '9789100185596', 22), 
    (3, '9789137154831', 10), (3, '9789177953685', 17), (3, '9789177953692', 23), 
    (3, '9789178870431', 18), (3, '9789515805195', 29), (4, '9780099591115', 11), 
    (4, '9781865081816', 23), (4, '9788466329781', 22), (4, '9789100164218', 19), 
    (4, '9789137154831', 9), (4, '9789177953685', 8), (4, '9789178870417', 22), 
    (4, '9789178870431', 31), (4, '9789515805195', 12), (5, '9780099591115', 15), 
    (5, '9788466329781', 20), (5, '9789100164218', 21), (5, '9789100185596', 14), 
    (5, '9789137154831', 12), (5, '9789177953685', 15), (5, '9789177953692', 5), 
    (5, '9789178870417', 13), (5, '9789178870431', 11), (5, '9789515805195', 7)


-- Add to BookOrder so we can demo more than one title in Basket

INSERT INTO BookOrder
VALUES (1, '9789177953692', 2)

-- Add price to BookOrder so we can get price from here instead of from Books in Order records view 

ALTER TABLE BookOrder
ADD [Price] money

-- Populate Price column

UPDATE BookOrder
SET Price = 99 * Amount WHERE ISBN13 = '9789100185596'

UPDATE BookOrder
SET Price = 165 * Amount WHERE ISBN13 = '9789177953692'

select * from BookOrder

-- Add order date to Basket

ALTER TABLE Basket
ADD [Order date] DATE

-- Populate Order date

UPDATE Basket 
SET [Order date] = '2021-01-13' WHERE ID = 1

UPDATE Basket 
SET [Order date] = '2021-03-15' WHERE ID = 2

UPDATE Basket 
SET [Order date] = '2021-03-19' WHERE ID = 3


SELECT * from [Order records]

-- Making the Order records view better :)

DROP VIEW [Order records]

GO
CREATE VIEW [Order records] AS
SELECT 
    CONCAT(FirstName, ' ', Lastname) as [Customer name],
    Books.Title,
    BookOrder.Amount,
    FORMAT(SUM(BookOrder.Amount * Books.Price), 'C', 'sv-se') as [Total at Current Price],
    FORMAT(BookOrder.Price/BookOrder.Amount, 'C', 'sv-se') as [Unit price on order date],
    FORMAT(BookOrder.Price, 'C', 'sv-se') as [Order total],
    Basket.[Order date] as [Order date]

    
FROM Customers
INNER JOIN Basket ON Customers.ID = Basket.CustomerID
INNER JOIN BookOrder ON Basket.ID = BookOrder.BasketID
INNER JOIN Books ON Books.ISBN13 = BookOrder.ISBN13
GROUP BY FirstName, Lastname, Title, Amount, [Order date], BookOrder.Price

GO

-- Adding a few more rows to Basket and BookOrder

INSERT INTO BookOrder
VALUES 
    (3, '9781865081816', 2, 200), 
    (3, '9780099591115', 1, 99), 
    (2, '9789515805195', 1, 99),
    (2, '9788466329781', 1, 126)
