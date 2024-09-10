USE LibraryManagementSystem;

-- Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    published_year INT,
    genre VARCHAR(100),
    availability_status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255)
);

-- Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100),
    email VARCHAR(255)
);

-- Borrow Table
CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    staff_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

INSERT INTO Authors (name, country) VALUES ('J.K. Rowling', 'UK'), ('George Orwell', 'UK'), ('Jhon Green', 'USA'), ('Jane Austen', 'UK'), ('Margaret Atwood', 'CA');

INSERT INTO Books (title, author_id, published_year, genre) 
VALUES ('Harry Potter', 1, 1997, 'Fantasy'), ('1984', 2, 1949, 'Dystopian'), ('Bajo la misma estrella', 3, 2012, 'Novela'), ('Orgullo y prejuicio', 4, 1813, 'Novela Rosa'), ('Los testamentos', 5, 2019, 'Ciencia Ficcion');

INSERT INTO Members (name, address, email) 
VALUES ('John Doe', '123 Main St', 'johndoe@email.com'), ('Juan Cruz Benitez', 'Av.Real', 'juancruzbeniteza@gmail.com'), ('Jane Smith', '456 Oak St', 'janesmith@email.com'), ('Carlos Mendoza', '789 Pine Ave', 'carlosmendoza@email.com'), ('Emily Davis', '321 Maple Blvd', 'emilydavis@email.com');

INSERT INTO Staff (name, role, email) 
VALUES ('Alice Johnson', 'Librarian', 'alice.johnson@email.com'), ('Bob Thompson', 'Assistant Librarian', 'bob.thompson@email.com'), ('Sarah Brown', 'Clerk', 'sarah.brown@email.com'), ('David Lee', 'Manager', 'david.lee@email.com'), ('Michael White', 'Archivist', 'michael.white@email.com');

INSERT INTO Borrow (book_id, member_id, staff_id, borrow_date, return_date) 
VALUES (1, 1, 1, '2024-09-01', '2024-09-15'),
       (2, 2, 2, '2024-09-02', '2024-09-16'),
       (1, 3, 3, '2024-09-03', '2024-09-17'),
       (2, 1, 4, '2024-09-04', '2024-09-18'),
       (1, 2, 5, '2024-09-05', '2024-09-19');

SELECT * FROM borrow;