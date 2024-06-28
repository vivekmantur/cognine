--1)
use vivek_273;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
CREATE TABLE salaries (
    employee_id INT,
    salary_amount DECIMAL(10, 2) NOT NULL,
    salary_date DATE NOT NULL,
    PRIMARY KEY (employee_id, salary_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


INSERT INTO departments (department_id, department_name) VALUES
(1, 'Hr'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Sales'),
(6, 'Customer Support');

INSERT INTO employees (employee_id, employee_name, department_id, hire_date) VALUES
(1, 'ram', 1, '2020-01-15'),
(2, 'jaddu', 2, '2019-03-22'),
(3, 'smitha', 3, '2018-07-30'),
(4, 'karthik', 4, '2021-11-10'),
(5, 'Michael', 5, '2020-05-19'),
(6, 'harsha', 6, '2017-09-25');

INSERT INTO salaries (employee_id, salary_amount, salary_date) VALUES
(1, 50000, '2021-05-2'),
(1, 52000, '2023-02-15'),
(2, 60000, '2020-01-01'),
(2, 62000, '2021-02-23'),
(3, 70000, '2023-01-01'),
(3, 72000, '2024-01-01'),
(4, 80000, '2023-01-21'),
(4, 82000, '2022-08-17'),
(5, 90000, '2023-07-11'),
(5, 92000, '2022-01-19'),
(6, 55000, '2028-02-22'),
(6, 57000, '2018-03-06');


--Write a SQL query to retrieve the names of employees along with their department names and the latest salary amount.
select e.employee_name,d.department_name,s.salary_amount from employees e join departments d on e.department_id=d.department_id join salaries s on s.employee_id=e.employee_id
where(salary_date) IN (SELECT MAX(salary_date) FROM salaries GROUP BY employee_id);

--2)
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Grocories'),
(2, 'Books'),
(3, 'Clothing'),
(4, 'Audio'),
(5, 'Toys');

INSERT INTO products (product_id, product_name, category_id, price) VALUES
(1, 'Bread', 1, 30.00),
(2, 'earphone', 4,700.00),
(3, 'JCB', 5, 299.99),
(4, 'T-Shirt', 3, 199.99),
(5, 'Novel', 2, 99.99),
(6, 'earbuds', 4, 1999.99),
(7, 'chillipowder', 1, 49.99),
(8, 'Jeans', 3, 299.99),
(9, 'Puzzle', 5, 79.99);

INSERT INTO orders (order_id, product_id, quantity, order_date) VALUES
(1, 1, 2, '2024-03-10'),
(2, 3, 1, '2023-01-12'),
(3, 5, 3, '2024-02-15'),
(4, 7, 1, '2024-09-18'),
(5, 9, 2, '2024-07-20'),
(6, 2, 1, '2024-01-22'),
(7, 4, 5, '2024-02-25'),
(8, 6, 2, '2024-10-28'),
(9, 8, 3, '2024-12-01');

insert into orders values (10,9,2,'2024-05-20');
insert into orders values (11,4,7,'2024-05-06');

use vivek_273;

select c.category_id,c.category_name,p.price*o.quantity as tot_revenue from categories c join products p on p.category_id=c.category_id join orders o
on o.product_id=p.product_id where month(order_date)=month(getdate())-1;




--3

CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    author_country VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255) NOT NULL,
    author_id INT,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE borrowers (
    borrower_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(100) NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO authors (author_id, author_name, author_country) VALUES
(1, 'raj', 'India'),
(2, 'John', 'Uk'),
(3, 'Mukesh', 'India'),
(4, 'Lee', 'Chaina'),
(5, 'Mark', 'United States');

INSERT INTO books (book_id, book_title, author_id, publication_date) VALUES
(1, 'the begin of run', 1, '2000-06-08'),
(2, 'Harry Potter and the Philosopher', 2, '2012-06-26'),
(3, 'The ruler', 3, '1994-07-29'),
(4, 'Death note', 4, '1960-07-11'),
(5, 'Adventures', 5, '1884-12-10'),
(6, 'A Farm', 1, '1945-08-17'),
(7, 'Harry Potter and the Chamber of Secrets', 2, '2008-07-02'),
(8, 'The Man', 3, '1937-09-21'),
(9, 'Go Watch', 4, '2015-07-14'),
(10, 'The Add', 5, '1912-12-01');

INSERT INTO borrowers (borrower_id, book_id, borrower_name, borrow_date, return_date) VALUES
(1, 1, 'Green', '2024-01-10', '2024-01-24'),
(2, 3, 'Smith', '2024-01-12', '2024-01-26'),
(3, 5, 'Head', '2024-01-15', '2024-01-29'),
(4, 7, 'william', '2024-01-18', '2024-02-01'),
(5, 9, 'Eve Davis', '2024-01-20', '2024-02-03'),
(6, 2, 'Frank Miller', '2024-01-22', '2024-02-05'),
(7, 4, 'Grace Lee', '2024-01-25', '2024-02-08'),
(8, 6, 'Hank Green', '2024-01-28', '2024-02-11'),
(9, 8, 'Ivy Walker', '2024-02-01', '2024-02-15'),
(10, 10, 'Jack White', '2024-02-05', '2024-02-19');

select authors.author_name,books.book_title,borrowers.borrower_name,borrowers.borrow_date,borrowers.return_date
from authors 
join books on authors.author_id = books.author_id
join borrowers on borrowers.book_id = books.book_id

--4)
use vivek_273;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_major VARCHAR(100) NOT NULL
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_department VARCHAR(100) NOT NULL
);
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
CREATE TABLE grades (
    grade_id INT PRIMARY KEY,
    enrollment_id INT,
    grade_value CHAR(2) NOT NULL,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

=INSERT INTO students (student_id, student_name, student_major) VALUES
(1, 'Alice Johnson', 'Computer Science'),
(2, 'Bob Smith', 'Mathematics'),
(3, 'Ravi Kumar', 'Physics'),
(4, 'Anjali Sharma', 'Chemistry'),
(5, 'Eva Green', 'Biology'),
(6, 'Frank Black', 'Computer Science'),
(7, 'Grace King', 'Mathematics'),
(8, 'Priya Singh', 'Physics'),
(9, 'Suresh Patel', 'Chemistry'),
(10, 'Jack Wilson', 'Biology');

INSERT INTO courses (course_id, course_name, course_department) VALUES
(1, 'Introduction to Programming', 'Computer Science'),
(2, 'Calculus I', 'Mathematics'),
(3, 'General Physics', 'Physics'),
(4, 'Organic Chemistry', 'Chemistry'),
(5, 'General Biology', 'Biology'),
(6, 'Data Structures', 'Computer Science'),
(7, 'Linear Algebra', 'Mathematics'),
(8, 'Quantum Mechanics', 'Physics'),
(9, 'Physical Chemistry', 'Chemistry'),
(10, 'Microbiology', 'Biology');

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 1, '2024-01-10'),
(2, 2, 2, '2024-01-12'),
(3, 3, 3, '2024-01-15'), 
(4, 4, 4, '2024-01-18'), 
(5, 5, 5, '2024-01-20'), 
(6, 6, 6, '2024-01-22'), 
(7, 7, 7, '2024-01-25'), 
(8, 8, 8, '2024-01-28'), 
(9, 9, 9, '2024-02-01'),
(10, 10, 10, '2024-02-05');

INSERT INTO grades (grade_id, enrollment_id, grade_value) VALUES
(1, 1, 4), 
(2, 2, 2), 
(3, 3, 8), 
(4, 4, 2), 
(5, 5, 8), 
(6, 6, 2), 
(7, 7, 9), 
(8, 8, 6), 
(9, 9, 8), 
(10, 10, 5); 



select c.course_id,avg(g.grade_value) as avggrade from courses c join enrollments e
on c.course_id=e.course_id join grades g on e.enrollment_id=g.enrollment_id group by c.course_id;

--5--
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_country VARCHAR(100) NOT NULL
);
CREATE TABLE pproducts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE oorders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE NOT NULL,
    order_quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES pproducts(product_id)
);

INSERT INTO customers (customer_id, customer_name, customer_country) VALUES
(1, 'John Doe', 'USA'),
(2, 'Jane Smith', 'USA'),
(3, 'Ravi Kumar', 'India'),
(4, 'Satoshi Tanaka', 'Japan'),
(5, 'Linda Wong', 'Canada'),
(6, 'Anjali Sharma', 'India'),
(7, 'Carlos Ruiz', 'Spain'),
(8, 'David Miller', 'USA'),
(9, 'Priya Singh', 'India'),
(10, 'Emily Davis', 'USA');

INSERT INTO pproducts (product_id, product_name, product_price) VALUES
(1, 'Laptop', 999.99),
(2, 'Smartphone', 699.99),
(3, 'Tablet', 399.99),
(4, 'Monitor', 199.99),
(5, 'Keyboard', 49.99),
(6, 'Mouse', 29.99),
(7, 'Printer', 149.99),
(8, 'Camera', 499.99),
(9, 'Headphones', 89.99),
(10, 'Speaker', 59.99);

INSERT INTO oorders (order_id, customer_id, product_id, order_date, order_quantity) VALUES
(1, 1, 1, '2024-01-10', 2), 
(2, 2, 3, '2024-01-12', 1), 
(3, 3, 5, '2024-01-15', 3), 
(4, 4, 7, '2024-01-18', 1), 
(5, 5, 9, '2024-01-20', 2), 
(6, 6, 2, '2024-01-22', 1),
(7, 7, 4, '2024-01-25', 5),
(8, 8, 6, '2024-01-28', 2), 
(9, 9, 8, '2024-02-01', 3), 
(10, 10, 10, '2024-02-05', 4);

select * from oorders;
select * from pproducts;
select * from customers;
select c.customer_country,sum(order_quantity*product_price) as tot_revenue from customers c join oorders o on c.customer_id=o.customer_id join pproducts p on
p.product_id=o.product_id group by c.customer_country;






