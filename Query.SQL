--1 create users table

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(100) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(50)
);


--2 create matches table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(400) NOT NULL CHECK (fixture LIKE '%vs%'),
    tournament_category VARCHAR(500) NOT NULL,
    base_ticket_price NUMERIC(10,2) NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(150) NOT NULL CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
);

--2 create bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    match_id INT NOT NULL,
    seat_number VARCHAR(50), 
    payment_status VARCHAR(100) CHECK (payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    total_cost NUMERIC(10,2) NOT NULL CHECK (total_cost >= 0),
    
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);