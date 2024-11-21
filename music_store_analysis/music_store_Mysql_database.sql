CREATE DATABASE music_store;

USE music_store;

CREATE TABLE album(
album_id INT NOT NULL,
title TEXT NOT NULL,
artist_id INT NOT NULL,
PRIMARY KEY(album_id));

ALTER TABLE album
ADD CONSTRAINT fk_artist
FOREIGN KEY (artist_id) REFERENCES artist(artist_id);


CREATE TABLE artist(
artist_id INT NOT NULL,
name TEXT NOT NULL,
PRIMARY KEY(artist_id));


CREATE TABLE employee(
employee_id INT NOT NULL,
last_name TEXT NOT NULL,
first_name TEXT NOT NULL,
title TEXT, 
reports_to INT,
levels TEXT NOT NULL,
birthdate DATETIME,
hire_date DATETIME,
address TEXT,
city TEXT,
state TEXT,
country TEXT,
postal_code TEXT,
phone TEXT,
fax TEXT,
email TEXT,
PRIMARY KEY (employee_id),
FOREIGN KEY (reports_to) REFERENCES employee(employee_id));


ALTER TABLE employee
ADD CONSTRAINT fk_reportsto
FOREIGN KEY (reports_to) REFERENCES employee(employee_id);


ALTER TABLE employee ADD PRIMARY KEY (employee_id);

CREATE INDEX idx_employee_id ON employee(employee_id);



CREATE TABLE customer (
    customer_id INT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    company TEXT, 
    address TEXT,
    city TEXT NOT NULL,
    state TEXT,
    country TEXT NOT NULL,
    postal_code TEXT,
    phone TEXT,
    fax TEXT,
    email TEXT,
    support_rep_id INT NOT NULL,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id));
    
    ALTER TABLE customer ADD PRIMARY KEY (customer_id);

ALTER TABLE customer
ADD CONSTRAINT fk_support_rep_id
FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id);

CREATE TABLE genre(
genre_id INT NOT NULL,
name TEXT,
PRIMARY KEY (genre_id) );

ALTER TABLE genre ADD PRIMARY KEY (genre_id);

CREATE TABLE invoice(
invoice_id INT NOT NULL,
customer_id INT NOT NULL,
invoice_date DATETIME,
billing_address TEXT,
billing_city TEXT NOT NULL,
billing_state TEXT,
billing_country TEXT,
billing_postal_code TEXT,
total DEC (10,2),
PRIMARY KEY (invoice_id),
FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

ALTER TABLE invoice
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE invoice ADD PRIMARY KEY (invoice_id);

CREATE TABLE invoice_line(
invoice_line_id INT NOT NULL,
invoice_id INT NOT NULL,
track_id INT NOT NULL,
unit_price DEC (10,2),
quantity INT NOT NULL,
PRIMARY KEY (invoice_line_id),
FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
FOREIGN KEY (track_id) REFERENCES track(track_id));

CREATE TABLE track(
track_id INT NOT NULL,
name TEXT,
album_id INT NOT NULL,
media_type_id INT NOT NULL,
genre_id INT NOT NULL,
composer TEXT,
milliseconds TEXT,
bytes TEXT,
unit_price DEC(10,2),
PRIMARY KEY (track_id),
FOREIGN KEY (album_id) REFERENCES album(album_id),
FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id));


CREATE TABLE media_type(
media_type_id INT NOT NULL,
name TEXT,
PRIMARY KEY (media_type_id));

CREATE TABLE playlist(
playlist_id INT NOT NULL,
name TEXT,
PRIMARY KEY (playlist_id));

CREATE TABLE playlist_track (
    playlist_id INT NOT NULL,
    track_id INT NOT NULL,
    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (track_id) REFERENCES track(track_id));


  




