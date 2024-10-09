USE LibraryManagementSystem;

-- Authors Table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

-- Books Table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    published_year INT,
    genre VARCHAR(100),
    availability_status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Members Table
CREATE TABLE IF NOT EXISTS Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255)
);

-- Staff Table
CREATE TABLE IF NOT EXISTS Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100),
    email VARCHAR(255)
);

-- Borrow Table 
CREATE TABLE IF NOT EXISTS Borrow (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    staff_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- Junction table to allow multiple books per borrowing
CREATE TABLE IF NOT EXISTS BorrowBooks (
    borrow_id INT,
    book_id INT,
    PRIMARY KEY (borrow_id, book_id),
    FOREIGN KEY (borrow_id) REFERENCES Borrow(borrow_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert sample data into Authors table
INSERT INTO Authors (name, country) VALUES 
('J.K. Rowling', 'UK'), 
('George Orwell', 'UK'), 
('John Green', 'USA'), 
('Jane Austen', 'UK'), 
('Margaret Atwood', 'CA');

-- Insert sample data into Books table
INSERT INTO Books (title, author_id, published_year, genre) 
VALUES ('Harry Potter', 1, 1997, 'Fantasy'), 
       ('1984', 2, 1949, 'Dystopian'), 
       ('Bajo la misma estrella', 3, 2012, 'Novel'), 
       ('Orgullo y prejuicio', 4, 1813, 'Romance'), 
       ('Los testamentos', 5, 2019, 'Science Fiction');

-- Insert sample data into Members table
INSERT INTO Members (name, address, email) 
VALUES ('John Doe', '123 Main St', 'johndoe@email.com'), 
       ('Juan Cruz Benitez', 'Av.Real', 'juancruzbeniteza@gmail.com'), 
       ('Jane Smith', '456 Oak St', 'janesmith@email.com'), 
       ('Carlos Mendoza', '789 Pine Ave', 'carlosmendoza@email.com'), 
       ('Emily Davis', '321 Maple Blvd', 'emilydavis@email.com');

-- Insert sample data into Staff table
INSERT INTO Staff (name, role, email) 
VALUES ('Alice Johnson', 'Librarian', 'alice.johnson@email.com'), 
       ('Bob Thompson', 'Assistant Librarian', 'bob.thompson@email.com'), 
       ('Sarah Brown', 'Clerk', 'sarah.brown@email.com'), 
       ('David Lee', 'Manager', 'david.lee@email.com'), 
       ('Michael White', 'Archivist', 'michael.white@email.com');

-- Insert sample data into Borrow table
INSERT INTO Borrow (member_id, staff_id, borrow_date, return_date) 
VALUES (1, 1, '2024-09-01', '2024-09-15'),
       (2, 2, '2024-09-02', '2024-09-16'),
       (3, 3, '2024-09-03', '2024-09-17'),
       (1, 4, '2024-09-04', '2024-09-18'),
       (2, 5, '2024-09-05', '2024-09-19');

-- Truncate BorrowBooks table before inserting new data
TRUNCATE TABLE BorrowBooks;

-- Insert sample data into BorrowBooks table to link Borrow and Books
INSERT INTO BorrowBooks (borrow_id, book_id) 
VALUES 
(1, 1), (1, 2),  
(2, 1),          
(3, 3),          
(4, 2), (4, 1),  
(5, 1);          

-- Create View: Borrowing History
DROP VIEW IF EXISTS BorrowingHistory;
CREATE VIEW BorrowingHistory AS
SELECT 
    Borrow.borrow_id, 
    Members.name AS member_name, 
    Staff.name AS staff_name, 
    GROUP_CONCAT(Books.title SEPARATOR ', ') AS borrowed_books, 
    Borrow.borrow_date, 
    Borrow.return_date
FROM 
    Borrow
JOIN 
    BorrowBooks ON Borrow.borrow_id = BorrowBooks.borrow_id
JOIN 
    Books ON BorrowBooks.book_id = Books.book_id
JOIN 
    Members ON Borrow.member_id = Members.member_id
JOIN 
    Staff ON Borrow.staff_id = Staff.staff_id
GROUP BY 
    Borrow.borrow_id;

-- Drop the existing function before creating a new one if exists
DROP FUNCTION IF EXISTS TotalBooksBorrowed;

-- Function: Calculate Total Books Borrowed by a Member
DELIMITER //

CREATE FUNCTION TotalBooksBorrowed(memberID INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    
    SELECT COUNT(*) INTO total
    FROM BorrowBooks bb
    JOIN Borrow b ON bb.borrow_id = b.borrow_id
    WHERE b.member_id = memberID;
    
    -- Return the total
    RETURN total;
END //

DELIMITER ;

-- Stored Procedure: Add New Borrowing with Multiple Books 
DELIMITER $$

-- Drop the existing procedure if it exists
DROP PROCEDURE IF EXISTS AddNewBorrowing;

CREATE PROCEDURE AddNewBorrowing(
    IN memberID INT, 
    IN staffID INT, 
    IN borrowDate DATE, 
    IN returnDate DATE, 
    IN bookIDs VARCHAR(255)
) 
BEGIN
    DECLARE borrowID INT;
    DECLARE currentBookID VARCHAR(255);
    DECLARE done INT DEFAULT 0;
    DECLARE bookCursor CURSOR FOR 
    SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(bookIDs, ',', numbers.n), ',', -1)) 
    FROM (SELECT @row := @row + 1 as n 
          FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
                UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 
                UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) numbers, 
                (SELECT @row:=0) r) numbers 
    WHERE n <= LENGTH(bookIDs) - LENGTH(REPLACE(bookIDs, ',', '')) + 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Insert into Borrow table
    INSERT INTO Borrow (member_id, staff_id, borrow_date, return_date) 
    VALUES (memberID, staffID, borrowDate, returnDate);

    -- Get the last insert ID for Borrow
    SET borrowID = LAST_INSERT_ID();

    -- Loop through book IDs
    OPEN bookCursor;
    read_loop: LOOP
        FETCH bookCursor INTO currentBookID;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert into BorrowBooks table
        INSERT INTO BorrowBooks (borrow_id, book_id) 
        VALUES (borrowID, currentBookID);
    END LOOP;

    CLOSE bookCursor;
END $$

DELIMITER ;

-- Drop the existing trigger before creating a new one
DROP TRIGGER IF EXISTS UpdateBookAvailability;

DELIMITER $$

-- Trigger: Update Book Availability Status After Borrowing
CREATE TRIGGER UpdateBookAvailability 
AFTER INSERT ON BorrowBooks
FOR EACH ROW
BEGIN
    UPDATE Books 
    SET availability_status = FALSE 
    WHERE book_id = NEW.book_id;
END $$

DELIMITER ;

SELECT TotalBooksBorrowed(1);
