-- =====================================
-- Work Requirement 4 - SQLite Database
-- =====================================

-- Drop tables if they already exist
DROP TABLE IF EXISTS Quotes;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;

-- =========================
-- Create Tables
-- =========================

CREATE TABLE Authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    nationality TEXT,
    birth_year INTEGER
);

CREATE TABLE Books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    genre TEXT,
    published_year INTEGER,
    author_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES Authors(id)
);

CREATE TABLE Quotes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    quote_text TEXT NOT NULL,
    book_id INTEGER,
    author_id INTEGER,
    FOREIGN KEY (book_id) REFERENCES Books(id),
    FOREIGN KEY (author_id) REFERENCES Authors(id)
);

-- =========================
-- Insert Authors (5)
-- =========================

INSERT INTO Authors (name, nationality, birth_year) VALUES
('George Orwell', 'British', 1903),
('Jane Austen', 'British', 1775),
('Mark Twain', 'American', 1835),
('J.K. Rowling', 'British', 1965),
('Ernest Hemingway', 'American', 1899);

-- =========================
-- Insert Books (10)
-- =========================

INSERT INTO Books (title, genre, published_year, author_id) VALUES
('1984', 'Dystopian', 1949, 1),
('Animal Farm', 'Political Satire', 1945, 1),
('Pride and Prejudice', 'Romance', 1813, 2),
('Emma', 'Romance', 1815, 2),
('Adventures of Tom Sawyer', 'Fiction', 1876, 3),
('Harry Potter 1', 'Fantasy', 1997, 4),
('Harry Potter 2', 'Fantasy', 1998, 4),
('The Old Man and the Sea', 'Fiction', 1952, 5),
('A Farewell to Arms', 'War', 1929, 5),
('Sense and Sensibility', 'Romance', 1811, 2);

-- =========================
-- Insert Quotes (20)
-- =========================

INSERT INTO Quotes (quote_text, book_id, author_id) VALUES
('Big Brother is watching you.', 1, 1),
('All animals are equal.', 2, 1),
('It is a truth universally acknowledged.', 3, 2),
('I declare after all there is no enjoyment like reading.', 3, 2),
('The secret of getting ahead is getting started.', 5, 3),
('Fear of a name increases fear of the thing itself.', 6, 4),
('It matters not what someone is born.', 6, 4),
('Courage is grace under pressure.', 8, 5),
('Happiness can be found even in darkest times.', 7, 4),
('Some people never go crazy.', 8, 5),
('War is peace.', 1, 1),
('Ignorance is strength.', 1, 1),
('There is no charm equal to tenderness of heart.', 10, 2),
('Kindness is language which deaf can hear.', 5, 3),
('Books are uniquely portable magic.', 6, 4),
('The world breaks everyone.', 9, 5),
('Think only of the past as its remembrance gives pleasure.', 4, 2),
('Get busy living or get busy dying.', 8, 5),
('Not all those who wander are lost.', 6, 4),
('The best way to find yourself is to lose yourself.', 8, 5);

-- =========================
-- Required Queries
-- =========================

-- 1. List all books and number of quotes
SELECT Books.title, COUNT(Quotes.id) AS quote_count
FROM Books
LEFT JOIN Quotes ON Books.id = Quotes.book_id
GROUP BY Books.id;

-- 2. List all authors and number of quotes
SELECT Authors.name, COUNT(Quotes.id) AS quote_count
FROM Authors
LEFT JOIN Quotes ON Authors.id = Quotes.author_id
GROUP BY Authors.id;

-- 3. List all quotes from a specific book
SELECT Quotes.quote_text, Authors.name
FROM Quotes
JOIN Books ON Quotes.book_id = Books.id
JOIN Authors ON Quotes.author_id = Authors.id
WHERE Books.title = '1984';

-- 4. List all quotes from a specific author
SELECT Quotes.quote_text, Books.title
FROM Quotes
JOIN Authors ON Quotes.author_id = Authors.id
JOIN Books ON Quotes.book_id = Books.id
WHERE Authors.name = 'Jane Austen';