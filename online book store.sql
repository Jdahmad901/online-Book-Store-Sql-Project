 
 SELECT * FROM Books;

SELECT * FROM Orders;

SELECT * FROM Customers;




CREATE TABLE Books(
Book_ID	SERIAL PRIMARY KEY,
Title VARCHAR(100),	
Author VARCHAR(100),	
Genre VARCHAR(100),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT

);



CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(50),
Email	VARCHAR(50),
Phone VARCHAR(100),	
City VARCHAR(150),
Country VARCHAR(200)

);









CREATE TABLE orders(
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_id),
Book_ID INT REFERENCES Orders(Order_id),
Order_Date	DATE,
Quantity INT,	
Total_Amount NUMERIC(10,2)

); 







 1) Retrieve all books in the "Fiction" genre
 
 SELECT * FROM Books 
 WHERE genre ='Fiction';
 
 2) Find books published after the year 1950

SELECT * FROM Books
WHERE Published_year >1950;
 
 3) List all customers from the Canada

 SELECT * FROM Customers
 WHERE country Like'Canada';

 
 4) Show orders placed in November 2023
 
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';



 
 5) Retrieve the total stock of books available

 SELECT SUM(stock) AS Available_books FROM  Books;
 
 6) Find the details of the most expensive book

SELECT * FROM Books ORDER BY price DESC
LIMIT 1;

 
 7) Show all customers who ordered more than 1 quantity of a book
 
 SELECT * FROM Orders
 WHERE quantity >1;
 
 8) Retrieve all orders where the total amount exceeds $20

 SELECT * FROM Orders
 WHERE total_amount >20;

 
 9) List all genres available in the Books table

SELECT DISTINCT genre FROM Books;


 10) Find the book with the lowest stock
 
SELECT * FROM Books ORDER BY stock LIMIT 1;

 
 11) Calculate the total revenue generated from all orders

 SELECT SUM(total_amount)  FROM Orders AS total_revanue;













 



  1) Retrieve the total number of books sold for each genre
  
SELECT b.genre, SUM(o.Quantity) AS total_sold
FROM Books b
JOIN Orders o ON b.Book_id = o.Book_id
GROUP BY b.genre;


  
  
 2) Find the average price of books in the "Fantasy" genre

 SELECT AVG(price) AS AVG_PRICE FROM Books
 WHERE genre ='Fantasy';


 
 3) List customers who have placed at least 2 orders

 SELECT c.customer_id,c.name,COUNT(o.order_id ) AS COUNT_TOTAL_ORDERS
 FROM Orders o
 JOIN customers c
 ON c.Customer_id = o.customer_id
 GROUP BY c.Customer_id,c.name
 HAVING COUNT(o.order_id ) >=2 ;

 
 
 
 4) Find the most frequently ordered book

 SELECT o.Book_id, b.title, COUNT(o.order_id) AS count_order
 FROM orders o
 JOIN books b
 ON b.Book_id =o.Book_id
 GROUP BY o.Book_id,b.title
 ORDER BY count_order DESC
 LIMIT 1;

 
 5) Show the top 3 most expensive books of 'Fantasy' Genre 
 
 SELECT * FROM Books 
 WHERE genre ='Fantasy'
 ORDER BY price DESC
 LIMIT 3;
 
 
 



 
6) Retrieve the total quantity of books sold by each author

 SELECT  b.author , SUM(o.quantity) AS Total_quantity
 FROM Orders o
 JOIN Books b
 ON o.book_id= b.book_id
 GROUP BY b.author;


 7) List the cities where customers who spent over $30 are located

 SELECT DISTINCT c.city,o.total_amount FROM orders o JOIN customers c
 ON o.customer_id = c.customer_id
 GROUP BY c.customer_id,o.total_amount
 HAVING o.total_amount >30;


 SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.total_amount > 30;

 
 




 
 8) Find the customer who spent the most on orders

 SELECT c.customer_id,c.name, SUM(o.total_amount) TOTAL_SPENT 
 FROM orders o JOIN customers c
 ON c.customer_id = o.customer_id 
 GROUP BY c.customer_id,c.name
 ORDER BY  TOTAL_SPENT DESC LIMIT 1;


 
 9) Calculate the stock remaining after fulfilling all orders

 SELECT b.book_id,b.author,b.stock, COALESCE(SUM(o.quantity),0) AS order_quantity,
 b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
 FROM books b LEFT JOIN orders o 
 ON b.book_id = o.book_id
 GROUP BY b.book_id ORDER BY b.book_id ;
 














