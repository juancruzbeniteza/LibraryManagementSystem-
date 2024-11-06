-- Drop and create the database
DROP DATABASE IF EXISTS LibraryManagementSystem;
CREATE DATABASE LibraryManagementSystem;
USE LibraryManagementSystem;

-- 1. Table Creation
-- Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    publication_year INT,
    ISBN VARCHAR(20) UNIQUE,
    quantity_available INT
);

-- Members Table
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    email VARCHAR(100)
);

-- Borrow Table
CREATE TABLE Borrows (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Staff Table (Optional, for library staff management)
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50)
);
CREATE TABLE Fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    borrow_id INT,
    fine_amount DECIMAL(10,2),
    fine_date DATE,
    payment_date DATE,
    FOREIGN KEY (borrow_id) REFERENCES Borrows(borrow_id)
);
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    rating INT,
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
-- seleccino el esquema correcto
USE LibraryManagementSystem;

-- Insertamos los datos a las tablas
INSERT INTO Books (title, author, genre, publication_year, ISBN, quantity_available) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, '9780743273565', 5),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, '9780061120084', 3),
('1984', 'George Orwell', 'Dystopian', 1949, '9780451524930', 4),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, '9780316769488', 2),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, '9781503290561', 6),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, '9781503280781', 3),
('War and Peace', 'Leo Tolstoy', 'Historical Fiction', 1869, '9780199232767', 2),
('The Odyssey', 'Homer', 'Epic', -800, '9780140268869', 4),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 1937, '9780547928222', 5),
('Fahrenheit 451', 'Ray Bradbury', 'Dystopian', 1953, '9781451673310', 3),
('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, '9780062315001', 5),
('Brave New World', 'Aldous Huxley', 'Dystopian', 1932, '9780060850525', 2),
('The Picture of Dorian Gray', 'Oscar Wilde', 'Philosophical Fiction', 1890, '9780141439571', 3),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Psychological Fiction', 1866, '9780143058142', 1),
('The Brothers Karamazov', 'Fyodor Dostoevsky', 'Philosophical Fiction', 1880, '9780374528378', 4),
('Catch-22', 'Joseph Heller', 'Satire', 1961, '9781451626651', 2),
('The Grapes of Wrath', 'John Steinbeck', 'Fiction', 1939, '9780143039431', 3),
('Wuthering Heights', 'Emily Brontë', 'Classic', 1847, '9780141439557', 5),
('The Chronicles of Narnia', 'C.S. Lewis', 'Fantasy', 1950, '9780066238501', 4),
('The Secret Garden', 'Frances Hodgson Burnett', 'Children', 1911, '9781503215151', 6),
('The Bell Jar', 'Sylvia Plath', 'Fiction', 1963, '9780061148515', 2),
('Jane Eyre', 'Charlotte Brontë', 'Classic', 1847, '9780142437200', 3),
('Les Misérables', 'Victor Hugo', 'Historical Fiction', 1862, '9780451419430', 2),
('The Road', 'Cormac McCarthy', 'Post-Apocalyptic', 2006, '9780307387890', 3),
('Gone with the Wind', 'Margaret Mitchell', 'Historical Fiction', 1936, '9781416548943', 1),
('The Fault in Our Stars', 'John Green', 'Young Adult', 2012, '9780525478813', 4),
('Little Women', 'Louisa May Alcott', 'Classic', 1868, '9780143132492', 5),
('The Sound and the Fury', 'William Faulkner', 'Fiction', 1929, '9780679732243', 4),
('Slaughterhouse-Five', 'Kurt Vonnegut', 'Satire', 1969, '9780385333850', 3),
('The Hunger Games', 'Suzanne Collins', 'Dystopian', 2008, '9780439023482', 4),
('The Maze Runner', 'James Dashner', 'Dystopian', 2009, '9780385737945', 6),
('Divergent', 'Veronica Roth', 'Dystopian', 2011, '9780062024030', 5),
('The Perks of Being a Wallflower', 'Stephen Chbosky', 'Young Adult', 1999, '9780671027347', 3),
('The Handmaid’s Tale', 'Margaret Atwood', 'Dystopian', 1985, '9780385490819', 4),
('A Brave New World', 'Aldous Huxley', 'Dystopian', 1932, '9780060850526', 2),
('The Outsiders', 'S.E. Hinton', 'Young Adult', 1967, '9780142407333', 6),
('Harry Potter and the Sorcerer’s Stone', 'J.K. Rowling', 'Fantasy', 1997, '9780590353428', 5),
('Harry Potter and the Chamber of Secrets', 'J.K. Rowling', 'Fantasy', 1998, '9780439064874', 4),
('Harry Potter and the Prisoner of Azkaban', 'J.K. Rowling', 'Fantasy', 1999, '9780439136366', 5),
('Harry Potter and the Goblet of Fire', 'J.K. Rowling', 'Fantasy', 2000, '9780439139602', 6),
('Harry Potter and the Order of the Phoenix', 'J.K. Rowling', 'Fantasy', 2003, '9780439358072', 5),
('Harry Potter and the Half-Blood Prince', 'J.K. Rowling', 'Fantasy', 2005, '9780439785968', 3),
('Harry Potter and the Deathly Hallows', 'J.K. Rowling', 'Fantasy', 2007, '9780545010222', 4),
('A Tale of Two Cities', 'Charles Dickens', 'Historical Fiction', 1859, '9780141439601', 2),
('The Invisible Man', 'H.G. Wells', 'Science Fiction', 1897, '9780451531400', 3),
('The Secret Life of Bees', 'Sue Monk Kidd', 'Fiction', 2002, '9780142001745', 5),
('The Giver', 'Lois Lowry', 'Young Adult', 1993, '9780440219077', 4),
('A Wrinkle in Time', 'Madeleine L’Engle', 'Science Fiction', 1962, '9780312367541', 3),
('The Bell Jar', 'Sylvia Plath', 'Fiction', 1963, '9780061148514', 5),
('The Kite Runner', 'Khaled Hosseini', 'Historical Fiction', 2003, '9781594631931', 4),
('The Book Thief', 'Markus Zusak', 'Historical Fiction', 2005, '9780375842207', 5),
('The Night Circus', 'Erin Morgenstern', 'Fantasy', 2011, '9780385534635', 3),
('The Light Between Oceans', 'M.L. Stedman', 'Historical Fiction', 2012, '9781451681734', 4),
('Circe', 'Madeline Miller', 'Fantasy', 2018, '9780316334754', 3),
('The Song of Achilles', 'Madeline Miller', 'Fantasy', 2011, '9780062060624', 5),
('Station Eleven', 'Emily St. John Mandel', 'Science Fiction', 2014, '9781447268972', 4),
('The Immortalists', 'Chloe Benjamin', 'Fiction', 2018, '9780735213180', 5),
('Where the Crawdads Sing', 'Delia Owens', 'Fiction', 2018, '9780735219090', 4),
('Educated', 'Tara Westover', 'Memoir', 2018, '9780399590504', 3),
('Becoming', 'Michelle Obama', 'Memoir', 2018, '9781524763138', 5),
('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'Non-fiction', 2011, '9780062316091', 4),
('The Body Keeps the Score', 'Bessel van der Kolk', 'Non-fiction', 2014, '9780670785933', 3),
('Thinking, Fast and Slow', 'Daniel Kahneman', 'Non-fiction', 2011, '9780374533557', 5),
('The 7 Habits of Highly Effective People', 'Stephen R. Covey', 'Self-help', 1989, '9780743269513', 3),
('Atomic Habits', 'James Clear', 'Self-help', 2018, '9780735211293', 4),
('How to Win Friends and Influence People', 'Dale Carnegie', 'Self-help', 1936, '9780671027031', 2),
('The Power of Habit', 'Charles Duhigg', 'Self-help', 2012, '9780812981605', 3),
('The Subtle Art of Not Giving a F*ck', 'Mark Manson', 'Self-help', 2016, '9780062457714', 5),
('You Are a Badass', 'Jen Sincero', 'Self-help', 2013, '9780762447695', 4),
('Daring Greatly', 'Brené Brown', 'Self-help', 2012, '9781592408412', 3),
('The Gifts of Imperfection', 'Brené Brown', 'Self-help', 2010, '9781592858491', 2),
('The 48 Laws of Power', 'Robert Greene', 'Non-fiction', 1998, '9780140280197', 4),
('The Art of War', 'Sun Tzu', 'Non-fiction', -500, '9781590302255', 3),
('Outliers: The Story of Success', 'Malcolm Gladwell', 'Non-fiction', 2008, '9780316017930', 5),
('The Tipping Point', 'Malcolm Gladwell', 'Non-fiction', 2000, '9780316346627', 4),
('Grit: The Power of Passion and Perseverance', 'Angela Duckworth', 'Non-fiction', 2016, '9781501111105', 3),
('The Lean Startup', 'Eric Ries', 'Business', 2011, '9780307887894', 4),
('Start with Why', 'Simon Sinek', 'Business', 2009, '9781591846444', 5),
('Good to Great', 'Jim Collins', 'Business', 2001, '9780066620992', 4),
('Drive: The Surprising Truth About What Motivates Us', 'Daniel H. Pink', 'Business', 2009, '9781594484803', 3),
('The Millionaire Next Door', 'Thomas J. Stanley', 'Business', 1996, '9780585089078', 2),
('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Business', 1997, '9781612680194', 4),
('The Intelligent Investor', 'Benjamin Graham', 'Finance', 1949, '9780060555665', 3),
('A Random Walk Down Wall Street', 'Burton G. Malkiel', 'Finance', 1973, '9780393352245', 5),
('The Barefoot Investor', 'Scott Pape', 'Finance', 2016, '9780143785804', 4),
('The Total Money Makeover', 'Dave Ramsey', 'Finance', 2003, '9780785289081', 3),
('The Millionaire Fastlane', 'MJ DeMarco', 'Finance', 2011, '9780984752400', 5),
('The Psychology of Money', 'Morgan Housel', 'Finance', 2020, '9780857195611', 4),
('The Book on Rental Property Investing', 'Brandon Turner', 'Finance', 2015, '9781947200002', 3),
('The Book on Managing Rental Properties', 'Brandon Turner', 'Finance', 2015, '9781947200057', 5),
('The Book on Estimating Rehab Costs', 'J. Scott', 'Finance', 2014, '9781947200125', 4),
('The Complete Guide to Flipping Properties', 'J. Scott', 'Finance', 2015, '9781947200163', 3),
('The Complete Guide to Real Estate Investing', 'Steve Berges', 'Finance', 2007, '9780470120601', 5),
('The ABCs of Real Estate Investing', 'Ken McElroy', 'Finance', 2004, '9781119508939', 4),
('Real Estate Investing for Dummies', 'Eric Tyson', 'Finance', 2009, '9780470432742', 3),
('The Essential Rumi', 'Rumi', 'Poetry', 1994, '9780062509588', 2),
('Milk and Honey', 'Rupi Kaur', 'Poetry', 2014, '9781449496364', 3),
('The Sun and Her Flowers', 'Rupi Kaur', 'Poetry', 2017, '9781449496401', 4),
('The Poetry of Robert Frost', 'Robert Frost', 'Poetry', 1969, '9780316769489', 2),
('The Complete Poems of Emily Dickinson', 'Emily Dickinson', 'Poetry', 1998, '9780316182505', 3),
('The Waste Land', 'T.S. Eliot', 'Poetry', 1922, '9780151218118', 5),
('Leaves of Grass', 'Walt Whitman', 'Poetry', 1855, '9780142428749', 4),
('The Collected Poems of W.B. Yeats', 'W.B. Yeats', 'Poetry', 1989, '9780684804612', 3),
('The Penguin Anthology of Twentieth-Century Poetry', 'Various', 'Anthology', 2011, '9780143039936', 2),
('The Essential Neruda: Selected Poems', 'Pablo Neruda', 'Poetry', 2004, '9780811215565', 5),
('The Complete Works of William Shakespeare', 'William Shakespeare', 'Drama', 1996, '9780812517395', 4),
('The Complete Works of Edgar Allan Poe', 'Edgar Allan Poe', 'Drama', 1998, '9780449002903', 3),
('The Complete Plays of Sophocles', 'Sophocles', 'Drama', 1994, '9780374528743', 2),
('The Complete Dramatic Works of Samuel Beckett', 'Samuel Beckett', 'Drama', 2006, '9780571225502', 5),
('The Complete Works of Anton Chekhov', 'Anton Chekhov', 'Drama', 2001, '9780192806954', 4),
('The Complete Works of Tennessee Williams', 'Tennessee Williams', 'Drama', 2004, '9780816630551', 3),
('The Collected Poems of Sylvia Plath', 'Sylvia Plath', 'Poetry', 2002, '9780060748327', 2),
('The Collected Poems of John Keats', 'John Keats', 'Poetry', 2007, '9780393962567', 5),
('The Collected Poems of John Milton', 'John Milton', 'Poetry', 1997, '9780140422093', 4),
('The Collected Poems of John Donne', 'John Donne', 'Poetry', 1994, '9780140421645', 3),
('The Collected Poems of T.S. Eliot', 'T.S. Eliot', 'Poetry', 2001, '9780140422642', 2),
('The Collected Poems of W.B. Yeats', 'W.B. Yeats', 'Poetry', 1997, '9780140421140', 5),
('The Collected Poems of Langston Hughes', 'Langston Hughes', 'Poetry', 1994, '9780688158831', 4),
('The Collected Poems of Robert Frost', 'Robert Frost', 'Poetry', 1998, '9780811212458', 3),
('The Collected Poems of Emily Dickinson', 'Emily Dickinson', 'Poetry', 1998, '9780316182505', 2),
('The Collected Poems of William Carlos Williams', 'William Carlos Williams', 'Poetry', 1994, '9780811215875', 5),
('The Collected Poems of Ezra Pound', 'Ezra Pound', 'Poetry', 1994, '9780811211464', 4),
('The Collected Poems of John Ashbery', 'John Ashbery', 'Poetry', 1994, '9780811212980', 3),
('The Collected Poems of Elizabeth Bishop', 'Elizabeth Bishop', 'Poetry', 1994, '9780811217342', 2)
ON DUPLICATE KEY UPDATE quantity_available = VALUES(quantity_available);

INSERT INTO Members (name, address, phone_number, email) VALUES
('Alice Johnson', '123 Main St', '555-1234', 'alice.johnson@example.com'),
('Bob Smith', '456 Elm St', '555-5678', 'bob.smith@example.com'),
('Charlie Brown', '789 Maple Ave', '555-8765', 'charlie.brown@example.com'),
('Diana Prince', '321 Oak St', '555-4321', 'diana.prince@example.com'),
('Ethan Hunt', '654 Pine St', '555-3456', 'ethan.hunt@example.com'),
('Fiona Apple', '135 Cedar St', '555-6543', 'fiona.apple@example.com'),
('George Costanza', '246 Birch St', '555-9876', 'george.costanza@example.com'),
('Hannah Montana', '369 Spruce St', '555-2584', 'hannah.montana@example.com'),
('Isaac Newton', '159 Willow St', '555-1472', 'isaac.newton@example.com'),
('Jessica Jones', '753 Walnut St', '555-3691', 'jessica.jones@example.com'),
('Karl Urban', '951 Oak St', '555-2837', 'karl.urban@example.com'),
('Lara Croft', '852 Birch St', '555-1094', 'lara.croft@example.com'),
('Mike Ross', '963 Elm St', '555-7849', 'mike.ross@example.com'),
('Nina Simone', '741 Maple Ave', '555-2346', 'nina.simone@example.com'),
('Oscar Wilde', '369 Cedar St', '555-1123', 'oscar.wilde@example.com'),
('Pam Beesly', '258 Oak St', '555-5468', 'pam.beesly@example.com'),
('Quentin Blake', '147 Willow St', '555-3789', 'quentin.blake@example.com'),
('Rachel Green', '951 Walnut St', '555-4783', 'rachel.green@example.com'),
('Steve Rogers', '753 Birch St', '555-6923', 'steve.rogers@example.com'),
('Tina Turner', '852 Pine St', '555-3478', 'tina.turner@example.com'),
('Zack Morris', '963 Cherry St', '555-8472', 'zack.morris@example.com'),
('Roger Adams', 'Address 22', '555-0022', 'email22@example.com'),
('Jack Adams', 'Address 23', '555-0023', 'email23@example.com');

INSERT INTO Borrows (member_id, book_id, borrow_date, due_date, return_date) VALUES
(1, 1, '2024-01-01', '2024-01-15', NULL),
(1, 2, '2024-01-05', '2024-01-19', '2024-01-17'),
(2, 3, '2024-01-02', '2024-01-16', NULL),
(2, 4, '2024-01-07', '2024-01-21', NULL),
(3, 5, '2024-01-03', '2024-01-17', NULL),
(3, 6, '2024-01-08', '2024-01-22', NULL),
(4, 7, '2024-01-04', '2024-01-18', '2024-01-15'),
(4, 8, '2024-01-09', '2024-01-23', NULL),
(5, 9, '2024-01-10', '2024-01-24', NULL),
(5, 10, '2024-01-11', '2024-01-25', NULL),
(6, 11, '2024-01-12', '2024-01-26', NULL),
(6, 12, '2024-01-13', '2024-01-27', NULL),
(7, 13, '2024-01-14', '2024-01-28', '2024-01-20'),
(7, 14, '2024-01-15', '2024-01-29', NULL),
(8, 15, '2024-01-16', '2024-01-30', NULL),
(9, 16, '2024-01-17', '2024-01-31', NULL),
(9, 17, '2024-01-18', '2024-02-01', NULL),
(10, 18, '2024-01-19', '2024-02-02', NULL),
(10, 19, '2024-01-20', '2024-02-03', NULL),
(11, 20, '2024-01-21', '2024-02-04', NULL),
(11, 21, '2024-01-22', '2024-02-05', NULL),
(12, 22, '2024-01-23', '2024-02-06', NULL),
(12, 23, '2024-01-24', '2024-02-07', NULL),
(13, 24, '2024-01-25', '2024-02-08', NULL),
(13, 25, '2024-01-26', '2024-02-09', NULL),
(14, 26, '2024-01-27', '2024-02-10', NULL),
(14, 27, '2024-01-28', '2024-02-11', NULL),
(15, 28, '2024-01-29', '2024-02-12', NULL),
(15, 29, '2024-01-30', '2024-02-13', NULL),
(16, 30, '2024-01-31', '2024-02-14', NULL),
(16, 31, '2024-02-01', '2024-02-15', NULL),
(17, 32, '2024-02-02', '2024-02-16', NULL),
(17, 33, '2024-02-03', '2024-02-17', NULL),
(18, 34, '2024-02-04', '2024-02-18', NULL),
(18, 35, '2024-02-05', '2024-02-19', NULL),
(19, 36, '2024-02-06', '2024-02-20', NULL),
(19, 37, '2024-02-07', '2024-02-21', NULL),
(20, 38, '2024-02-08', '2024-02-22', NULL),
(20, 39, '2024-02-09', '2024-02-23', NULL),
(21, 40, '2024-02-10', '2024-02-24', NULL),
(21, 41, '2024-02-11', '2024-02-25', NULL),
(22, 42, '2024-02-12', '2024-02-26', NULL),
(22, 43, '2024-02-13', '2024-02-27', NULL),
(23, 44, '2024-02-14', '2024-02-28', NULL),
(23, 45, '2024-02-15', '2024-02-29', NULL);




INSERT INTO Staff (name, role) VALUES
('John Doe', 'Librarian'),
('Mary Johnson', 'Assistant Librarian'),
('Robert Brown', 'Library Manager'),
('Emily Davis', 'Clerk'),
('Michael Wilson', 'Technician'),
('Sarah Miller', 'Volunteer'),
('David Anderson', 'Library Assistant'),
('Laura Thomas', 'Research Librarian'),
('James Jackson', 'Children’s Librarian'),
('Linda White', 'Reference Librarian'),
('Susan Harris', 'Outreach Coordinator'),
('William Martin', 'Cataloger'),
('Barbara Thompson', 'Head Librarian'),
('Joseph Garcia', 'Archivist'),
('Patricia Martinez', 'Event Coordinator');

INSERT INTO Fines (borrow_id, fine_amount, fine_date, payment_date) VALUES
(1, 0.50, '2024-01-16', NULL),
(2, 0.00, '2024-01-19', NULL),
(3, 1.00, '2024-01-17', '2024-01-18'),
(4, 0.00, '2024-01-21', NULL),
(5, 0.50, '2024-01-18', NULL),
(6, 0.00, '2024-01-22', NULL),
(7, 2.00, '2024-01-19', '2024-01-20'),
(8, 0.00, '2024-01-23', NULL),
(9, 0.50, '2024-01-24', NULL),
(10, 0.00, '2024-01-25', NULL),
(11, 1.50, '2024-01-26', NULL),
(12, 0.50, '2024-01-27', NULL),
(13, 1.00, '2024-01-28', '2024-01-29'),
(14, 0.00, '2024-01-29', NULL),
(15, 0.50, '2024-01-30', NULL),
(16, 1.00, '2024-01-31', NULL),
(17, 0.00, '2024-02-01', NULL),
(18, 0.50, '2024-02-02', NULL),
(19, 0.00, '2024-02-03', NULL),
(20, 0.50, '2024-02-04', '2024-02-05'),
(21, 1.00, '2024-02-05', NULL),
(22, 0.00, '2024-02-06', NULL),
(23, 2.00, '2024-02-07', '2024-02-08'),
(24, 0.00, '2024-02-08', NULL),
(25, 0.50, '2024-02-09', NULL),
(26, 1.50, '2024-02-10', NULL),
(27, 0.50, '2024-02-11', NULL),
(28, 1.00, '2024-02-12', '2024-02-13'),
(29, 0.00, '2024-02-13', NULL),
(30, 0.50, '2024-02-14', NULL),
(31, 1.00, '2024-02-15', NULL),
(32, 0.00, '2024-02-16', NULL),
(33, 2.00, '2024-02-17', '2024-02-18'),
(34, 0.00, '2024-02-18', NULL),
(35, 0.50, '2024-02-19', NULL),
(36, 1.50, '2024-02-20', NULL),
(37, 0.50, '2024-02-21', NULL),
(38, 1.00, '2024-02-22', '2024-02-23'),
(39, 0.00, '2024-02-23', NULL),
(40, 0.50, '2024-02-24', NULL),
(41, 1.00, '2024-02-25', NULL),
(42, 0.00, '2024-02-26', NULL),
(43, 2.00, '2024-02-27', '2024-02-28'),
(44, 0.00, '2024-02-28', NULL),
(45, 0.50, '2024-02-29', NULL);
-- Reviews data with different ratings and comments
INSERT INTO Reviews (book_id, member_id, rating, comment, review_date) VALUES
(1, 1, 5, 'An amazing classic that is still relevant today.', '2024-02-01'),
(3, 2, 4, 'A chilling dystopian vision. Great read.', '2024-02-03'),
(5, 4, 3, 'Enjoyable, but the plot could have been more engaging.', '2024-02-05'),
(7, 6, 2, 'Too long and hard to follow. Not my cup of tea.', '2024-02-08'),
(9, 8, 4, 'A beautiful adventure that sparks the imagination.', '2024-02-10'),
(11, 10, 5, 'A heart-wrenching story of loss and love.', '2024-02-12'),
(13, 12, 3, 'A bit slow-paced, but the themes were interesting.', '2024-02-14');


-- 2. Views
CREATE VIEW OverdueBooks AS
SELECT 
    b.book_id, 
    b.title, 
    m.name AS member_name, 
    bo.borrow_date, 
    bo.due_date
FROM 
    Books b
JOIN 
    Borrows bo ON b.book_id = bo.book_id
JOIN 
    Members m ON bo.member_id = m.member_id
WHERE 
    bo.due_date < CURDATE() AND bo.return_date IS NULL;
    
    CREATE VIEW MostPopularBooks AS
SELECT 
    b.book_id, 
    b.title, 
    COUNT(bo.borrow_id) AS borrow_count
FROM 
    Books b
JOIN 
    Borrows bo ON b.book_id = bo.book_id
GROUP BY 
    b.book_id, b.title
ORDER BY 
    borrow_count DESC;
    
CREATE VIEW MemberBorrowingHistory AS
SELECT 
    m.name AS member_name, 
    b.title, 
    bo.borrow_date, 
    bo.return_date
FROM 
    Members m
JOIN 
    Borrows bo ON m.member_id = bo.member_id
JOIN 
    Books b ON bo.book_id = b.book_id;
    
    CREATE VIEW BooksByGenre AS
SELECT 
    b.genre, 
    COUNT(*) AS book_count
FROM 
    Books b
GROUP BY 
    b.genre;
    
    CREATE VIEW MemberFines AS
SELECT 
    m.name AS member_name, 
    SUM(f.fine_amount) AS total_fines
FROM 
    Members m
JOIN 
    Borrows b ON m.member_id = b.member_id
JOIN 
    Fines f ON b.borrow_id = f.borrow_id
GROUP BY 
    m.member_id, m.name;
-- 3. Functions
DELIMITER //
CREATE FUNCTION TotalBooksBorrowedByMember(member_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total_books INT;
  SELECT COUNT(*) INTO total_books
  FROM Borrows
  WHERE member_id = member_id;
  RETURN total_books;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION TotalFinesForMember(member_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total_fines DECIMAL(10,2);
  SELECT SUM(fine_amount) INTO total_fines
  FROM Fines
  WHERE borrow_id IN (
    SELECT borrow_id FROM Borrows WHERE member_id = member_id
  );
  RETURN total_fines;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsBookAvailable(book_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
  DECLARE available BOOLEAN;
  SELECT (quantity_available > 0) INTO available
  FROM Books
  WHERE book_id = book_id;
  RETURN available;
END //
DELIMITER ;

-- 4. Stored Procedures
DELIMITER //
CREATE PROCEDURE AddMember(
    IN member_name VARCHAR(255),
    IN member_address VARCHAR(255),
    IN member_phone VARCHAR(20),
    IN member_email VARCHAR(100)
)
BEGIN
    INSERT INTO Members (name, address, phone_number, email)
    VALUES (member_name, member_address, member_phone, member_email);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE CheckoutBook(
    IN member_id INT,
    IN book_id INT,
    IN borrow_date DATE,
    IN due_date DATE
)
BEGIN
    DECLARE available_books INT;
    SELECT quantity_available INTO available_books
    FROM Books
    WHERE book_id = book_id;

    IF available_books > 0 THEN
        INSERT INTO Borrows (member_id, book_id, borrow_date, due_date)
        VALUES (member_id, book_id, borrow_date, due_date);
        UPDATE Books
        SET quantity_available = quantity_available - 1
        WHERE book_id = book_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Book is not available';
    END IF;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE ReturnBook(
    IN borrow_id INT,
    IN return_date DATE
)
BEGIN
    UPDATE Borrows
    SET return_date = return_date
    WHERE borrow_id = borrow_id;

    UPDATE Books
    SET quantity_available = quantity_available + 1
    WHERE book_id IN (
        SELECT book_id FROM Borrows WHERE borrow_id = borrow_id
    );
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE CalculateFines()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE borrow_id INT;
    DECLARE due_date DATE;
    DECLARE days_overdue INT;
    DECLARE fine_amount DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT borrow_id, due_date
        FROM Borrows
        WHERE return_date IS NULL AND due_date < CURDATE();

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO borrow_id, due_date;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate fine based on the number of overdue days
        SET days_overdue = DATEDIFF(CURDATE(), due_date);
        SET fine_amount = days_overdue * 0.5; -- Adjust the fine amount as needed

        INSERT INTO Fines (borrow_id, fine_amount, fine_date)
        VALUES (borrow_id, fine_amount, CURDATE());
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;

-- 5. Triggers
DELIMITER //
CREATE TRIGGER update_book_availability_on_checkout
AFTER INSERT ON Borrows
FOR EACH ROW
BEGIN
    UPDATE Books
    SET quantity_available = quantity_available - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER update_book_availability_on_return
AFTER UPDATE ON Borrows
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL THEN
        UPDATE Books
        SET quantity_available = quantity_available + 1
        WHERE book_id = NEW.book_id;
    END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER calculate_fine_on_return
AFTER UPDATE ON Borrows
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL AND NEW.return_date > NEW.due_date THEN
        INSERT INTO Fines (borrow_id, fine_amount, fine_date)
        VALUES (NEW.borrow_id, 
                DATEDIFF(NEW.return_date, NEW.due_date) * 0.5, 
                NEW.return_date);
    END IF;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER notify_overdue_books
AFTER UPDATE ON Borrows
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NULL AND CURDATE() > NEW.due_date THEN
        INSERT INTO Notifications (member_id, message, notification_date)
        VALUES (NEW.member_id, 'Your book is overdue', CURDATE());
    END IF;
END //
DELIMITER ;



