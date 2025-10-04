
-- here we create and access our database
create database myProject;
use myProject;

-- Here we create our books table
CREATE TABLE Books (
    Book_ID int AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

select * from Books; # for display the Book table

-- here we creating our customer table
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,  #here serial keyword means auto increment + integer
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

select * from Customers; # for display the Customer table

-- here we creating our orders table
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

select * from Orders; # for display the orders table

-- -----------------X-----------------X-----------------X-----------------X-----------------X

-- now importing all the files by going on schemas and right click on tables then import

-- -----------------X-----------------X-----------------X-----------------X-----------------X
select * from Customers;
select * from Books;
select * from Orders;

-- 1) Retrieve all books in the "Fiction" genre:
select Title,Genre from Books where Genre="Fiction";


-- 2) Find books published after the year 1950:
select Title,Published_Year from Books where Published_Year>1950 order by Published_Year;

-- 3) List all customers from the Canada:
select Name,country from customers where country="canada";

-- 4) Show orders placed in November 2023:
select * from orders where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as "Total Book Stock" from books;

-- 6) Find the details of the most expensive book:
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select customers.customer_id,customers.name,orders.quantity from customers join orders on customers.customer_id=orders.order_id where customers.customer_id>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where total_amount>20;

-- 9) List all genres available in the Books table:
select distinct(genre) as "Total Genre Avilables" from books;

-- 10) Find the book with the lowest stock:
select * from books order by stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
select SUM(Total_Amount) as "total revenue generated " from orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select B.genre,sum(O.quantity) from Orders O join Books B on O.Book_id=B.Book_id group by genre;


-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as "Average Price of Fantasy genre Books" from books where genre="Fantasy";


-- 3) List customers who have placed at least 2 orders:
select customers.name,count(orders.order_id) as "order count" from customers join orders on customers.customer_id=orders.customer_id group by customers.name having count(orders.order_id)>2;

-- 4) Find the most frequently ordered book:
select Books.Book_id,Books.Title,count(Books.Book_id) as "order_count" from Books join Orders on Books.Book_id=Orders.Book_id group by Books.Book_id order by order_count desc limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where Genre="Fantasy" order by price desc limit 3;


-- 6) Retrieve the total quantity of books sold by each author:
select Books.author,sum(Orders.Quantity) as "total_quantity" from books join orders on Books.Book_id=Orders.Book_id group by Books.author;
select * from orders;

-- 7) List the cities where customers who spent over $30 are located:
select Customers.City,sum(Orders.Total_Amount) as "Total_Spent" from Customers join Orders on Customers.Customer_id=Orders.Order_id group by City having Total_Spent>30;

-- 8) Find the customer who spent the most on orders:
select * from customers;
select * from orders;

select Customers.name,sum(Orders.Total_Amount) as "Most_Spent_on_Orders" from Customers join Orders on Customers.Customer_id=Orders.Customer_id group by Customers.name order by Most_Spent_on_Orders desc limit 1;

-- 8) Calculate the remaining stock after full filling all orders
select * from books;
select * from orders;
select sum(books.stock)-sum(orders.quantity) as "remaining stock" from books inner join orders on books.book_id=orders.order_id;


-- 9) Calculate the remaining books stock after full filling all orders
select Books.Book_id,Books.Title,Books.stock,coalesce(sum(Orders.Quantity),0),
Books.stock-coalesce(sum(Orders.Quantity),0) as "Remaining Stock" from Books left join Orders 
on Books.Book_id=Orders.Book_id group by Books.Book_id order by Books.Book_id;
