USE grocery_sales;

-- 1) categories
CREATE TABLE IF NOT EXISTS categories (
  CategoryID INT PRIMARY KEY,
  CategoryName VARCHAR(45)
);

-- 2) countries
CREATE TABLE IF NOT EXISTS countries (
  CountryID INT PRIMARY KEY,
  CountryName VARCHAR(45),
  CountryCode VARCHAR(2)
);

-- 3) cities
CREATE TABLE IF NOT EXISTS cities (
  CityID INT PRIMARY KEY,
  CityName VARCHAR(45),
  Zipcode DECIMAL(5,0),
  CountryID INT,
  FOREIGN KEY (CountryID) REFERENCES countries(CountryID)
);

-- 4) customers
CREATE TABLE IF NOT EXISTS customers (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(45),
  MiddleInitial VARCHAR(1),
  LastName VARCHAR(45),
  CityID INT,
  Address VARCHAR(90),
  FOREIGN KEY (CityID) REFERENCES cities(CityID)
);

-- 5) employees
CREATE TABLE IF NOT EXISTS employees (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(45),
  MiddleInitial VARCHAR(1),
  LastName VARCHAR(45),
  BirthDate DATE,
  Gender VARCHAR(10),
  CityID INT,
  HireDate DATE,
  FOREIGN KEY (CityID) REFERENCES cities(CityID)
);

-- 6) products
CREATE TABLE IF NOT EXISTS products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(45),
  Price DECIMAL(10,2),
  CategoryID INT,
  Class VARCHAR(15),
  ModifyDate DATE,
  Resistant VARCHAR(15),
  IsAllergic VARCHAR(15),
  VitalityDays DECIMAL(3,0),
  FOREIGN KEY (CategoryID) REFERENCES categories(CategoryID)
);

-- 7) sales
CREATE TABLE IF NOT EXISTS sales (
  SalesID INT PRIMARY KEY,
  SalesPersonID INT,
  CustomerID INT,
  ProductID INT,
  Quantity INT,
  Discount DECIMAL(10,2),
  TotalPrice DECIMAL(10,2),
  SalesDate DATETIME,
  TransactionNumber VARCHAR(25),
  FOREIGN KEY (SalesPersonID) REFERENCES employees(EmployeeID),
  FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
  FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);
