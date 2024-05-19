Drop table books;
Drop table readers;
Drop table records;

CREATE TABLE books(
	id INT PRIMARY KEY NOT NULL,
	author TEXT ,
	title TEXT,
	publish_year INTEGER NOT NULL
);

INSERT INTO books
VALUES
    (1, 'John', 'название_1', strftime('%Y-%m-%d', '1988-02-14')),
    (2, 'Theodor', 'название_2', strftime('%Y-%m-%d', '1997-04-23')),
	(4, 'Das', 'название_4', strftime('%Y-%m-%d', '1968-06-25')),
    (3, 'Gimmi', 'название_3', strftime('%Y-%m-%d', '2012-02-07'));

CREATE TABLE readers(
	id INT PRIMARY KEY NOT NULL,
	name TEXT NOT NULL
);

INSERT INTO readers
VALUES
	(1, 'читатель_1'),
	(2, 'читатель_2'),
	(3, 'читатель_3'),
	(4, 'читатель_4'),
	(5, 'читатель_5'),
	(6, 'читатель_6');

CREATE TABLE records(
	reader_id INT NOT NULL,
	book_id INT NOT NULL,
	taking_date INT,
	returning_date INT,
	FOREIGN KEY (book_id) REFERENCES books (id),
	FOREIGN KEY (reader_id) REFERENCES readers (id)
);

INSERT INTO records
VALUES
	(1, 1, strftime('%Y-%m-%d', 'now'), strftime('%Y-%m-%d', 'now', '+24 days')),
	(1, 4, strftime('%Y-%m-%d', 'now', '-1 month'), strftime('%Y-%m-%d', 'now', '+1 days')),
	(3, 2, strftime('%Y-%m-%d', 'now', '-4 month'), strftime('%Y-%m-%d', 'now', '-1 month'));
	
SELECT book_id, title
FROM records
JOIN books ON book_id = id
WHERE returning_date >= strftime('%Y-%m-%d', 'now');

SELECT name, title
FROM records
INNER JOIN readers ON readers.id = records.reader_id
INNER JOIN books ON books.id = records.book_id;

SELECT author, COUNT(*) as book_count
FROM books
GROUP BY author;
