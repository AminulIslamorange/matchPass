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

--data insert into users table
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

--data insert into matches table
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

--data insert into bookings table
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);





------------------------------------------View All Table Data----------------------
select * from users;
select * from matches;
select * from bookings;


                  ---------------------Now Query Part------------------------
--query 1:


select match_id,fixture,base_ticket_price from matches
where tournament_category='Champions League' and match_status='Available';




---query 2:
select user_id,full_name,email from users
where full_name ILIKE 'Tanvir%' or full_name ILIKE '%Haque';




--query 3:
select booking_id,user_id,match_id, coalesce(payment_status,'Action Required')as symmetric_status from
  bookings
  where payment_status is null;




--query 4:

select bookings.booking_id,
  users.full_name,
  matches.fixture,
  bookings.total_cost from bookings
  inner join users on bookings.user_id=users.user_id
  inner join matches on bookings.match_id=matches.match_id;
  


--query 5:
select users.user_id,
  users.full_name,
  bookings.booking_id from users
  left join bookings on users.user_id=bookings.user_id;


-- query 6:
select booking_id,match_id,total_cost
  from bookings
  where total_cost >(select avg(total_cost) from bookings);







-- query 7:
select match_id,fixture,base_ticket_price from matches
order by base_ticket_price desc limit 2 offset 1;