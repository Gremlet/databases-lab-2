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
values (1,9789137154831,10),
       (2,9789100164218,15),
       (3,9789178870417,20),
       (4,9789100185596,24),
       (5,9781865081816,30)

SELECT * FROM InStock